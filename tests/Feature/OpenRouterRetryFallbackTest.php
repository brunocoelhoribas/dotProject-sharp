<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Http\Services\Traits\HandlesOpenRouterRequests;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Config;
use RuntimeException;

class OpenRouterRetryFallbackTest extends TestCase
{
    use HandlesOpenRouterRequests;

    public static $sleeps = [];

    protected function setUp(): void
    {
        parent::setUp();
        self::$sleeps = [];
        Http::preventStrayRequests();
    }

    public function test_successful_request_on_first_try()
    {
        Http::fake([
            'https://openrouter.ai/api/v1/chat/completions' => Http::response([
                'choices' => [
                    [
                        'message' => [
                            'content' => 'Hello World'
                        ]
                    ]
                ]
            ], 200)
        ]);

        Config::set('services.openrouter.fallback_models', ['fallback-1']);

        $response = $this->sendOpenRouterRequest('test-key', 'primary-model', ['messages' => []], 2);

        $this->assertEquals('Hello World', $response['choices'][0]['message']['content']);
        $this->assertEmpty(self::$sleeps);

        Http::assertSent(function ($request) {
            return $request->url() === 'https://openrouter.ai/api/v1/chat/completions'
                && $request['model'] === 'primary-model';
        });
    }

    public function test_retries_on_rate_limit_and_then_succeeds()
    {
        Http::fake([
            'https://openrouter.ai/api/v1/chat/completions' => Http::sequence()
                ->push([
                    'error' => [
                        'code' => 429,
                        'message' => 'Rate limit exceeded',
                        'metadata' => [
                            'retry_after_seconds' => 3
                        ]
                    ]
                ], 429, ['Retry-After' => '3'])
                ->push([
                    'choices' => [
                        [
                            'message' => [
                                'content' => 'Success after retry'
                            ]
                        ]
                    ]
                ], 200)
        ]);

        Config::set('services.openrouter.fallback_models', ['fallback-1']);

        $response = $this->sendOpenRouterRequest('test-key', 'primary-model', ['messages' => []], 2);

        $this->assertEquals('Success after retry', $response['choices'][0]['message']['content']);
        $this->assertCount(1, self::$sleeps);
        $this->assertEquals(3, self::$sleeps[0]);
    }

    public function test_falls_back_to_next_model_when_primary_exhausted()
    {
        Http::fake([
            'https://openrouter.ai/api/v1/chat/completions' => Http::sequence()
                ->push([
                    'error' => [
                        'code' => 429,
                        'message' => 'Primary model rate-limited'
                    ]
                ], 429)
                ->push([
                    'error' => [
                        'code' => 429,
                        'message' => 'Primary model rate-limited again'
                    ]
                ], 429)
                ->push([
                    'choices' => [
                        [
                            'message' => [
                                'content' => 'Success on fallback'
                            ]
                        ]
                    ]
                ], 200)
        ]);

        Config::set('services.openrouter.fallback_models', ['fallback-model-1']);

        $response = $this->sendOpenRouterRequest('test-key', 'primary-model', ['messages' => []], 1);

        $this->assertEquals('Success on fallback', $response['choices'][0]['message']['content']);
        
        Http::assertSent(function ($request) {
            static $calls = 0;
            $calls++;
            if ($calls === 1 || $calls === 2) {
                return $request['model'] === 'primary-model';
            }
            if ($calls === 3) {
                return $request['model'] === 'fallback-model-1';
            }
            return false;
        });
    }

    public function test_fails_entirely_when_all_models_fail()
    {
        Http::fake([
            'https://openrouter.ai/api/v1/chat/completions' => Http::sequence()
                ->push(['error' => ['code' => 429, 'message' => 'Error P1']], 429)
                ->push(['error' => ['code' => 429, 'message' => 'Error P2']], 429)
                ->push(['error' => ['message' => 'Error F1']], 502)
                ->push(['error' => ['message' => 'Error F2']], 502)
        ]);

        Config::set('services.openrouter.fallback_models', ['fallback-model']);

        $this->expectException(RuntimeException::class);
        $this->expectExceptionMessage('Erro na IA:');

        $this->sendOpenRouterRequest('test-key', 'primary-model', ['messages' => []], 1);
    }
}

namespace App\Http\Services\Traits;

function sleep($seconds) {
    \Tests\Feature\OpenRouterRetryFallbackTest::$sleeps[] = $seconds;
}

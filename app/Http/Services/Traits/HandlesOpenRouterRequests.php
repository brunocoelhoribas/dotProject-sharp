<?php

namespace App\Http\Services\Traits;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Exception;
use RuntimeException;

trait HandlesOpenRouterRequests {
    /**
     * Send request to OpenRouter with automatic retry and fallback.
     *
     * @param string $apiKey
     * @param string $primaryModel
     * @param array $payload
     * @param int $maxRetriesPerModel
     * @return array
     * @throws RuntimeException
     */
    protected function sendOpenRouterRequest(string $apiKey, string $primaryModel, array $payload, int $maxRetriesPerModel = 1): array {
        @set_time_limit(60);

        $fallbackModels = config('services.openrouter.fallback_models', []);
        $models = array_merge([$primaryModel], $fallbackModels);
        $models = array_values(array_unique(array_filter($models)));

        $lastError = 'Nenhum modelo disponível para processamento.';

        foreach ($models as $modelIndex => $model) {
            $currentPayload = $payload;
            $currentPayload['model'] = $model;

            // Only retry the primary model. For fallbacks, do not retry (0 retries / 1 attempt) to prevent long delays.
            $currentMaxRetries = ($modelIndex === 0) ? $maxRetriesPerModel : 0;

            for ($attempt = 1; $attempt <= $currentMaxRetries + 1; $attempt++) {
                try {
                    Log::info("Enviando requisição OpenRouter usando modelo: {$model} (Tentativa {$attempt} de " . ($currentMaxRetries + 1) . ")");

                    $response = Http::withoutVerifying()
                        ->withHeaders([
                            'HTTP-Referer' => 'http://localhost',
                            'X-OpenRouter-Title' => 'dotProject+ 2025',
                        ])
                        ->withToken($apiKey)
                        ->timeout(30)
                        ->post('https://openrouter.ai/api/v1/chat/completions', $currentPayload);

                    $statusCode = $response->status();
                    $body = $response->body();
                    $data = $response->json();

                    $isRateLimitOrProviderError = false;
                    $retryAfter = 2; // Tempo de espera padrão em segundos

                    // 1. Verificar código de status HTTP
                    if ($statusCode === 429 || in_array($statusCode, [502, 503, 504])) {
                        $isRateLimitOrProviderError = true;
                        $headerRetry = $response->header('Retry-After');
                        if (is_numeric($headerRetry)) {
                            $retryAfter = (int)$headerRetry;
                        }
                    }

                    // 2. Verificar se a API do OpenRouter retornou um erro estruturado no corpo (mesmo com status 200 ou 400)
                    if (is_array($data) && isset($data['error'])) {
                        $errorCode = $data['error']['code'] ?? null;
                        $errorMessage = $data['error']['message'] ?? '';
                        
                        if ($errorCode === 429 || 
                            str_contains(strtolower($errorMessage), 'rate-limit') || 
                            str_contains(strtolower($errorMessage), 'rate_limit') || 
                            str_contains(strtolower($errorMessage), 'rate limited') ||
                            str_contains(strtolower($errorMessage), 'provider returned error') ||
                            str_contains(strtolower($errorMessage), 'upstream')
                        ) {
                            $isRateLimitOrProviderError = true;

                            // Tentar obter o tempo de retry sugerido pelo OpenRouter / Provedor upstream
                            $metadata = $data['error']['metadata'] ?? [];
                            if (isset($metadata['retry_after_seconds'])) {
                                $retryAfter = (int)ceil((float)$metadata['retry_after_seconds']);
                            } elseif (isset($metadata['headers']['Retry-After'])) {
                                $retryAfter = (int)$metadata['headers']['Retry-After'];
                            }
                        }
                    }

                    if ($isRateLimitOrProviderError) {
                        $errorMsg = is_array($data) && isset($data['error']['message']) ? $data['error']['message'] : $body;
                        $lastError = "Modelo {$model} retornou erro temporário / limite (Status {$statusCode}): {$errorMsg}";
                        
                        Log::warning("OpenRouter rate limit ou erro de provedor no modelo {$model}. " . $lastError);

                        if ($attempt <= $currentMaxRetries) {
                            $sleepTime = max(1, min($retryAfter, 5)); // Limitar sleep entre 1 e 5 segundos
                            Log::info("Aguardando {$sleepTime} segundos antes de tentar novamente...");
                            sleep($sleepTime);
                            continue;
                        } else {
                            Log::warning("Máximo de tentativas esgotadas para o modelo {$model}. Tentando próximo modelo de fallback...");
                            break; // Sai do loop de retentativas para tentar o próximo modelo
                        }
                    }

                    // 3. Verificar outros erros que não são temporários/rate limit
                    if (!$response->successful()) {
                        throw new RuntimeException("OpenRouter API retornou erro HTTP {$statusCode}: {$body}");
                    }

                    if (is_array($data) && isset($data['error'])) {
                        throw new RuntimeException("OpenRouter API retornou erro: " . json_encode($data['error']));
                    }

                    // Resposta com sucesso!
                    Log::info("Requisição OpenRouter concluída com sucesso usando o modelo: {$model}");
                    return $data;

                } catch (Exception $e) {
                    $lastError = "Exceção ao chamar modelo {$model}: " . $e->getMessage();
                    Log::error($lastError);

                    if ($attempt <= $currentMaxRetries) {
                        Log::info("Aguardando 2 segundos antes de tentar novamente devido a exceção...");
                        sleep(2);
                        continue;
                    } else {
                        Log::warning("Máximo de tentativas esgotadas para o modelo {$model} devido a exceções. Tentando próximo modelo de fallback...");
                        break;
                    }
                }
            }
        }

        // Se chegou até aqui, nenhum modelo funcionou
        throw new RuntimeException("Erro na IA: " . $lastError);
    }
}

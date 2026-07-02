<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\User\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;

class ChatControllerTest extends TestCase
{
    use DatabaseTransactions;

    public function test_guest_is_redirected_to_login()
    {
        $response = $this->postJson(route('chat.assistant'), [
            'message' => 'Hello',
        ]);

        // Laravel auth middleware returns 401 Unauthorized for JSON requests, or redirects for regular requests
        $response->assertStatus(401);
    }

    public function test_authenticated_user_validation_fails_for_empty_message()
    {
        $user = User::where('user_username', 'admin')->first() ?? User::first();

        $response = $this->actingAs($user)->postJson(route('chat.assistant'), [
            'message' => '',
        ]);

        $response->assertStatus(422);
        $response->assertJsonValidationErrors(['message']);
    }
}

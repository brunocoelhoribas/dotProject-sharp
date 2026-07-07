<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use OpenAI\Laravel\Facades\OpenAI;
use Throwable;

class TestOllama extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'ollama:test {model=llama3.2 : The name of the local Ollama model to test}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Test the local Ollama integration via OpenAI client';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $model = $this->argument('model');
        
        $this->info("Pinging local Ollama instance at " . config('openai.base_uri') . "...");
        $this->info("Using model: {$model}");
        $this->info("Prompt: 'Say hello in one short sentence.'");
        $this->newLine();

        try {
            $result = OpenAI::chat()->create([
                'model' => $model,
                'messages' => [
                    ['role' => 'user', 'content' => 'Say hello in one short sentence.'],
                ],
            ]);

            $this->info("Response from Ollama:");
            $this->line($result->choices[0]->message->content);
            
            $this->newLine();
            $this->info('✅ Ollama integration is working perfectly!');

        } catch (Throwable $e) {
            $this->error("Failed to connect or generate response from Ollama.");
            $this->error($e->getMessage());
            
            $this->newLine();
            $this->warn("Troubleshooting steps:");
            $this->warn("1. Make sure Ollama is installed and running on your machine.");
            $this->warn("2. Make sure you have downloaded the model by running 'ollama pull {$model}' in your terminal.");
        }
    }
}

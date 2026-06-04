<?php

namespace App\Http\Services;

use App\Models\Project\Project;
use App\Models\Project\ProjectWbsItem;
use App\Models\Project\Task\Task;
use App\Models\Project\Task\TasksWorkpackage;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;
use Exception;
use RuntimeException;
use Throwable;

class AiWbsGeneratorService {
    /**
     * @throws Throwable
     */
    public function generateForProject(Project $project): void {
        $apiKey = config('services.nvidia_api.key');

        if (!$apiKey) {
            throw new RuntimeException('Chave da API da NVIDIA não configurada no arquivo .env.');
        }

        $locale = app()->getLocale();

        $languageMap = [
            'en' => 'Inglês (English)',
            'es' => 'Espanhol (Español)',
            'pt_BR' => 'Português do Brasil'
        ];

        $targetLanguage = $languageMap[$locale] ?? 'Português';

        $context = "
            Você é um gerente de projetos especialista em criar Estruturas Analíticas de Projeto (EAP/WBS).
            Crie a EAP para o seguinte projeto:
            Nome: {$project->project_name}
            Descrição: {$project->project_description}

            REGRA CRÍTICA DE IDIOMA: Todo o conteúdo gerado (os nomes das fases e tarefas) DEVE ser escrito estritamente no idioma: {$targetLanguage}.
            As chaves do JSON ('name', 'tasks', 'duration') NÃO devem ser traduzidas.

            Retorne APENAS um array JSON válido. O JSON deve seguir EXATAMENTE esta estrutura de exemplo:
            [
              {
                \"name\": \"[Nome da Fase no idioma {$targetLanguage}]\",
                \"tasks\": [
                  {\"name\": \"[Nome da Tarefa no idioma {$targetLanguage}]\", \"duration\": 5},
                  {\"name\": \"[Nome de outra Tarefa]\", \"duration\": 3}
                ]
              }
            ]
        ";

        $url = "https://integrate.api.nvidia.com/v1/chat/completions";

        $response = Http::withToken($apiKey)->post($url, [
            'model' => 'nvidia/nemotron-3-ultra-550b-a55b',
            'messages' => [
                [
                    'role' => 'system',
                    'content' => 'Você é uma API. Retorne APENAS o JSON puro. Não use blocos de código markdown, não diga "Aqui está", não explique nada.'
                ],
                [
                    'role' => 'user',
                    'content' => $context
                ]
            ],
            'temperature' => 0.2,
            'max_tokens' => 2048,
        ]);

        if (!$response->successful()) {
            throw new RuntimeException('Falha ao comunicar com a API da NVIDIA: ' . $response->body());
        }

        $content = $response->json('choices.0.message.content');
        $content = preg_replace('/```json\s*/i', '', $content);
        $content = preg_replace('/```\s*/', '', $content);
        $content = trim($content);

        $eapData = json_decode($content, true, 512, JSON_THROW_ON_ERROR);

        if (!is_array($eapData)) {
            throw new RuntimeException('A IA não retornou um formato JSON válido. Resposta recebida: ' . $content);
        }

        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new RuntimeException('A IA não retornou um formato JSON válido. Resposta recebida: ' . $content);
        }

        $this->saveWbsToDatabase($project, $eapData);
    }

    /**
     * @throws Throwable
     */
    private function saveWbsToDatabase(Project $project, array $eapData): void {
        DB::transaction(static function () use ($project, $eapData) {
            $sortOrder = 1;

            foreach ($eapData as $index => $wbsGroup) {
                $wbsNumber = (string)($index + 1);

                $wbsItem = ProjectWbsItem::create([
                    'project_id' => $project->project_id,
                    'item_name' => $wbsGroup['name'],
                    'number' => $wbsNumber,
                    'sort_order' => $sortOrder++,
                    'is_leaf' => 0,
                    'identation' => '',
                ]);

                if (isset($wbsGroup['tasks']) && is_array($wbsGroup['tasks'])) {
                    $taskOrder = 1;

                    foreach ($wbsGroup['tasks'] as $taskData) {
                        $task = Task::create([
                            'task_project' => $project->project_id,
                            'task_name' => $taskData['name'],
                            'task_owner' => auth()->id(),
                            'task_start_date' => $project->project_start_date ?? now(),
                            'task_end_date' => ($project->project_start_date ?? now())->addDays($taskData['duration'] ?? 1),
                            'task_duration' => $taskData['duration'] ?? 1,
                            'task_duration_type' => 24,
                            'task_status' => 0,
                            'task_priority' => 0,
                            'task_percent_complete' => 0,
                            'task_order' => $taskOrder++,
                        ]);

                        TasksWorkpackage::create([
                            'task_id' => $task->task_id,
                            'eap_item_id' => $wbsItem->id
                        ]);
                    }
                }
            }
        });
    }
}

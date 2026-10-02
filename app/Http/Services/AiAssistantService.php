<?php

namespace App\Http\Services;

use App\Models\Project\Project;
use App\Models\Company\Company;
use App\Models\Project\Task\Task;
use Exception;
use JsonException;
use RuntimeException;
use OpenAI\Laravel\Facades\OpenAI;

class AiAssistantService {
    /**
     * @throws Exception
     * @throws JsonException
     */
    public function askProjectAssistant(?Project $currentProject, string $userMessage, array $chatHistory = []): string {
        $model = config('openai.model', env('OLLAMA_MODEL', 'llama3.2'));

        $locale = app()->getLocale();
        $languageMap = [
            'en' => 'Inglês (English)',
            'es' => 'Espanhol (Español)',
            'pt_BR' => 'Português do Brasil'
        ];
        $targetLanguage = $languageMap[$locale] ?? 'Português do Brasil';

        $countCompanies = Company::count();
        $countProjects  = Project::count();

        $statusCounts = Project::selectRaw('project_status, count(*) as total')
            ->groupBy('project_status')
            ->pluck('total', 'project_status')
            ->toArray();

        // Contexto global mínimo — apenas métricas, sem listagem de projetos
        $contextParts = [
            "Empresas: $countCompanies",
            "Projetos: $countProjects",
            "Status(0=proposta,1=aberto,2=andamento,3=pausa,4=concluido,5=cancelado): " . json_encode($statusCounts),
        ];

        if ($currentProject) {
            $currentProject->load(['company:company_id,company_name', 'owner.contact:contact_id,contact_first_name']);

            $tasks = Task::where('task_project', $currentProject->project_id)
                ->select('task_name', 'task_status', 'task_percent_complete', 'task_end_date')
                ->limit(8)
                ->get()
                ->map(fn ($t) => "{$t->task_name} (status:{$t->task_status} {$t->task_percent_complete}%)")
                ->join('; ');

            $contextParts[] = "PROJETO ATUAL: id={$currentProject->project_id}"
                . " nome=\"{$currentProject->project_name}\""
                . " empresa=\"{$currentProject->company?->company_name}\""
                . " responsavel=\"{$currentProject->owner?->contact?->contact_first_name}\""
                . " status={$currentProject->project_status}"
                . " progresso={$currentProject->project_percent_complete}%"
                . " orcamento={$currentProject->project_target_budget}"
                . " descricao=\"{$currentProject->project_description}\"";
            $contextParts[] = "TAREFAS DO PROJETO ATUAL: $tasks";
        }

        $contextBlock = implode("\n", $contextParts);

        $systemPrompt = "Você é um assistente PMO do sistema dotProject#. Responda SEMPRE em $targetLanguage, de forma direta e concisa (máximo 3 parágrafos ou 5 itens de lista). Use Markdown. Não invente dados.\n\nDADOS DO SISTEMA:\n$contextBlock";

        $messages = [
            [
                'role' => 'system', 'content' => $systemPrompt
            ]
        ];

        // Limita o histórico às últimas 4 mensagens para manter a inferência rápida na CPU
        $recentHistory = array_slice($chatHistory, -4);
        foreach ($recentHistory as $msg) {
            if (!empty($msg['role']) && !empty($msg['content'])) {
                $messages[] = ['role' => $msg['role'], 'content' => $msg['content']];
            }
        }

        $messages[] = ['role' => 'user', 'content' => $userMessage];

        try {
            $response = OpenAI::chat()->create([
                'model' => $model,
                'messages' => $messages,
                'temperature' => 0.4,
                'max_tokens' => 350,
            ]);

            return $response->choices[0]->message->content ?? '';
        } catch (Exception $e) {
            throw new RuntimeException("Erro ao conectar com a IA local (Ollama): " . $e->getMessage());
        }
    }
}

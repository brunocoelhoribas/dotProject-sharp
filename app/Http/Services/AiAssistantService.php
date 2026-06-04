<?php

namespace App\Http\Services;

use App\Models\Project\Project;
use App\Models\Company\Company;
use App\Models\Project\Task\Task;
use Illuminate\Http\Client\ConnectionException;
use Illuminate\Support\Facades\Http;
use Exception;
use JsonException;
use RuntimeException;

class AiAssistantService {
    /**
     * @throws ConnectionException
     * @throws JsonException
     */
    public function askProjectAssistant(?Project $currentProject, string $userMessage, array $chatHistory = []): string {
        $apiKey = config('services.nvidia_api.key');

        if (!$apiKey) {
            throw new RuntimeException('Chave da API da NVIDIA não configurada.');
        }

        $locale = app()->getLocale();
        $languageMap = [
            'en' => 'Inglês (English)',
            'es' => 'Espanhol (Español)',
            'pt_BR' => 'Português do Brasil'
        ];
        $targetLanguage = $languageMap[$locale] ?? 'Português do Brasil';

        $companies = Company::select('company_id', 'company_name')->get();

        $allProjects = Project::select(
            'project_id',
            'project_name',
            'project_status',
            'project_company',
            'project_target_budget',
            'project_percent_complete'
        )
            ->with(['company:company_id,company_name', 'owner.contact:contact_id,contact_first_name'])
            ->get();

        $systemContext = [
            'countCompanies' => $companies->count(),
            'companies' => $companies->toArray(),
            'countProjects' => $allProjects->count(),
            'projectsSummary' => $allProjects->toArray(),
        ];

        if ($currentProject) {
            $currentProject->load(['owner.contact']);

            $projectData = $currentProject->toArray();
            $projectData['tasks'] = Task::where('task_project', $currentProject->project_id)->get()->toArray();
            $systemContext['projeto_atual_visualizado'] = $projectData;
        }

        $contextJson = json_encode($systemContext, JSON_THROW_ON_ERROR);

        $systemPrompt = "
            Você é um assistente de Inteligência Artificial Especialista em Gerenciamento de Projetos (PMO) integrado ao sistema dotProject+.
            Você tem conhecimento global sobre todas as empresas e projetos do sistema.

            REGRA CRÍTICA DE IDIOMA: Você DEVE se comunicar e responder a todas as perguntas estritamente no idioma: $targetLanguage.
            Mesmo se o usuário digitar uma pergunta em outro idioma, traduza internamente e responda sempre em $targetLanguage.

            Aqui estão os dados reais e atuais do banco de dados do sistema para você usar como base:
            $contextJson

            Suas regras de comportamento:
            - Seja direto, profissional e prestativo.
            - Se o usuário perguntar sobre o 'projeto atual', consulte a chave 'currentProject'.
            - Se perguntar sobre outros projetos ou visão geral, use a chave 'projectsSummary'.
            - Não invente dados. Se não estiver no JSON de contexto, diga que você ainda não tem acesso a essa informação.
            - Use formatação Markdown (negrito, listas) para tornar a leitura fácil no chat.
        ";

        $messages = [
            [
                'role' => 'system', 'content' => $systemPrompt
            ]
        ];

        foreach ($chatHistory as $msg) {
            $messages[] = ['role' => $msg['role'], 'content' => $msg['content']];
        }

        $messages[] = ['role' => 'user', 'content' => $userMessage];

        $response = Http::withoutVerifying()
            ->withToken($apiKey)
            ->post('https://integrate.api.nvidia.com/v1/chat/completions', [
                'model' => 'nvidia/nemotron-3-ultra-550b-a55b',
                'messages' => $messages,
                'temperature' => 0.4,
                'max_tokens' => 1024,
            ]);

        if (!$response->successful()) {
            throw new RuntimeException('Erro na IA: ' . $response->body());
        }

        return $response->json('choices.0.message.content');
    }
}

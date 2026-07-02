<?php

namespace App\Http\Controllers;

use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use App\Models\Project\Project;
use App\Http\Services\AiAssistantService;

class ChatController extends Controller {
    public function chatWithAssistant(Request $request, AiAssistantService $aiService): ?JsonResponse {
        $request->validate([
            'message' => 'required|string',
            'history' => 'nullable|array',
            'project_id' => 'nullable|integer'
        ]);

        try {
            $projectId = $request->input('project_id');
            $project = $projectId ? Project::find($projectId) : null;

            $reply = $aiService->askProjectAssistant(
                $project,
                $request->input('message'),
                $request->input('history', [])
            );

            return response()->json(['reply' => $reply]);

        } catch (Exception $e) {
            return response()->json(['error' => 'Erro ao processar a resposta: ' . $e->getMessage()], 500);
        }
    }
}

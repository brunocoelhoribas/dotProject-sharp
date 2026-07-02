<?php

namespace App\Http\Controllers\Cost;

use App\Http\Controllers\Controller;
use App\Models\Project\Project;
use App\Models\Planning\Cost\Cost;
use Illuminate\Contracts\View\View;
use Illuminate\Http\JsonResponse;
use Carbon\Carbon;

class CostController extends Controller {
    public function index(): View {
        $projects = Project::with('company')->orderBy('project_name')->get();

        $projectsWithCosts = $projects->map(function ($project) {
            $costs = Cost::where('cost_project_id', $project->project_id)->get();

            $totalHr = $costs->whereNotNull('cost_human_resource_id')->sum('cost_value_total');
            $totalNonHr = $costs->whereNull('cost_human_resource_id')->sum('cost_value_total');

            $project->total_hr_costs = $totalHr;
            $project->total_non_hr_costs = $totalNonHr;
            $project->total_costs = $totalHr + $totalNonHr;

            return $project;
        });

        return view('costs.index', [
            'projects' => $projectsWithCosts
        ]);
    }

    public function getProjectSCurve(Project $project): JsonResponse {
        $costs = Cost::where('cost_project_id', $project->project_id)
            ->whereNotNull('cost_date_begin')
            ->orderBy('cost_date_begin')
            ->get();

        if ($costs->isEmpty()) {
            return response()->json(['error' => 'no_data']);
        }

        $groupedCosts = [];

        foreach ($costs as $cost) {
            $ym = Carbon::parse($cost->cost_date_begin)->format('Y-m');
            if (!isset($groupedCosts[$ym])) {
                $groupedCosts[$ym] = 0;
            }
            $groupedCosts[$ym] += $cost->cost_value_total;
        }

        ksort($groupedCosts);

        $labels = [];
        $data = [];
        $cumulative = 0;

        foreach ($groupedCosts as $ym => $value) {
            $labels[] = Carbon::createFromFormat('Y-m', $ym)->format('m/Y');
            $cumulative += $value;
            $data[] = $cumulative;
        }

        return response()->json([
            'labels' => $labels,
            'data' => $data,
            'targetBudget' => $project->project_target_budget ?? 0
        ]);
    }
}

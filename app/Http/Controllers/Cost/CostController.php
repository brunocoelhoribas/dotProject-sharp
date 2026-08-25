<?php

namespace App\Http\Controllers\Cost;

use App\Http\Controllers\Controller;
use App\Models\Project\Project;
use App\Models\Planning\Cost\Cost;
use Illuminate\Contracts\View\View;
use Illuminate\Http\JsonResponse;
use Carbon\Carbon;

use App\Models\Company\Company;
use Illuminate\Http\Request;

class CostController extends Controller {
    public function index(Request $request): View {
        $query = Project::with('company');

        if ($request->filled('search')) {
            $query->where('project_name', 'LIKE', '%' . $request->input('search') . '%');
        }

        if ($request->filled('company')) {
            $query->where('project_company', $request->input('company'));
        }

        $projects = $query->orderBy('project_name')->paginate(15)->appends($request->query());

        // Attach calculated costs dynamically to the paginated collection
        $projects->getCollection()->transform(function ($project) {
            $costs = Cost::where('cost_project_id', $project->project_id)->get();

            $totalHr = $costs->whereNotNull('cost_human_resource_id')->sum('cost_value_total');
            $totalNonHr = $costs->whereNull('cost_human_resource_id')->sum('cost_value_total');

            $project->total_hr_costs = $totalHr;
            $project->total_non_hr_costs = $totalNonHr;
            $project->total_costs = $totalHr + $totalNonHr;

            return $project;
        });

        $companies = Company::orderBy('company_name')->pluck('company_name', 'company_id');

        return view('costs.index', [
            'projects' => $projects,
            'companies' => $companies,
            'filterSearch' => $request->input('search'),
            'filterCompany' => $request->input('company'),
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

<?php

namespace App\Http\Services;

use App\Models\Company\Company;
use App\Models\Project\Project;
use App\Models\User\User;
use Carbon\Carbon;
use Carbon\CarbonPeriod;

class DashboardService {
    public function getDashboardData(array $filters = []): array {
        return [
            'kpis' => $this->getKpis($filters),
            'statusChart' => $this->getStatusChartData($filters),
            'timelineChart' => $this->getTimelineChartData($filters),
            'latestProjects' => $this->getLatestProjects($filters),
        ];
    }

    private function applyProjectFilters($query, array $filters) {
        return $query
            ->when(!empty($filters['company_id']), function ($q) use ($filters) {
                $q->where('project_company', $filters['company_id']);
            })
            ->when(!empty($filters['date_from']), function ($q) use ($filters) {
                $q->where('project_start_date', '>=', $filters['date_from']);
            })
            ->when(!empty($filters['date_to']), function ($q) use ($filters) {
                $q->where('project_start_date', '<=', $filters['date_to']);
            });
    }

    private function getKpis(array $filters): array {
        $companiesCount = Company::count();
        $usersCount = User::count();

        $projectQuery = Project::where('project_status', '!=', 7);
        $projectQuery = $this->applyProjectFilters($projectQuery, $filters);

        return [
            'companies' => $companiesCount,
            'users' => $usersCount,
            'active_projects' => $projectQuery->count(),
            'avg_completion' => round($projectQuery->avg('project_percent_complete') ?? 0),
        ];
    }

    private function getStatusChartData(array $filters): array {
        $query = Project::selectRaw('project_status, count(*) as total')->groupBy('project_status');
        $query = $this->applyProjectFilters($query, $filters);

        $projectsByStatus = $query->pluck('total', 'project_status')->toArray();

        $statusMap = [
            0 => 'Não Definido', 1 => 'Proposto', 2 => 'Planejamento',
            3 => 'Em Andamento', 4 => 'Em Espera', 5 => 'Concluído', 7 => 'Arquivado'
        ];

        $labels = [];
        $data = [];
        foreach ($projectsByStatus as $status => $total) {
            $labels[] = $statusMap[$status] ?? "Status $status";
            $data[] = $total;
        }

        return ['labels' => $labels, 'data' => $data];
    }

    private function getTimelineChartData(array $filters): array {
        $startDate = !empty($filters['date_from']) ? Carbon::parse($filters['date_from']) : now()->subMonths(5)->startOfMonth();
        $endDate = !empty($filters['date_to']) ? Carbon::parse($filters['date_to']) : now()->endOfMonth();

        $period = CarbonPeriod::create($startDate, '1 month', $endDate);
        $monthsList = [];
        foreach ($period as $date) {
            $monthsList[$date->format('Y-m')] = 0;
        }

        $query = Project::whereNotNull('project_start_date')
            ->whereBetween('project_start_date', [$startDate, $endDate])
            ->selectRaw('DATE_FORMAT(project_start_date, "%Y-%m") as month, count(*) as total')
            ->groupBy('month');

        $query = $this->applyProjectFilters($query, $filters);
        $projectsByMonth = $query->pluck('total', 'month')->toArray();

        $finalData = array_merge($monthsList, $projectsByMonth);

        return [
            'labels' => array_map(static fn($m) => Carbon::createFromFormat('Y-m', $m)->translatedFormat('M/Y'), array_keys($finalData)),
            'data' => array_values($finalData)
        ];
    }

    private function getLatestProjects(array $filters) {
        $query = Project::with('company')->orderBy('project_start_date', 'desc')->limit(5);
        $query = $this->applyProjectFilters($query, $filters);
        return $query->get();
    }
}

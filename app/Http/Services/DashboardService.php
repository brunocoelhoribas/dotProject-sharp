<?php

namespace App\Http\Services;

use App\Models\Company\Company;
use App\Models\Project\Project;
use App\Models\User\User;
use Carbon\Carbon;
use Carbon\CarbonPeriod;
use Illuminate\Support\Facades\DB;

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
        $pQuery = Project::selectRaw('project_status, count(*) as total')->groupBy('project_status');
        $pQuery = $this->applyProjectFilters($pQuery, $filters);
        $projectsByStatus = $pQuery->pluck('total', 'project_status')->toArray();

        $statusMap = [
            0 => 'Não Definido', 1 => 'Proposto', 2 => 'Planejamento',
            3 => 'Em Andamento', 4 => 'Em Espera', 5 => 'Concluído', 7 => 'Arquivado'
        ];

        $pLabels = [];
        $pData = [];
        foreach ($projectsByStatus as $status => $total) {
            $pLabels[] = $statusMap[$status] ?? "Status $status";
            $pData[] = (int) $total;
        }

        // Tarefas por progresso / status
        $tQuery = DB::table('dotp_tasks');
        if (!empty($filters['company_id'])) {
            $tQuery->whereIn('task_project', function ($sub) use ($filters) {
                $sub->select('project_id')->from('dotp_projects')->where('project_company', $filters['company_id']);
            });
        }
        if (!empty($filters['date_from'])) {
            $tQuery->where('task_start_date', '>=', $filters['date_from']);
        }
        if (!empty($filters['date_to'])) {
            $tQuery->where('task_start_date', '<=', $filters['date_to']);
        }

        $tasks = $tQuery->select('task_percent_complete')->get();
        $completed = 0;
        $inProgress = 0;
        $notStarted = 0;

        foreach ($tasks as $task) {
            $pct = (int) $task->task_percent_complete;
            if ($pct === 100) {
                $completed++;
            } elseif ($pct > 0) {
                $inProgress++;
            } else {
                $notStarted++;
            }
        }

        return [
            'labels' => $pLabels,
            'data' => $pData, // retrocompatibilidade
            'projects' => [
                'labels' => $pLabels,
                'data' => $pData,
                'colors' => ['#6c757d', '#0dcaf0', '#0d6efd', '#198754', '#ffc107', '#20c997', '#adb5bd']
            ],
            'tasks' => [
                'labels' => ['Concluídas', 'Em Andamento', 'Planejadas / Não Iniciadas'],
                'data' => [$completed, $inProgress, $notStarted],
                'colors' => ['#198754', '#0d6efd', '#6c757d']
            ]
        ];
    }

    private function getTimelineChartData(array $filters): array {
        $hasCustomStart = !empty($filters['date_from']);
        $hasCustomEnd = !empty($filters['date_to']);

        // Se não houver filtro, busca a data do primeiro registro no banco
        $minProjectDate = Project::whereNotNull('project_start_date')->min('project_start_date');
        $minTaskDate = DB::table('dotp_tasks')->whereNotNull('task_start_date')->min('task_start_date');
        $minDate = $minProjectDate ?: $minTaskDate;

        $maxProjectDate = Project::whereNotNull('project_start_date')->max('project_start_date');
        $maxTaskDate = DB::table('dotp_tasks')->whereNotNull('task_start_date')->max('task_start_date');
        $maxDate = max($maxProjectDate ?: '2000-01-01', $maxTaskDate ?: '2000-01-01');

        $startDate = $hasCustomStart
            ? Carbon::parse($filters['date_from'])->startOfDay()
            : ($minDate ? Carbon::parse($minDate)->startOfMonth() : now()->subMonths(5)->startOfMonth());

        $endDate = $hasCustomEnd
            ? Carbon::parse($filters['date_to'])->endOfDay()
            : now()->endOfMonth();

        $driver = DB::connection()->getDriverName();
        $projectYearSql = match ($driver) {
            'sqlite' => "strftime('%Y', project_start_date) as yr, count(*) as total",
            default => "DATE_FORMAT(project_start_date, '%Y') as yr, count(*) as total"
        };
        $taskYearSql = match ($driver) {
            'sqlite' => "strftime('%Y', task_start_date) as yr, count(*) as total",
            default => "DATE_FORMAT(task_start_date, '%Y') as yr, count(*) as total"
        };

        $projectMonthSql = match ($driver) {
            'sqlite' => "strftime('%Y-%m', project_start_date) as ym, count(*) as total",
            default => "DATE_FORMAT(project_start_date, '%Y-%m') as ym, count(*) as total"
        };
        $taskMonthSql = match ($driver) {
            'sqlite' => "strftime('%Y-%m', task_start_date) as ym, count(*) as total",
            default => "DATE_FORMAT(task_start_date, '%Y-%m') as ym, count(*) as total"
        };

        // -------------------------------------------------------------
        // 1. DADOS ANUAIS (Visão Geral de Longo Prazo)
        // -------------------------------------------------------------
        $startYear = $startDate->year;
        $endYear = $hasCustomEnd ? $endDate->year : now()->year;

        $pYearQuery = Project::whereNotNull('project_start_date')
            ->whereBetween('project_start_date', [$startDate, $endDate]);
        if (!empty($filters['company_id'])) {
            $pYearQuery->where('project_company', $filters['company_id']);
        }
        $projByYear = $pYearQuery
            ->selectRaw($projectYearSql)
            ->groupBy('yr')
            ->pluck('total', 'yr')
            ->toArray();

        $tYearQuery = DB::table('dotp_tasks')
            ->whereNotNull('task_start_date')
            ->whereBetween('task_start_date', [$startDate, $endDate]);
        if (!empty($filters['company_id'])) {
            $tYearQuery->whereIn('task_project', function ($sub) use ($filters) {
                $sub->select('project_id')->from('dotp_projects')->where('project_company', $filters['company_id']);
            });
        }
        $taskByYear = $tYearQuery
            ->selectRaw($taskYearSql)
            ->groupBy('yr')
            ->pluck('total', 'yr')
            ->toArray();

        $yearlyLabels = [];
        $yearlyProjects = [];
        $yearlyTasks = [];
        for ($y = $startYear; $y <= $endYear; $y++) {
            $yStr = (string) $y;
            $yearlyLabels[] = $yStr;
            $yearlyProjects[] = (int) ($projByYear[$yStr] ?? 0);
            $yearlyTasks[] = (int) ($taskByYear[$yStr] ?? 0);
        }

        // -------------------------------------------------------------
        // 2. DADOS MENSAIS (Visão Granular)
        // -------------------------------------------------------------
        $monthlyStart = $startDate->copy();
        $monthlyEnd = $hasCustomEnd
            ? $endDate->copy()
            : (Carbon::parse($maxDate)->year < now()->year ? Carbon::parse($maxDate)->endOfYear() : $endDate->copy());

        // Se o intervalo total for muito longo (> 5 anos) e sem filtro explícito, foca no período dos dados ativos
        if ($monthlyStart->diffInMonths($monthlyEnd) > 60 && !$hasCustomStart && !$hasCustomEnd) {
            $monthlyEnd = Carbon::parse($maxDate)->endOfYear();
        }

        $period = CarbonPeriod::create($monthlyStart, '1 month', $monthlyEnd);
        $pMonthQuery = Project::whereNotNull('project_start_date')
            ->whereBetween('project_start_date', [$monthlyStart, $monthlyEnd]);
        if (!empty($filters['company_id'])) {
            $pMonthQuery->where('project_company', $filters['company_id']);
        }
        $projByMonth = $pMonthQuery
            ->selectRaw($projectMonthSql)
            ->groupBy('ym')
            ->pluck('total', 'ym')
            ->toArray();

        $tMonthQuery = DB::table('dotp_tasks')
            ->whereNotNull('task_start_date')
            ->whereBetween('task_start_date', [$monthlyStart, $monthlyEnd]);
        if (!empty($filters['company_id'])) {
            $tMonthQuery->whereIn('task_project', function ($sub) use ($filters) {
                $sub->select('project_id')->from('dotp_projects')->where('project_company', $filters['company_id']);
            });
        }
        $taskByMonth = $tMonthQuery
            ->selectRaw($taskMonthSql)
            ->groupBy('ym')
            ->pluck('total', 'ym')
            ->toArray();

        $monthlyLabels = [];
        $monthlyProjects = [];
        $monthlyTasks = [];
        foreach ($period as $dt) {
            $ym = $dt->format('Y-m');
            $monthlyLabels[] = $dt->translatedFormat('M/Y');
            $monthlyProjects[] = (int) ($projByMonth[$ym] ?? 0);
            $monthlyTasks[] = (int) ($taskByMonth[$ym] ?? 0);
        }

        $defaultView = ($hasCustomStart || $hasCustomEnd) && $startDate->diffInMonths($endDate) <= 24 ? 'monthly' : 'yearly';
        $activeLabels = $defaultView === 'monthly' ? $monthlyLabels : $yearlyLabels;
        $activeProjects = $defaultView === 'monthly' ? $monthlyProjects : $yearlyProjects;
        $activeTasks = $defaultView === 'monthly' ? $monthlyTasks : $yearlyTasks;

        return [
            'labels' => $activeLabels,
            'data' => $activeProjects, // retrocompatibilidade
            'projects' => $activeProjects,
            'tasks' => $activeTasks,
            'defaultView' => $defaultView,
            'yearly' => [
                'labels' => $yearlyLabels,
                'projects' => $yearlyProjects,
                'tasks' => $yearlyTasks,
            ],
            'monthly' => [
                'labels' => $monthlyLabels,
                'projects' => $monthlyProjects,
                'tasks' => $monthlyTasks,
            ]
        ];
    }

    private function getLatestProjects(array $filters) {
        $query = Project::with('company')->orderBy('project_start_date', 'desc')->limit(5);
        $query = $this->applyProjectFilters($query, $filters);
        return $query->get();
    }
}

@extends('dashboard')
@section('title', __('layout.dashboard.title') . ' - dotProject+')

@section('dashboard-content')
    <div class="card shadow-sm border-0 rounded-4 mb-4">
        <div class="card-body p-4 p-md-5">

            <div class="d-flex flex-column flex-xl-row justify-content-between align-items-xl-center mb-5 gap-4">
                <div>
                    <h1 class="h4 fw-bold mb-1 text-dark">{{ __('layout.dashboard.title') }}</h1>
                    <p class="text-muted small mb-0">{{ __('layout.dashboard.subtitle') }}</p>
                </div>

                <div class="d-flex flex-column align-items-xl-end gap-2">
                    <form method="GET" action="{{ route('dashboard') }}" class="d-flex flex-wrap gap-2 align-items-center">
                        <div>
                            <select name="company_id" class="form-select form-select-sm" style="min-width: 170px;">
                                <option value="">{{ __('layout.dashboard.filters.all_companies') ?? 'Todas as Empresas' }}</option>
                                @foreach($companies as $id => $name)
                                    <option value="{{ $id }}" {{ (string)request('company_id') === (string)$id ? 'selected' : '' }}>
                                        {{ $name }}
                                    </option>
                                @endforeach
                            </select>
                        </div>
                        <div>
                            <input type="date" name="date_from" id="filter_date_from" class="form-control form-control-sm text-secondary"
                                   value="{{ request('date_from') }}"
                                   placeholder="{{ __('layout.dashboard.filters.placeholder_from') ?? 'Desde o início' }}"
                                   title="{{ __('layout.dashboard.filters.date_from') ?? 'Data Inicial (em branco = desde o início)' }}">
                        </div>
                        <div class="text-muted small">-</div>
                        <div>
                            <input type="date" name="date_to" id="filter_date_to" class="form-control form-control-sm text-secondary"
                                   value="{{ request('date_to') }}"
                                   placeholder="{{ __('layout.dashboard.filters.placeholder_to') ?? 'Até hoje' }}"
                                   title="{{ __('layout.dashboard.filters.date_to') ?? 'Data Final (em branco = até hoje)' }}">
                        </div>
                        <button type="submit" class="btn btn-primary btn-sm px-3">
                            <i class="bi bi-funnel"></i> {{ __('layout.dashboard.filters.filter_btn') ?? 'Filtrar' }}
                        </button>
                        @if(request()->anyFilled(['company_id', 'date_from', 'date_to']))
                            <a href="{{ route('dashboard') }}" class="btn btn-outline-secondary btn-sm px-3" title="{{ __('layout.dashboard.filters.clear_btn') ?? 'Limpar Filtros' }}">
                                <i class="bi bi-x-lg"></i> {{ __('layout.dashboard.filters.clear_btn') ?? 'Limpar' }}
                            </a>
                        @endif
                    </form>

                    {{-- Atalhos rápidos de período para visualização imediata --}}
                    <div class="d-flex flex-wrap gap-1 align-items-center justify-content-xl-end">
                        <small class="text-muted me-1" style="font-size: 0.75rem;">Atalhos:</small>
                        <a href="{{ route('dashboard', array_filter(['company_id' => request('company_id')])) }}" 
                           class="badge text-decoration-none {{ !request('date_from') && !request('date_to') ? 'bg-primary' : 'bg-light text-secondary border' }}">
                            <i class="bi bi-clock-history"></i> {{ __('layout.dashboard.filters.all_time') ?? 'Desde o Início' }}
                        </a>
                        <a href="{{ route('dashboard', array_filter(['company_id' => request('company_id'), 'date_from' => '2013-01-01', 'date_to' => '2016-12-31'])) }}" 
                           class="badge text-decoration-none {{ request('date_from') === '2013-01-01' && request('date_to') === '2016-12-31' ? 'bg-primary' : 'bg-light text-secondary border' }}">
                            <i class="bi bi-calendar-range"></i> {{ __('layout.dashboard.filters.project_period') ?? '2013 - 2016 (Ativo)' }}
                        </a>
                    </div>
                </div>
            </div>

            <div class="row mb-5">
                <div class="col-md-3 mb-3 mb-md-0">
                    <div class="card border border-light-subtle shadow-none rounded-3 h-100 bg-light">
                        <div class="card-body p-3 d-flex align-items-center justify-content-between">
                            <div>
                                <h6 class="text-muted fw-bold text-uppercase mb-1" style="font-size: 0.7rem; letter-spacing: 1px;">
                                    {{ __('layout.dashboard.cards.total_companies') }}
                                </h6>
                                <div class="h3 mb-0 fw-bold text-dark">{{ $kpis['companies'] }}</div>
                            </div>
                            <div class="bg-primary bg-opacity-10 text-primary rounded p-2 d-flex align-items-center justify-content-center" style="width: 45px; height: 45px;">
                                <i class="bi bi-building fs-5"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 mb-3 mb-md-0">
                    <div class="card border border-light-subtle shadow-none rounded-3 h-100 bg-light">
                        <div class="card-body p-3 d-flex align-items-center justify-content-between">
                            <div>
                                <h6 class="text-muted fw-bold text-uppercase mb-1" style="font-size: 0.7rem; letter-spacing: 1px;">
                                    {{ __('layout.dashboard.cards.active_projects') }}
                                </h6>
                                <div class="h3 mb-0 fw-bold text-dark">{{ $kpis['active_projects'] }}</div>
                            </div>
                            <div class="bg-success bg-opacity-10 text-success rounded p-2 d-flex align-items-center justify-content-center" style="width: 45px; height: 45px;">
                                <i class="bi bi-briefcase fs-5"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 mb-3 mb-md-0">
                    <div class="card border border-light-subtle shadow-none rounded-3 h-100 bg-light">
                        <div class="card-body p-3 d-flex align-items-center justify-content-between">
                            <div>
                                <h6 class="text-muted fw-bold text-uppercase mb-1" style="font-size: 0.7rem; letter-spacing: 1px;">
                                    {{ __('layout.dashboard.cards.average_progress') }}
                                </h6>
                                <div class="h3 mb-0 fw-bold text-dark">{{ $kpis['avg_completion'] }}%</div>
                            </div>
                            <div class="bg-info bg-opacity-10 text-info rounded p-2 d-flex align-items-center justify-content-center" style="width: 45px; height: 45px;">
                                <i class="bi bi-graph-up-arrow fs-5"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card border border-light-subtle shadow-none rounded-3 h-100 bg-light">
                        <div class="card-body p-3 d-flex align-items-center justify-content-between">
                            <div>
                                <h6 class="text-muted fw-bold text-uppercase mb-1" style="font-size: 0.7rem; letter-spacing: 1px;">
                                    {{ __('layout.dashboard.cards.users') }}
                                </h6>
                                <div class="h3 mb-0 fw-bold text-dark">{{ $kpis['users'] }}</div>
                            </div>
                            <div class="bg-warning bg-opacity-10 text-warning rounded p-2 d-flex align-items-center justify-content-center" style="width: 45px; height: 45px;">
                                <i class="bi bi-people-fill fs-5"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mb-5">
                {{-- Gráfico 1: Linha do Tempo (Projetos e Tarefas) --}}
                <div class="col-lg-8 mb-4 mb-lg-0">
                    <div class="card border border-light-subtle shadow-none rounded-3 h-100 bg-white">
                        <div class="card-header bg-transparent border-bottom px-4 py-3 d-flex justify-content-between align-items-center">
                            <div>
                                <span class="fw-bold text-dark">{{ __('layout.dashboard.charts.timeline_title') }}</span>
                                @if(!request('date_from') && !request('date_to'))
                                    <span class="badge bg-light text-primary border ms-2" style="font-size: 0.7rem;">Desde o Início</span>
                                @endif
                            </div>
                            <div class="btn-group btn-group-sm" role="group" aria-label="Granularidade">
                                <button type="button" class="btn btn-outline-primary btn-sm px-2 py-0 active" id="btnTimelineToggleYearly">
                                    {{ __('layout.dashboard.charts.timeline_yearly') ?? 'Anual' }}
                                </button>
                                <button type="button" class="btn btn-outline-primary btn-sm px-2 py-0" id="btnTimelineToggleMonthly">
                                    {{ __('layout.dashboard.charts.timeline_monthly') ?? 'Mensal' }}
                                </button>
                            </div>
                        </div>
                        <div class="card-body p-4 pt-3">
                            <div style="width: 100%; height: 270px;">
                                <canvas id="timelineChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                {{-- Gráfico 2: Distribuição por Status (Projetos e Tarefas) --}}
                <div class="col-lg-4">
                    <div class="card border border-light-subtle shadow-none rounded-3 h-100 bg-white">
                        <div class="card-header bg-transparent border-bottom px-4 py-3 d-flex justify-content-between align-items-center">
                            <span class="fw-bold text-dark">{{ __('layout.dashboard.charts.status_title') }}</span>
                            <div class="btn-group btn-group-sm" role="group" aria-label="Tipo de Entidade">
                                <button type="button" class="btn btn-outline-primary btn-sm px-2 py-0 active" id="btnStatusToggleProjects">
                                    {{ __('layout.dashboard.charts.status_projects') ?? 'Projetos' }}
                                </button>
                                <button type="button" class="btn btn-outline-primary btn-sm px-2 py-0" id="btnStatusToggleTasks">
                                    {{ __('layout.dashboard.charts.status_tasks') ?? 'Tarefas' }}
                                </button>
                            </div>
                        </div>
                        <div class="card-body p-4 d-flex justify-content-center align-items-center">
                            <div style="width: 100%; height: 270px;" id="statusChartWrapper">
                                <canvas id="statusChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            {{-- Tabela de Últimos Projetos --}}
            <div class="card border border-light-subtle shadow-none rounded-3 bg-white overflow-hidden">
                <div class="card-header bg-transparent border-bottom px-4 py-3 d-flex justify-content-between align-items-center">
                    <h6 class="fw-bold text-dark mb-0">{{ __('layout.dashboard.latest_projects.title') }}</h6>
                    <a href="{{ route('projects.index') }}" class="btn btn-sm btn-outline-secondary px-3">
                        {{ __('layout.dashboard.latest_projects.view_all') }}
                    </a>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                        <tr>
                            <th class="small text-muted fw-bold text-uppercase px-4 py-3" style="font-size: 0.75rem;">{{ __('layout.dashboard.latest_projects.table.project') }}</th>
                            <th class="small text-muted fw-bold text-uppercase py-3" style="font-size: 0.75rem;">{{ __('layout.dashboard.latest_projects.table.company') }}</th>
                            <th class="small text-muted fw-bold text-uppercase py-3" style="font-size: 0.75rem;">{{ __('layout.dashboard.latest_projects.table.start_date') }}</th>
                            <th class="small text-muted fw-bold text-uppercase px-4 py-3" style="width: 20%; font-size: 0.75rem;">{{ __('layout.dashboard.latest_projects.table.progress') }}</th>
                        </tr>
                        </thead>
                        <tbody>
                        @forelse($latestProjects as $project)
                            <tr>
                                <td class="px-4">
                                    <a href="{{ route('projects.show', $project) }}" class="fw-semibold text-decoration-none text-dark">
                                        {{ $project->project_name }}
                                    </a>
                                </td>
                                <td class="text-secondary small">{{ $project->company->company_name ?? 'N/A' }}</td>
                                <td class="text-secondary small">{{ $project->project_start_date ? $project->project_start_date->format('d/m/Y') : __('layout.dashboard.latest_projects.table.not_defined') }}</td>
                                <td class="px-4">
                                    <div class="d-flex align-items-center gap-2">
                                        <div class="progress flex-grow-1 bg-light border" style="height: 6px;">
                                            <div class="progress-bar bg-{{ $project->project_percent_complete === 100 ? 'success' : 'primary' }}"
                                                 role="progressbar"
                                                 style="width: {{ $project->project_percent_complete ?? 0 }}%;"></div>
                                        </div>
                                        <span class="small fw-semibold text-secondary" style="min-width: 35px;">{{ round($project->project_percent_complete ?? 0) }}%</span>
                                    </div>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="4" class="text-center text-muted py-5">
                                    <i class="bi bi-inbox fs-3 opacity-50 mb-2 d-block"></i>
                                    {{ __('layout.dashboard.latest_projects.table.empty') }}
                                </td>
                            </tr>
                        @endforelse
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            Chart.defaults.font.family = "'Inter', 'Segoe UI', Roboto, Helvetica, Arial, sans-serif";
            Chart.defaults.color = '#6c757d';

            // Dados do servidor
            const timelineData = {!! json_encode($timelineChart, JSON_THROW_ON_ERROR) !!};
            const statusData = {!! json_encode($statusChart, JSON_THROW_ON_ERROR) !!};

            // ==============================================================
            // 1. GRÁFICO DE LINHA DO TEMPO (Projetos & Tarefas)
            // ==============================================================
            const ctxTimeline = document.getElementById('timelineChart');
            let timelineChartInstance = null;
            let currentTimelineMode = timelineData.defaultView || 'yearly';

            function getTimelineDatasets(mode) {
                const src = timelineData[mode] || timelineData.yearly;
                return [
                    {
                        label: 'Projetos Iniciados',
                        data: src.projects || [],
                        type: 'bar',
                        backgroundColor: 'rgba(13, 110, 253, 0.75)',
                        borderColor: '#0d6efd',
                        borderWidth: 1,
                        borderRadius: 4,
                        barPercentage: 0.5,
                        order: 2
                    },
                    {
                        label: 'Tarefas Planejadas / Executadas',
                        data: src.tasks || [],
                        type: 'line',
                        backgroundColor: 'rgba(25, 135, 84, 0.12)',
                        borderColor: '#198754',
                        borderWidth: 2.5,
                        fill: true,
                        tension: 0.35,
                        pointBackgroundColor: '#fff',
                        pointBorderColor: '#198754',
                        pointBorderWidth: 2,
                        pointRadius: 4,
                        pointHoverRadius: 6,
                        order: 1
                    }
                ];
            }

            if (ctxTimeline) {
                const initialSrc = timelineData[currentTimelineMode] || timelineData.yearly;
                timelineChartInstance = new Chart(ctxTimeline.getContext('2d'), {
                    data: {
                        labels: initialSrc.labels || [],
                        datasets: getTimelineDatasets(currentTimelineMode)
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        interaction: {
                            mode: 'index',
                            intersect: false,
                        },
                        plugins: {
                            legend: {
                                display: true,
                                position: 'top',
                                align: 'end',
                                labels: {
                                    usePointStyle: true,
                                    boxWidth: 8,
                                    font: { size: 11, weight: '500' }
                                }
                            },
                            tooltip: {
                                backgroundColor: '#212529',
                                padding: 10,
                                cornerRadius: 6,
                                callbacks: {
                                    title: function(items) {
                                        return items[0].label;
                                    }
                                }
                            }
                        },
                        scales: {
                            x: {
                                grid: { display: false },
                                ticks: {
                                    maxTicksLimit: currentTimelineMode === 'monthly' ? 14 : 15,
                                    maxRotation: 0,
                                    color: '#6c757d',
                                    font: { size: 11 }
                                }
                            },
                            y: {
                                beginAtZero: true,
                                border: { dash: [4, 4] },
                                grid: { color: '#f0f2f5' },
                                ticks: { precision: 0, color: '#6c757d', font: { size: 11 } }
                            }
                        }
                    }
                });

                // Botões de alternância da linha do tempo
                const btnYearly = document.getElementById('btnTimelineToggleYearly');
                const btnMonthly = document.getElementById('btnTimelineToggleMonthly');

                if (currentTimelineMode === 'monthly') {
                    btnMonthly?.classList.add('active');
                    btnYearly?.classList.remove('active');
                } else {
                    btnYearly?.classList.add('active');
                    btnMonthly?.classList.remove('active');
                }

                btnYearly?.addEventListener('click', function () {
                    if (currentTimelineMode === 'yearly') return;
                    currentTimelineMode = 'yearly';
                    btnYearly.classList.add('active');
                    btnMonthly.classList.remove('active');

                    timelineChartInstance.data.labels = timelineData.yearly.labels;
                    timelineChartInstance.data.datasets = getTimelineDatasets('yearly');
                    timelineChartInstance.options.scales.x.ticks.maxTicksLimit = 15;
                    timelineChartInstance.update();
                });

                btnMonthly?.addEventListener('click', function () {
                    if (currentTimelineMode === 'monthly') return;
                    currentTimelineMode = 'monthly';
                    btnMonthly.classList.add('active');
                    btnYearly.classList.remove('active');

                    timelineChartInstance.data.labels = timelineData.monthly.labels;
                    timelineChartInstance.data.datasets = getTimelineDatasets('monthly');
                    timelineChartInstance.options.scales.x.ticks.maxTicksLimit = 14;
                    timelineChartInstance.update();
                });
            }

            // ==============================================================
            // 2. GRÁFICO DE DISTRIBUIÇÃO POR STATUS (Projetos & Tarefas)
            // ==============================================================
            const ctxStatus = document.getElementById('statusChart');
            let statusChartInstance = null;
            let currentStatusMode = 'projects';

            function getStatusDatasets(mode) {
                const src = statusData[mode] || statusData.projects;
                return [{
                    data: src.data || [],
                    backgroundColor: src.colors || ['#6c757d', '#0dcaf0', '#0d6efd', '#198754'],
                    borderWidth: 2,
                    borderColor: '#fff',
                    hoverOffset: 4
                }];
            }

            if (ctxStatus) {
                statusChartInstance = new Chart(ctxStatus.getContext('2d'), {
                    type: 'doughnut',
                    data: {
                        labels: statusData.projects.labels || [],
                        datasets: getStatusDatasets('projects')
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'bottom',
                                labels: {
                                    usePointStyle: true,
                                    padding: 14,
                                    color: '#495057',
                                    font: { size: 11 }
                                }
                            },
                            tooltip: {
                                backgroundColor: '#212529',
                                padding: 10,
                                cornerRadius: 6,
                            }
                        },
                        cutout: '70%'
                    }
                });

                // Botões de alternância do status
                const btnStatusProjects = document.getElementById('btnStatusToggleProjects');
                const btnStatusTasks = document.getElementById('btnStatusToggleTasks');

                btnStatusProjects?.addEventListener('click', function () {
                    if (currentStatusMode === 'projects') return;
                    currentStatusMode = 'projects';
                    btnStatusProjects.classList.add('active');
                    btnStatusTasks.classList.remove('active');

                    statusChartInstance.data.labels = statusData.projects.labels;
                    statusChartInstance.data.datasets = getStatusDatasets('projects');
                    statusChartInstance.update();
                });

                btnStatusTasks?.addEventListener('click', function () {
                    if (currentStatusMode === 'tasks') return;
                    currentStatusMode = 'tasks';
                    btnStatusTasks.classList.add('active');
                    btnStatusProjects.classList.remove('active');

                    statusChartInstance.data.labels = statusData.tasks.labels;
                    statusChartInstance.data.datasets = getStatusDatasets('tasks');
                    statusChartInstance.update();
                });
            }
        });
    </script>
@endsection

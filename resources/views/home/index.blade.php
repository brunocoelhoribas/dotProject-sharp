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

                <form method="GET" action="{{ route('dashboard') }}" class="d-flex flex-wrap gap-2 align-items-center">
                    <div>
                        <select name="company_id" class="form-select form-select-sm" style="min-width: 180px;">
                            <option value="">{{ __('layout.dashboard.filters.all_companies') ?? 'Todas as Empresas' }}</option>
                            @foreach($companies as $id => $name)
                                <option value="{{ $id }}" {{ request('company_id') === $id ? 'selected' : '' }}>
                                    {{ $name }}
                                </option>
                            @endforeach
                        </select>
                    </div>
                    <div>
                        <input type="date" name="date_from" class="form-control form-control-sm text-secondary"
                               value="{{ request('date_from') }}"
                               title="{{ __('layout.dashboard.filters.date_from') ?? 'Data Inicial' }}">
                    </div>
                    <div class="text-muted small">-</div>
                    <div>
                        <input type="date" name="date_to" class="form-control form-control-sm text-secondary"
                               value="{{ request('date_to') }}"
                               title="{{ __('layout.dashboard.filters.date_to') ?? 'Data Final' }}">
                    </div>
                    <button type="submit" class="btn btn-primary btn-sm px-3">
                        <i class="bi bi-funnel"></i> {{ __('layout.dashboard.filters.filter_btn') ?? 'Filtrar' }}
                    </button>
                    @if(request()->anyFilled(['company_id', 'date_from', 'date_to']))
                        <a href="{{ route('dashboard') }}" class="btn btn-outline-secondary btn-sm px-3" title="Limpar Filtros">
                            <i class="bi bi-x-lg"></i>
                        </a>
                    @endif
                </form>
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
                <div class="col-lg-8 mb-4 mb-lg-0">
                    <div class="card border border-light-subtle shadow-none rounded-3 h-100 bg-white">
                        <div class="card-header bg-transparent border-bottom px-4 py-3 fw-bold text-dark">
                            {{ __('layout.dashboard.charts.timeline_title') }}
                        </div>
                        <div class="card-body p-4 pt-3">
                            <canvas id="timelineChart" height="260"></canvas>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="card border border-light-subtle shadow-none rounded-3 h-100 bg-white">
                        <div class="card-header bg-transparent border-bottom px-4 py-3 fw-bold text-dark">
                            {{ __('layout.dashboard.charts.status_title') }}
                        </div>
                        <div class="card-body p-4 d-flex justify-content-center align-items-center">
                            @if(count($statusChart['data']) > 0)
                                <div style="width: 100%; height: 260px;">
                                    <canvas id="statusChart"></canvas>
                                </div>
                            @else
                                <div class="text-center text-muted p-5 bg-light rounded-3 w-100">
                                    <i class="bi bi-pie-chart fs-1 mb-2 opacity-50"></i>
                                    <p class="small mb-0">{{ __('layout.dashboard.charts.no_data') }}</p>
                                </div>
                            @endif
                        </div>
                    </div>
                </div>
            </div>

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
            Chart.defaults.color = '#adb5bd';

            const ctxTimeline = document.getElementById('timelineChart');
            if (ctxTimeline) {
                new Chart(ctxTimeline.getContext('2d'), {
                    type: 'line',
                    data: {
                        labels: {!! json_encode($timelineChart['labels'], JSON_THROW_ON_ERROR) !!},
                        datasets: [{
                            label: 'Projetos Iniciados',
                            data: {!! json_encode($timelineChart['data'], JSON_THROW_ON_ERROR) !!},
                            backgroundColor: 'rgba(13, 110, 253, 0.1)',
                            borderColor: 'rgba(13, 110, 253, 1)',
                            borderWidth: 2,
                            fill: true,
                            tension: 0.3,
                            pointBackgroundColor: '#fff',
                            pointBorderColor: 'rgba(13, 110, 253, 1)',
                            pointBorderWidth: 2,
                            pointRadius: 3,
                            pointHoverRadius: 5
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: { display: false },
                            tooltip: {
                                backgroundColor: '#212529',
                                padding: 10,
                                cornerRadius: 6,
                                displayColors: false,
                            }
                        },
                        scales: {
                            x: {
                                grid: { display: false },
                                ticks: {
                                    maxTicksLimit: 8,
                                    maxRotation: 0,
                                    color: '#6c757d'
                                }
                            },
                            y: {
                                beginAtZero: true,
                                border: { dash: [4, 4] },
                                grid: { color: '#f8f9fa' },
                                ticks: { precision: 0, color: '#6c757d' }
                            }
                        }
                    }
                });
            }

            const ctxStatus = document.getElementById('statusChart');
            if (ctxStatus) {
                new Chart(ctxStatus.getContext('2d'), {
                    type: 'doughnut',
                    data: {
                        labels: {!! json_encode($statusChart['labels'], JSON_THROW_ON_ERROR) !!},
                        datasets: [{
                            data: {!! json_encode($statusChart['data'], JSON_THROW_ON_ERROR) !!},
                            backgroundColor: ['#6c757d', '#0dcaf0', '#0d6efd', '#198754', '#ffc107', '#20c997', '#adb5bd'],
                            borderWidth: 2,
                            borderColor: '#fff',
                            hoverOffset: 4
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'bottom',
                                labels: {
                                    usePointStyle: true,
                                    padding: 20,
                                    color: '#495057',
                                    font: { size: 12 }
                                }
                            },
                            tooltip: {
                                backgroundColor: '#212529',
                                padding: 10,
                                cornerRadius: 6,
                            }
                        },
                        cutout: '75%'
                    }
                });
            }
        });
    </script>
@endsection

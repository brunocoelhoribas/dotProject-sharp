@extends('dashboard')
@section('title', __('layout.dashboard.title') . ' - dotProject+')

@section('dashboard-content')
    <div class="card shadow-sm border-0 mb-4 bg-transparent">
        <div class="card-body p-0">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="h4 fw-bold mb-0 text-dark">{{ __('layout.dashboard.title') }}</h1>
            </div>

            <div class="row mb-4">
                <div class="col-md-3 mb-3">
                    <div class="card border border-light-subtle shadow-sm h-100">
                        <div class="card-body d-flex align-items-center justify-content-between">
                            <div>
                                <h6 class="text-muted fw-semibold text-uppercase mb-1" style="font-size: 0.75rem;">{{ __('layout.dashboard.cards.total_companies') }}</h6>
                                <div class="h3 mb-0 fw-bold text-dark">{{ $companiesCount }}</div>
                            </div>
                            <div class="text-primary bg-primary bg-opacity-10 p-3 rounded-circle">
                                <i class="bi bi-building fs-5"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 mb-3">
                    <div class="card border border-light-subtle shadow-sm h-100">
                        <div class="card-body d-flex align-items-center justify-content-between">
                            <div>
                                <h6 class="text-muted fw-semibold text-uppercase mb-1" style="font-size: 0.75rem;">{{ __('layout.dashboard.cards.active_projects') }}</h6>
                                <div class="h3 mb-0 fw-bold text-dark">{{ $activeProjectsCount }}</div>
                            </div>
                            <div class="text-success bg-success bg-opacity-10 p-3 rounded-circle">
                                <i class="bi bi-briefcase fs-5"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 mb-3">
                    <div class="card border border-light-subtle shadow-sm h-100">
                        <div class="card-body d-flex align-items-center justify-content-between">
                            <div>
                                <h6 class="text-muted fw-semibold text-uppercase mb-1" style="font-size: 0.75rem;">{{ __('layout.dashboard.cards.average_progress') }}</h6>
                                <div class="h3 mb-0 fw-bold text-dark">{{ round($avgCompletion) }}%</div>
                            </div>
                            <div class="text-info bg-info bg-opacity-10 p-3 rounded-circle">
                                <i class="bi bi-graph-up-arrow fs-5"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 mb-3">
                    <div class="card border border-light-subtle shadow-sm h-100">
                        <div class="card-body d-flex align-items-center justify-content-between">
                            <div>
                                <h6 class="text-muted fw-semibold text-uppercase mb-1" style="font-size: 0.75rem;">{{ __('layout.dashboard.cards.users') }}</h6>
                                <div class="h3 mb-0 fw-bold text-dark">{{ $usersCount }}</div>
                            </div>
                            <div class="text-warning bg-warning bg-opacity-10 p-3 rounded-circle">
                                <i class="bi bi-people fs-5 text-dark"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-lg-8 mb-4 mb-lg-0">
                    <div class="card border border-light-subtle shadow-sm h-100">
                        <div class="card-header bg-white fw-bold text-dark border-bottom">
                            {{ __('layout.dashboard.charts.timeline_title') }}
                        </div>
                        <div class="card-body">
                            <canvas id="timelineChart" height="100"></canvas>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="card border border-light-subtle shadow-sm h-100">
                        <div class="card-header bg-white fw-bold text-dark border-bottom">
                            {{ __('layout.dashboard.charts.status_title') }}
                        </div>
                        <div class="card-body d-flex justify-content-center align-items-center">
                            @if(count($chartStatusData) > 0)
                                <canvas id="statusChart" height="220"></canvas>
                            @else
                                <p class="text-muted small">{{ __('layout.dashboard.charts.no_data') }}</p>
                            @endif
                        </div>
                    </div>
                </div>
            </div>

            <div class="card border border-light-subtle shadow-sm">
                <div class="card-header bg-white fw-bold text-dark border-bottom d-flex justify-content-between align-items-center">
                    {{ __('layout.dashboard.latest_projects.title') }}
                    <a href="{{ route('projects.index') }}" class="btn btn-sm btn-outline-secondary">{{ __('layout.dashboard.latest_projects.view_all') }}</a>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                        <tr>
                            <th class="small text-muted text-uppercase">{{ __('layout.dashboard.latest_projects.table.project') }}</th>
                            <th class="small text-muted text-uppercase">{{ __('layout.dashboard.latest_projects.table.company') }}</th>
                            <th class="small text-muted text-uppercase">{{ __('layout.dashboard.latest_projects.table.start_date') }}</th>
                            <th class="small text-muted text-uppercase" style="width: 25%;">{{ __('layout.dashboard.latest_projects.table.progress') }}</th>
                        </tr>
                        </thead>
                        <tbody>
                        @forelse($latestProjects as $project)
                            <tr>
                                <td>
                                    <a href="{{ route('projects.show', $project) }}" class="fw-semibold text-decoration-none text-dark">{{ $project->project_name }}</a>
                                </td>
                                <td class="small">{{ $project->company->company_name ?? 'N/A' }}</td>
                                <td class="small">{{ $project->project_start_date ? $project->project_start_date->format('d/m/Y') : __('layout.dashboard.latest_projects.table.not_defined') }}</td>
                                <td>
                                    <div class="d-flex align-items-center gap-2">
                                        <div class="progress flex-grow-1" style="height: 6px;">
                                            <div class="progress-bar bg-{{ $project->project_percent_complete == 100 ? 'success' : 'primary' }}"
                                                 role="progressbar"
                                                 style="width: {{ $project->project_percent_complete ?? 0 }}%;"></div>
                                        </div>
                                        <span class="small text-muted" style="min-width: 35px;">{{ round($project->project_percent_complete ?? 0) }}%</span>
                                    </div>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="4" class="text-center text-muted py-4 small">{{ __('layout.dashboard.latest_projects.table.empty') }}</td>
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
        document.addEventListener("DOMContentLoaded", function() {

            const ctxTimeline = document.getElementById('timelineChart');
            if(ctxTimeline) {
                new Chart(ctxTimeline.getContext('2d'), {
                    type: 'line',
                    data: {
                        labels: {!! json_encode($chartMonths) !!},
                        datasets: [{
                            // Essa legenda fica no tooltip quando passa o mouse no gráfico
                            label: 'Projetos',
                            data: {!! json_encode($chartProjectsCount) !!},
                            backgroundColor: 'rgba(13, 110, 253, 0.1)',
                            borderColor: 'rgba(13, 110, 253, 1)',
                            borderWidth: 2,
                            fill: true,
                            tension: 0.3,
                            pointBackgroundColor: '#fff',
                            pointBorderColor: 'rgba(13, 110, 253, 1)',
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: { legend: { display: false } },
                        scales: { y: { beginAtZero: true, ticks: { precision: 0 } } }
                    }
                });
            }

            const ctxStatus = document.getElementById('statusChart');
            if(ctxStatus) {
                new Chart(ctxStatus.getContext('2d'), {
                    type: 'doughnut',
                    data: {
                        labels: {!! json_encode($chartStatusLabels) !!},
                        datasets: [{
                            data: {!! json_encode($chartStatusData) !!},
                            backgroundColor: ['#6c757d', '#0dcaf0', '#0d6efd', '#198754', '#ffc107', '#20c997', '#adb5bd'],
                            borderWidth: 0
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: { position: 'bottom', labels: { boxWidth: 12, padding: 15 } }
                        },
                        cutout: '70%'
                    }
                });
            }
        });
    </script>
@endsection

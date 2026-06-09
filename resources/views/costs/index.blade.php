@extends('dashboard')

@section('title', __('costs/view.title') . ' - dotProject+')

@section('dashboard-content')
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-body p-4">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-end mb-4 gap-3">
                <div>
                    <h1 class="h4 fw-bold mb-0 text-dark">
                        <i class="bi bi-currency-dollar text-success me-2"></i> {{ __('costs/view.header') }}
                    </h1>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-hover table-bordered align-middle mb-0">
                    <thead class="table-light">
                    <tr>
                        <th class="fw-bold text-dark py-2" style="background-color: #f8f9fa;">{{ __('costs/view.table.project') }}</th>
                        <th class="fw-bold text-dark py-2" style="background-color: #f8f9fa;">{{ __('costs/view.table.company') }}</th>
                        <th class="fw-bold text-dark py-2 text-center" style="background-color: #f8f9fa;">{{ __('costs/view.table.target_budget') }}</th>
                        <th class="fw-bold text-dark py-2 text-center" style="background-color: #f8f9fa;">{{ __('costs/view.table.hr_costs') }}</th>
                        <th class="fw-bold text-dark py-2 text-center" style="background-color: #f8f9fa;">{{ __('costs/view.table.other_costs') }}</th>
                        <th class="fw-bold text-dark py-2 text-end" style="background-color: #f8f9fa;">{{ __('costs/view.table.current_total_cost') }}</th>
                        <th class="fw-bold text-dark py-2 text-center" style="background-color: #f8f9fa; width: 60px;"><i class="bi bi-gear"></i></th>
                    </tr>
                    </thead>
                    <tbody class="bg-white">
                    @forelse($projects as $project)
                        <tr>
                            <td>
                                <a href="{{ route('projects.show', $project->project_id) }}" class="link-hover-yellow fw-medium">
                                    {{ $project->project_name }}
                                </a>
                            </td>
                            <td>
                                <span class="text-secondary small">{{ $project->company->company_name ?? '-' }}</span>
                            </td>

                            <td class="text-center text-primary small fw-medium">
                                R$ {{ number_format($project->project_target_budget ?? 0, 2, ',', '.') }}
                            </td>

                            <td class="text-center text-secondary small">
                                R$ {{ number_format($project->total_hr_costs, 2, ',', '.') }}
                            </td>
                            <td class="text-center text-secondary small">
                                R$ {{ number_format($project->total_non_hr_costs, 2, ',', '.') }}
                            </td>

                            <td class="text-end small fw-bold {{ $project->total_costs > $project->project_target_budget ? 'text-danger' : 'text-success' }}">
                                R$ {{ number_format($project->total_costs, 2, ',', '.') }}
                            </td>
                            <td class="text-center">
                                {{-- BOTÃO QUE ABRE O GRÁFICO --}}
                                <button class="btn btn-sm btn-outline-primary shadow-sm"
                                        onclick="loadSCurve({{ $project->project_id }}, '{{ addslashes($project->project_name) }}')"
                                        title="{{ __('costs/view.table.view_s_curve') }}">
                                    <i class="bi bi-graph-up-arrow"></i>
                                </button>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="7" class="text-center text-muted py-4">
                                {{ __('costs/view.table.empty') }}
                            </td>
                        </tr>
                    @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div id="sCurveContainer" class="card shadow-sm border-0 d-none mb-4 transition-all">
        <div class="card-body p-4">
            <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                <h5 class="fw-bold mb-0 text-dark" id="chartTitle">
                    <i class="bi bi-graph-up-arrow text-primary me-2"></i> {{ __('costs/view.chart.title') }}
                </h5>
                <button type="button" class="btn-close" onclick="closeChart()" aria-label="Close"></button>
            </div>

            <div id="chartLoading" class="text-center py-5 d-none">
                <div class="spinner-border text-primary" role="status"></div>
                <p class="mt-2 text-muted">{{ __('costs/view.chart.loading') }}</p>
            </div>

            <div id="chartNoData" class="text-center py-5 d-none">
                <i class="bi bi-info-circle text-muted fs-1"></i>
                <p class="mt-2 text-muted">{{ __('costs/view.chart.no_data') }}</p>
            </div>

            <div id="canvasWrapper" style="height: 350px; width: 100%;">
                <canvas id="sCurveChart"></canvas>
            </div>
        </div>
    </div>
@endsection

@push('scripts')
    <script>
        let sCurveChartInstance = null;

        function closeChart() {
            document.getElementById('sCurveContainer').classList.add('d-none');
        }

        async function loadSCurve(projectId, projectName) {
            const container = document.getElementById('sCurveContainer');
            const title = document.getElementById('chartTitle');
            const loading = document.getElementById('chartLoading');
            const noData = document.getElementById('chartNoData');
            const canvasWrapper = document.getElementById('canvasWrapper');
            const ctx = document.getElementById('sCurveChart').getContext('2d');

            container.classList.remove('d-none');
            container.scrollIntoView({ behavior: 'smooth', block: 'end' });

            title.innerHTML = `<i class="bi bi-graph-up-arrow text-primary me-2"></i> {{ __('costs/view.chart.s_curve_prefix') }} <span class="text-secondary">${projectName}</span>`;

            loading.classList.remove('d-none');
            noData.classList.add('d-none');
            canvasWrapper.classList.add('d-none');

            if (sCurveChartInstance) {
                sCurveChartInstance.destroy();
            }

            try {
                const response = await fetch(`/costs/${projectId}/s-curve`);
                const json = await response.json();

                loading.classList.add('d-none');

                if (json.error === 'no_data') {
                    noData.classList.remove('d-none');
                    return;
                }

                canvasWrapper.classList.remove('d-none');

                const budgetDataArray = Array(json.labels.length).fill(json.targetBudget);

                sCurveChartInstance = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: json.labels,
                        datasets: [
                            {
                                label: '{{ __('costs/view.chart.cumulative_cost') }}',
                                data: json.data,
                                borderColor: '#0d6efd',
                                backgroundColor: 'rgba(13, 110, 253, 0.1)',
                                fill: true,
                                tension: 0.4,
                                borderWidth: 3,
                                pointRadius: 4,
                                pointBackgroundColor: '#0d6efd'
                            },
                            {
                                label: '{{ __('costs/view.chart.target_budget') }}',
                                data: budgetDataArray,
                                borderColor: '#dc3545',
                                borderDash: [5, 5],
                                fill: false,
                                borderWidth: 2,
                                pointRadius: 0,
                                tension: 0
                            }
                        ]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        interaction: {
                            mode: 'index',
                            intersect: false,
                        },
                        plugins: {
                            tooltip: {
                                callbacks: {
                                    label: function(context) {
                                        let value = context.raw || 0;
                                        return context.dataset.label + ': R$ ' + value.toLocaleString('pt-BR', {minimumFractionDigits: 2});
                                    }
                                }
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function(value) {
                                        return 'R$ ' + value.toLocaleString('pt-BR');
                                    }
                                }
                            }
                        }
                    }
                });
            } catch (error) {
                loading.classList.add('d-none');
                alert('{{ __('costs/view.chart.error') }}');
            }
        }
    </script>
@endpush

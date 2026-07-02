@php
    use App\Http\Controllers\Planning\PlanningController;
@endphp

<div class="d-flex justify-content-end mb-4 gap-2">
    <a href="{{ route('projects.sequencing.index', $project->project_id) }}" class="btn btn-sm btn-outline-secondary fw-semibold">
        <i class="bi bi-arrow-left-right me-1"></i> {{ __('planning/view.activities.sequencing') }}
    </a>

    <button type="button" class="btn btn-sm btn-outline-secondary fw-semibold" data-bs-toggle="modal" data-bs-target="#trainingModal">
        <i class="bi bi-mortarboard me-1"></i> {{ __('planning/view.activities.training') }}
    </button>

    <button type="button" class="btn btn-sm btn-outline-secondary fw-semibold" data-bs-toggle="modal" data-bs-target="#minutesModal">
        <i class="bi bi-clock-history me-1"></i> {{ __('planning/view.activities.minutes') }}
    </button>
</div>

<div class="card shadow-sm border-0 rounded-3 overflow-hidden">
    <div class="table-responsive">
        <table class="table table-hover align-middle mb-0" style="font-size: 0.85rem;">
            <thead class="table-light">
            <tr>
                <th style="width: 45%" class="py-3 px-3 text-muted fw-bold text-uppercase">{{ __('planning/view.activities.table.wbs') }}</th>
                <th class="text-center py-3 text-muted fw-bold text-uppercase">{{ __('planning/view.activities.table.start') }}</th>
                <th class="text-center py-3 text-muted fw-bold text-uppercase">{{ __('planning/view.activities.table.end') }}</th>
                <th class="text-center py-3 text-muted fw-bold text-uppercase">{{ __('planning/view.activities.table.duration') }}</th>
                <th class="text-center py-3 text-muted fw-bold text-uppercase">{{ __('planning/view.activities.table.status') }}</th>
                <th style="width: 120px" class="text-center py-3 text-muted fw-bold text-uppercase">{{ __('planning/view.activities.table.actions') }}</th>
            </tr>
            </thead>
            <tbody class="border-top-0">
            @forelse($wbsItems as $item)
                @php
                    $level = $item->level;
                    $padding = $level * 20;
                    $taskCount = $item->tasks->count();
                @endphp

                <tr class="bg-light">
                    <td colspan="5" class="py-2 px-3 border-end-0">
                        <div class="d-flex align-items-center justify-content-between" style="padding-left: {{ $padding }}px;">
                            <div class="d-flex align-items-center">
                                <span class="me-2 text-primary fs-6">
                                    {!! $item->is_leaf ? '<i class="bi bi-folder2-open"></i>' : '<i class="bi bi-folder-fill"></i>' !!}
                                </span>
                                <span class="fw-bold text-dark">{{ $item->number }} {{ $item->name }}</span>
                                @if($taskCount > 0)
                                    <span class="badge bg-secondary bg-opacity-10 text-secondary border border-secondary border-opacity-25 rounded-pill ms-2" style="font-size: 0.7em;">
                                        {{ $taskCount }} {{ $taskCount === 1 ? __('planning/view.activities.task.single') : __('planning/view.activities.task.plural') }}
                                    </span>
                                @endif
                            </div>
                            @if($taskCount > 0)
                                <div style="cursor: pointer;" onclick="toggleWbsGroup({{ $item->id }})" class="text-secondary p-1">
                                    <i class="bi bi-chevron-down" id="wbs-icon-{{ $item->id }}"></i>
                                </div>
                            @endif
                        </div>
                    </td>
                    <td class="text-center align-middle border-start-0 bg-light">
                        <div class="dropdown">
                            <button class="btn btn-sm btn-link text-secondary text-decoration-none p-0" type="button" data-bs-toggle="dropdown">
                                <i class="bi bi-three-dots-vertical fs-5"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0">
                                @if($item->is_leaf)
                                    <li><a class="dropdown-item small" href="#" onclick="openNewActivityModal({{ $item->id }})"><i class="bi bi-plus-lg me-2 text-success"></i> {{ __('planning/view.activities.menu.new_activity') }}</a></li>
                                @endif
                                <li><a class="dropdown-item small" href="#" onclick="openNewWbsItemModal({{ $item->id }})"><i class="bi bi-folder-plus me-2 text-primary"></i> {{ __('planning/view.activities.menu.new_subitem') }}</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item small" href="#" onclick="moveItem('{{ route('projects.wbs.move', [$project->project_id, $item->id, 'up']) }}')"><i class="bi bi-arrow-up me-2 text-secondary"></i> {{ __('planning/view.activities.menu.move_up') }}</a></li>
                                <li><a class="dropdown-item small" href="#" onclick="moveItem('{{ route('projects.wbs.move', [$project->project_id, $item->id, 'down']) }}')"><i class="bi bi-arrow-down me-2 text-secondary"></i> {{ __('planning/view.activities.menu.move_down') }}</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item small text-danger" href="#" onclick="openDeleteWbsModal({{ $item->id }})"><i class="bi bi-trash me-2"></i> {{ __('planning/view.activities.menu.delete_item') }}</a></li>
                            </ul>
                        </div>
                    </td>
                </tr>

                @foreach($item->tasks as $task)
                    <tr class="align-middle wbs-group-{{ $item->id }}">
                        <td class="px-3">
                            <div class="d-flex align-items-center py-1" style="padding-left: {{ $padding + 30 }}px;">
                                <a href="#" class="text-decoration-none text-secondary me-2" data-bs-toggle="collapse" data-bs-target="#details-{{ $task->task_id }}" aria-expanded="false">
                                    <i class="bi bi-chevron-right small"></i>
                                </a>
                                @php
                                    $letter = PlanningController::numberToAlpha($loop->index);
                                    $hierarchicalCode = "A.$item->number.$letter";
                                @endphp
                                <span class="badge bg-light text-secondary border me-2">{{ $hierarchicalCode }}</span>
                                <span class="text-dark fw-medium">{{ $task->task_name }}</span>
                            </div>
                        </td>
                        <td class="text-center text-secondary">{{ $task->task_start_date ? $task->task_start_date->format('d/m/Y') : '-' }}</td>
                        <td class="text-center text-secondary">{{ $task->task_end_date ? $task->task_end_date->format('d/m/Y') : '-' }}</td>
                        <td class="text-center text-secondary">
                            {{ $task->task_duration }}
                            <span class="small">{{ $task->task_duration_type === 24 ? __('planning/view.activities.task.days') : __('planning/view.activities.task.hours') }}</span>
                        </td>
                        <td class="text-center">
                            @if($task->task_percent_complete === 100)
                                <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25">{{ __('planning/view.activities.task.status.completed') }}</span>
                            @elseif($task->task_percent_complete > 0)
                                <span class="badge bg-warning bg-opacity-10 text-warning-emphasis border border-warning border-opacity-25">{{ $task->task_percent_complete }}%</span>
                            @else
                                <span class="badge bg-light text-secondary border">{{ __('planning/view.activities.task.status.not_started') }}</span>
                            @endif
                        </td>
                        <td class="text-center align-middle">
                            <div class="d-flex justify-content-center align-items-center gap-2">
                                <div class="d-flex flex-column lh-1">
                                    <button type="button" onclick="moveItem('{{ route('projects.activity.move', [$project->project_id, $task->task_id, 'up']) }}')" class="btn btn-link p-0 text-decoration-none text-secondary" title="{{ __('planning/view.activities.task.actions.move_up') }}"><i class="bi bi-caret-up-fill" style="font-size: 0.65rem;"></i></button>
                                    <button type="button" onclick="moveItem('{{ route('projects.activity.move', [$project->project_id, $task->task_id, 'down']) }}')" class="btn btn-link p-0 text-decoration-none text-secondary" title="{{ __('planning/view.activities.task.actions.move_down') }}"><i class="bi bi-caret-down-fill" style="font-size: 0.65rem;"></i></button>
                                </div>
                                <button class="btn btn-sm btn-light text-primary p-1" title="{{ __('planning/view.activities.task.actions.edit') }}" onclick="openEditActivityModal({{ $task }})">
                                    <i class="bi bi-pencil-square"></i>
                                </button>
                                <button class="btn btn-sm btn-light text-danger p-1" title="{{ __('planning/view.activities.task.actions.delete') }}" onclick="deleteActivity({{ $task->task_id }})">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>

                    <tr class="collapse bg-light bg-opacity-50 wbs-group-{{ $item->id }}" id="details-{{ $task->task_id }}">
                        <td colspan="6" class="p-0 border-0">
                            <div class="p-3" style="margin-left: {{ $padding + 55 }}px; border-left: 2px solid #dee2e6;">
                                <div class="d-flex gap-4 small text-secondary">
                                    <div><i class="bi bi-person me-1"></i> <strong class="text-dark">{{ __('planning/view.activities.task.details.owner') }}:</strong> {{ $task->owner->contact->full_name ?? __('planning/view.activities.task.details.not_defined') }}</div>
                                    <div><i class="bi bi-hourglass-split me-1"></i> <strong class="text-dark">{{ __('planning/view.activities.task.details.effort') }}:</strong> {{ $task->estimation->effort ?? '-' }}</div>
                                </div>
                            </div>
                        </td>
                    </tr>
                @endforeach
            @empty
                <tr>
                    <td colspan="6" class="text-center py-5 text-muted">
                        <div class="d-flex flex-column align-items-center">
                            <div class="bg-light rounded-circle d-flex align-items-center justify-content-center mb-3" style="width: 60px; height: 60px;">
                                <i class="bi bi-list-task fs-3 text-secondary"></i>
                            </div>
                            <h6 class="fw-bold text-dark">{{ __('planning/view.activities.empty.message') }}</h6>
                            <p class="small mb-4">{{ __('planning/view.activities.empty.sub_message') }}</p>

                            <div class="d-flex gap-2 justify-content-center flex-wrap">
                                <button class="btn btn-primary btn-sm px-3 rounded-pill" data-bs-toggle="modal" data-bs-target="#createWbsModal">
                                    <i class="bi bi-plus-lg me-1"></i> {{ __('planning/view.activities.empty.btn_manual') }}
                                </button>

                                <form action="{{ route('projects.wbs.generate_ai', $project->project_id) }}" method="POST" onsubmit="showAiLoading(this)">
                                    @csrf
                                    <button type="submit" class="btn btn-dark btn-sm px-3 rounded-pill transition-all" style="min-width: 200px;">
                                        <span class="btn-text">
                                            <i class="bi bi-magic me-1 text-warning"></i> {{ __('planning/view.activities.empty.btn_ai') }}
                                        </span>
                                        <span class="btn-spinner d-none">
                                            <span class="spinner-border spinner-border-sm me-2 text-warning" role="status" aria-hidden="true"></span>
                                            {{ __('planning/view.activities.empty.generating') ?? 'Gerando Estrutura...' }}
                                        </span>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </td>
                </tr>
            @endforelse
            </tbody>
        </table>
    </div>
</div>
<script>
    function showAiLoading(form) {
        const btn = form.querySelector('button[type="submit"]');

        const textSpan = btn.querySelector('.btn-text');
        const spinnerSpan = btn.querySelector('.btn-spinner');

        btn.disabled = true;
        btn.classList.add('opacity-75');

        textSpan.classList.add('d-none');
        spinnerSpan.classList.remove('d-none');
    }
</script>

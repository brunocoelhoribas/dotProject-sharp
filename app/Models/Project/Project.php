<?php

namespace App\Models\Project;

use App\Models\Company\Company;
use App\Models\Department\Department;
use App\Models\Initiating\Initiating;
use App\Models\Initiating\InitiatingStakeholder;
use App\Models\Planning\Acquisition\AcquisitionPlanning;
use App\Models\Planning\Communication\Communication;
use App\Models\Planning\Quality\QualityPlanning;
use App\Models\Planning\Risk\Risk;
use App\Models\User\User;
use App\Models\User\UserContact;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasManyThrough;
use Illuminate\Database\Eloquent\Relations\HasOne;
use App\Models\Project\Task\Task;
use Illuminate\Support\Facades\DB;

class Project extends Model {
    use HasFactory;

    protected $table = 'dotp_projects';
    protected $primaryKey = 'project_id';
    public $timestamps = false;
    protected $fillable = [
        'project_company',
        'project_internal',
        'project_name',
        'project_short_name',
        'project_owner',
        'project_creator',
        'project_url',
        'project_demo_url',
        'project_start_date',
        'project_end_date',
        'project_status',
        'project_percent_complete',
        'project_color_identifier',
        'project_description',
        'project_target_budget',
        'project_departments',
        'project_contacts',
        'project_priority',
        'project_type',
    ];

    protected $casts = [
        'project_start_date' => 'datetime',
        'project_end_date' => 'datetime',
    ];


    public function company(): BelongsTo {
        return $this->belongsTo(Company::class, 'project_company', 'company_id');
    }


    public function owner(): BelongsTo {
        return $this->belongsTo(User::class, 'project_owner', 'user_id');
    }


    public function creator(): BelongsTo {
        return $this->belongsTo(User::class, 'project_creator', 'user_id');
    }

    public function contacts(): BelongsToMany {
        return $this->belongsToMany(
            UserContact::class,
            'dotp_project_contacts',
            'project_id',
            'contact_id'
        );
    }

    public function initiating(): HasOne {
        return $this->hasOne(Initiating::class, 'project_id', 'project_id');
    }

    public function departments(): BelongsToMany {
        return $this->belongsToMany(
            Department::class,
            'dotp_project_departments',
            'project_id',
            'department_id'
        );
    }

    public function wbsItems(): HasMany|self {
        return $this->hasMany(ProjectWbsItem::class, 'project_id', 'project_id');
    }

    public function risks(): HasMany|self {
        return $this->hasMany(Risk::class, 'risk_project', 'project_id');
    }

    public function stakeholders(): HasManyThrough|self {
        return $this->hasManyThrough(
            InitiatingStakeholder::class,
            Initiating::class,
            'project_id',
            'initiating_id',
            'project_id',
            'initiating_id'
        );
    }

    public function acquisitions() {
        return $this->hasMany(AcquisitionPlanning::class, 'project_id', 'project_id');
    }


    public function communications() {
        return $this->hasMany(Communication::class, 'communication_project_id', 'project_id');
    }


    public function quality(): HasMany|self {
        return $this->hasMany(QualityPlanning::class, 'project_id', 'project_id');
    }

    public function tasks(): HasMany {
        return $this->hasMany(Task::class, 'task_project', 'project_id');
    }

    public function minutes(): HasMany {
        return $this->hasMany(ProjectMinute::class, 'project_id', 'project_id');
    }

    protected static function booted(): void {
        static::deleting(static function (Project $project) {
            // 1. Detach many-to-many pivots
            $project->contacts()->detach();
            $project->departments()->detach();

            // 2. Delete RACI entries
            DB::table('dotp_raci')->where('project_id', $project->project_id)->delete();

            // 3. Delete Project training needs
            DB::table('dotp_need_for_training')->where('project_id', $project->project_id)->delete();

            // 4. Delete Project post-mortem analysis (closure)
            DB::table('dotp_post_mortem_analysis')->where('project_name', $project->project_name)->delete();

            // 5. Delete baseline and baseline tasks
            $baselineIds = DB::table('dotp_monitoring_baseline')
                ->where('project_id', $project->project_id)
                ->pluck('baseline_id');
            if ($baselineIds->isNotEmpty()) {
                DB::table('dotp_monitoring_baseline_task')
                    ->whereIn('baseline_id', $baselineIds)
                    ->delete();
                DB::table('dotp_monitoring_baseline')
                    ->where('project_id', $project->project_id)
                    ->delete();
            }

            // 6. Delete Budget and budget reserves
            DB::table('dotp_budget_reserve')->where('budget_reserve_project_id', $project->project_id)->delete();
            DB::table('dotp_budget')->where('budget_project_id', $project->project_id)->delete();

            // 7. Delete Costs
            DB::table('dotp_costs')->where('cost_project_id', $project->project_id)->delete();

            // 8. Delete Initiating Stakeholders and Initiating Charter
            if ($project->initiating) {
                $project->initiating->stakeholders()->delete();
                $project->initiating->delete();
            }

            // 9. Delete Quality Planning and its child entities (Goal, Question, Metric, Req, Assurance)
            $project->quality->each(static function ($q) {
                $q->requirements()->delete();
                $q->assuranceItems()->delete();
                $q->goals->each(static function ($g) {
                    $g->questions->each(static function ($quest) {
                        $quest->metrics()->delete();
                        $quest->delete();
                    });
                    $g->delete();
                });
                $q->delete();
            });

            // 10. Delete Communication, issuers, and receptors
            $project->communications->each(static function ($c) {
                $c->issuers()->delete();
                $c->receptors()->delete();
                $c->delete();
            });

            // 11. Delete Acquisitions, criteria, requirements, and roles
            $project->acquisitions->each(static function ($a) {
                $a->criteria()->delete();
                $a->requirements()->delete();
                $a->roles()->delete();
                $a->delete();
            });

            // 12. Delete Risks and Risk Management Plan
            DB::table('dotp_risks_management_plan')->where('project_id', $project->project_id)->delete();
            $project->risks()->delete();

            // 13. Delete Tasks, log, estimation, estimated roles, allocations, dependencies, user pivots, and eap pivots
            $taskIds = $project->tasks()->pluck('task_id');
            if ($taskIds->isNotEmpty()) {
                DB::table('dotp_task_dependencies')
                    ->whereIn('dependencies_task_id', $taskIds)
                    ->orWhereIn('dependencies_req_task_id', $taskIds)
                    ->delete();

                DB::table('dotp_user_tasks')
                    ->whereIn('task_id', $taskIds)
                    ->delete();

                DB::table('dotp_tasks_workpackages')
                    ->whereIn('task_id', $taskIds)
                    ->delete();

                DB::table('dotp_task_log')
                    ->whereIn('task_log_task', $taskIds)
                    ->delete();

                DB::table('dotp_project_tasks_estimations')
                    ->whereIn('task_id', $taskIds)
                    ->delete();

                $roleIds = DB::table('dotp_project_tasks_estimated_roles')
                    ->whereIn('task_id', $taskIds)
                    ->pluck('id');
                if ($roleIds->isNotEmpty()) {
                    DB::table('dotp_human_resource_allocation')
                        ->whereIn('project_tasks_estimated_roles_id', $roleIds)
                        ->delete();
                }

                DB::table('dotp_project_tasks_estimated_roles')
                    ->whereIn('task_id', $taskIds)
                    ->delete();

                $project->tasks()->delete();
            }

            // 14. Delete WBS items (EAP items)
            $project->wbsItems()->delete();

            // 15. Delete minutes and minute members
            $minuteIds = $project->minutes()->pluck('id');
            if ($minuteIds->isNotEmpty()) {
                DB::table('dotp_task_minute_members')
                    ->whereIn('task_minute_id', $minuteIds)
                    ->delete();
                $project->minutes()->delete();
            }
        });
    }
}

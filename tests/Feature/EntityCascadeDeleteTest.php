<?php

namespace Tests\Feature;

use App\Models\Company\Company;
use App\Models\Company\CompanyPolicy;
use App\Models\Initiating\Initiating;
use App\Models\Initiating\InitiatingStakeholder;
use App\Models\Planning\Acquisition\AcquisitionPlanning;
use App\Models\Planning\Communication\Communication;
use App\Models\Planning\Quality\QualityPlanning;
use App\Models\Planning\Quality\QualityGoal;
use App\Models\Planning\Quality\QualityAnalysisQuestion;
use App\Models\Planning\Quality\QualityMetric;
use App\Models\Planning\Risk\Risk;
use App\Models\Project\Project;
use App\Models\Project\ProjectMinute;
use App\Models\Project\ProjectWbsItem;
use App\Models\Project\Task\Task;
use App\Models\User\User;
use App\Models\User\UserContact;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class EntityCascadeDeleteTest extends TestCase
{
    use DatabaseTransactions;

    protected User $user;

    protected function setUp(): void
    {
        parent::setUp();
        $this->user = User::where('user_username', 'admin')->first();
        $this->actingAs($this->user);
    }

    /**
     * Test T003: Task deletion cascades to all task-related records.
     */
    public function test_deleting_task_cascades_to_all_related_task_details(): void
    {
        // 1. Create project
        $existingProject = Project::first();
        $projectData = $existingProject ? $existingProject->toArray() : [
            'project_name' => 'Original Project',
            'project_company' => 1,
            'project_owner' => $this->user->user_id,
            'project_creator' => $this->user->user_id,
            'project_status' => 1,
        ];
        unset($projectData['project_id']);
        unset($projectData['project_start_date']);
        unset($projectData['project_end_date']);
        $project = Project::create($projectData);

        // 2. Create WBS Item
        $wbs = ProjectWbsItem::create([
            'project_id' => $project->project_id,
            'item_name' => 'Test WBS Item',
            'number' => '1',
            'sort_order' => 1,
            'is_leaf' => 1,
            'identation' => '',
        ]);

        // 3. Create primary task
        $existingTask = Task::first();
        $taskData = $existingTask ? $existingTask->toArray() : [];
        unset($taskData['task_id']);
        unset($taskData['task_start_date']);
        unset($taskData['task_end_date']);
        $taskData['task_project'] = $project->project_id;
        $taskData['task_name'] = 'Test Cascade Primary Task';
        $task = Task::create($taskData);

        // 4. Create related task details
        // Dependency (predecessor/successor)
        $reqTaskData = $taskData;
        $reqTaskData['task_name'] = 'Required Task';
        $reqTask = Task::create($reqTaskData);
        DB::table('dotp_task_dependencies')->insert([
            'dependencies_task_id' => $task->task_id,
            'dependencies_req_task_id' => $reqTask->task_id,
        ]);

        // User task allocation pivot
        DB::table('dotp_user_tasks')->insert([
            'task_id' => $task->task_id,
            'user_id' => $this->user->user_id,
        ]);

        // Tasks workpackages pivot
        DB::table('dotp_tasks_workpackages')->insert([
            'task_id' => $task->task_id,
            'eap_item_id' => $wbs->id,
        ]);

        // Task log
        DB::table('dotp_task_log')->insert([
            'task_log_task' => $task->task_id,
            'task_log_name' => 'Test Log',
            'task_log_hours' => 2.5,
            'task_log_creator' => $this->user->user_id,
            'task_log_date' => now(),
        ]);

        // Task estimation
        DB::table('dotp_project_tasks_estimations')->insert([
            'task_id' => $task->task_id,
            'effort' => 10,
            'effort_unit' => 'hours',
            'duration' => 5,
        ]);

        // Estimated roles & Allocations
        $roleId = DB::table('dotp_project_tasks_estimated_roles')->insertGetId([
            'task_id' => $task->task_id,
        ]);

        $hrId = DB::table('dotp_human_resource')->first()?->human_resource_id;
        if (!$hrId) {
            $hrId = DB::table('dotp_human_resource')->insertGetId([
                'human_resource_user_id' => $this->user->user_id,
            ]);
        }

        DB::table('dotp_human_resource_allocation')->insert([
            'project_tasks_estimated_roles_id' => $roleId,
            'human_resource_id' => $hrId,
        ]);

        // 5. Delete the task directly
        $task->delete();

        // 6. Assert all related details are removed
        $this->assertDatabaseMissing('dotp_tasks', ['task_id' => $task->task_id]);
        $this->assertDatabaseMissing('dotp_task_dependencies', ['dependencies_task_id' => $task->task_id]);
        $this->assertDatabaseMissing('dotp_user_tasks', ['task_id' => $task->task_id]);
        $this->assertDatabaseMissing('dotp_tasks_workpackages', ['task_id' => $task->task_id]);
        $this->assertDatabaseMissing('dotp_task_log', ['task_log_task' => $task->task_id]);
        $this->assertDatabaseMissing('dotp_project_tasks_estimations', ['task_id' => $task->task_id]);
        $this->assertDatabaseMissing('dotp_human_resource_allocation', ['project_tasks_estimated_roles_id' => $roleId]);
        $this->assertDatabaseMissing('dotp_project_tasks_estimated_roles', ['id' => $roleId]);
    }

    /**
     * Test T004: QualityGoal deletion cascades to QualityAnalysisQuestion and QualityMetric.
     */
    public function test_deleting_quality_goal_cascades_to_questions_and_metrics(): void
    {
        $projectId = Project::first()?->project_id ?? 1;

        // 1. Setup quality planning
        $quality = QualityPlanning::create([
            'project_id' => $projectId,
            'quality_controlling' => 'Test Control',
            'quality_assurance' => 'Test Assurance',
            'quality_policies' => 'Test Policies',
        ]);

        // 2. Setup GQM Goal
        $goal = QualityGoal::create([
            'quality_planning_id' => $quality->id,
            'gqm_goal_object' => 'Test Object',
            'gqm_goal_propose' => 'Test Propose',
        ]);

        // 3. Setup GQM Question
        $question = QualityAnalysisQuestion::create([
            'goal_id' => $goal->id,
            'question' => 'Test Question',
            'target' => 'Test Target',
        ]);

        // 4. Setup GQM Metric
        $metric = QualityMetric::create([
            'question_id' => $question->id,
            'metric_name' => 'Test Metric',
            'gqm_metric_scale' => 'Test Scale',
        ]);

        // 5. Delete Goal
        $goal->delete();

        // 6. Assert cascades
        $this->assertDatabaseMissing('dotp_quality_control_goal', ['id' => $goal->id]);
        $this->assertDatabaseMissing('dotp_quality_control_analiysis_question', ['id' => $question->id]);
        $this->assertDatabaseMissing('dotp_quality_control_metric', ['id' => $metric->id]);
    }

    /**
     * Test T004: QualityAnalysisQuestion deletion cascades to QualityMetric.
     */
    public function test_deleting_quality_question_cascades_to_metrics(): void
    {
        $projectId = Project::first()?->project_id ?? 1;

        $quality = QualityPlanning::create([
            'project_id' => $projectId,
            'quality_controlling' => 'Test Control 2',
            'quality_assurance' => 'Test Assurance 2',
            'quality_policies' => 'Test Policies 2',
        ]);

        $goal = QualityGoal::create([
            'quality_planning_id' => $quality->id,
            'gqm_goal_object' => 'Test Object 2',
            'gqm_goal_propose' => 'Test Propose 2',
        ]);

        $question = QualityAnalysisQuestion::create([
            'goal_id' => $goal->id,
            'question' => 'Test Question 2',
            'target' => 'Test Target 2',
        ]);

        $metric = QualityMetric::create([
            'question_id' => $question->id,
            'metric_name' => 'Test Metric 2',
            'gqm_metric_scale' => 'Test Scale 2',
        ]);

        $question->delete();

        $this->assertDatabaseMissing('dotp_quality_control_analiysis_question', ['id' => $question->id]);
        $this->assertDatabaseMissing('dotp_quality_control_metric', ['id' => $metric->id]);
    }

    /**
     * Test T005: Communication deletion cascades to Issuing and Receptor.
     */
    public function test_deleting_communication_cascades_to_issuers_and_receptors(): void
    {
        $projectId = Project::first()?->project_id ?? 1;

        // 1. Setup channel and frequency
        $channel = DB::table('dotp_communication_channel')->first()?->communication_channel_id ?? 1;
        $frequency = DB::table('dotp_communication_frequency')->first()?->communication_frequency_id ?? 1;

        // 2. Setup Communication
        $comm = Communication::create([
            'communication_project_id' => $projectId,
            'communication_title' => 'Test Comm Deletion',
            'communication_information' => 'Test Info',
            'communication_restrictions' => 'None',
            'communication_channel_id' => $channel,
            'communication_frequency_id' => $frequency,
            'communication_date' => now(),
            'communication_responsible_authorization' => $this->user->user_id,
        ]);

        // 3. Setup Issuer and Receptor
        $issuerId = DB::table('dotp_communication_issuing')->insertGetId([
            'communication_id' => $comm->communication_id,
            'communication_stakeholder_id' => $this->user->user_id,
        ]);
        $receptorId = DB::table('dotp_communication_receptor')->insertGetId([
            'communication_id' => $comm->communication_id,
            'communication_stakeholder_id' => $this->user->user_id,
        ]);

        // 4. Delete
        $comm->delete();

        // 5. Assert
        $this->assertDatabaseMissing('dotp_communication', ['communication_id' => $comm->communication_id]);
        $this->assertDatabaseMissing('dotp_communication_issuing', ['communication_issuing_id' => $issuerId]);
        $this->assertDatabaseMissing('dotp_communication_receptor', ['communication_receptor_id' => $receptorId]);
    }

    /**
     * Test T006: AcquisitionPlanning deletion cascades to criteria, requirements, and roles.
     */
    public function test_deleting_acquisition_cascades_to_criteria_requirements_and_roles(): void
    {
        $projectId = Project::first()?->project_id ?? 1;

        // 1. Setup Acquisition
        $acq = AcquisitionPlanning::create([
            'project_id' => $projectId,
            'items_to_be_acquired' => 'Cascade Item',
            'contract_type' => 'Contract',
            'documents_to_acquisition' => 'Doc',
            'supplier_management_process' => 'Process',
        ]);

        // 2. Setup related items
        $criteriaId = DB::table('dotp_acquisition_planning_criteria')->insertGetId([
            'acquisition_id' => $acq->id,
            'criteria' => 'Test Criteria',
            'weight' => 1,
        ]);
        $reqId = DB::table('dotp_acquisition_planning_requirements')->insertGetId([
            'acquisition_id' => $acq->id,
            'requirement' => 'Test Req',
        ]);
        $roleId = DB::table('dotp_acquisition_planning_roles')->insertGetId([
            'acquisition_id' => $acq->id,
            'role' => 'Test Role',
            'responsability' => 'Test Resp',
        ]);

        // 3. Delete
        $acq->delete();

        // 4. Assert
        $this->assertDatabaseMissing('dotp_acquisition_planning', ['id' => $acq->id]);
        $this->assertDatabaseMissing('dotp_acquisition_planning_criteria', ['id' => $criteriaId]);
        $this->assertDatabaseMissing('dotp_acquisition_planning_requirements', ['id' => $reqId]);
        $this->assertDatabaseMissing('dotp_acquisition_planning_roles', ['id' => $roleId]);
    }

    /**
     * Test T007: Company deletion cascades to Policies and Roles.
     */
    public function test_deleting_company_without_projects_cascades_to_policy_and_roles(): void
    {
        // 1. Create company
        $company = Company::create([
            'company_name' => 'Cascade Company',
            'company_owner' => $this->user->user_id,
        ]);

        // 2. Create related policy
        $policy = CompanyPolicy::create([
            'company_policies_company_id' => $company->company_id,
            'company_policies_policy' => 'Test Policy',
        ]);

        // 3. Create related HR role
        $roleId = DB::table('dotp_human_resources_role')->insertGetId([
            'human_resources_role_company_id' => $company->company_id,
            'human_resources_role_name' => 'Test Role',
        ]);

        // 4. Delete company
        $company->delete();

        // 5. Assert
        $this->assertDatabaseMissing('dotp_companies', ['company_id' => $company->company_id]);
        $this->assertDatabaseMissing('dotp_company_policies', ['company_policies_id' => $policy->company_policies_id]);
        $this->assertDatabaseMissing('dotp_human_resources_role', ['human_resources_role_id' => $roleId]);
    }

    /**
     * Test T012: Restrict deleting a company if it has active projects.
     */
    public function test_deleting_company_fails_if_active_projects_exist(): void
    {
        // 1. Create company
        $company = Company::create([
            'company_name' => 'Protected Company',
            'company_owner' => $this->user->user_id,
        ]);

        // 2. Create project associated with the company
        $existingProject = Project::first();
        $projectData = $existingProject ? $existingProject->toArray() : [
            'project_name' => 'Original Project',
            'project_owner' => $this->user->user_id,
            'project_creator' => $this->user->user_id,
            'project_status' => 1,
        ];
        unset($projectData['project_id']);
        unset($projectData['project_start_date']);
        unset($projectData['project_end_date']);
        $projectData['project_name'] = 'Protected Company Project';
        $projectData['project_short_name'] = 'PCP';
        $projectData['project_company'] = $company->company_id;
        $project = Project::create($projectData);

        // 3. Call DELETE route
        $response = $this->delete(route('companies.destroy', $company->company_id));

        // 4. Assert redirect back to index
        $response->assertStatus(302);
        $response->assertRedirect(route('companies.index'));
        $response->assertSessionHas('error');

        // 5. Assert database records STILL exist
        $this->assertDatabaseHas('dotp_companies', ['company_id' => $company->company_id]);
        $this->assertDatabaseHas('dotp_projects', ['project_id' => $project->project_id]);
    }
}

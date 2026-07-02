<?php

namespace Tests\Feature;

use App\Models\Initiating\Initiating;
use App\Models\Initiating\InitiatingStakeholder;
use App\Models\Planning\Acquisition\AcquisitionPlanning;
use App\Models\Planning\Communication\Communication;
use App\Models\Planning\Quality\QualityPlanning;
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

class ProjectDeleteTest extends TestCase
{
    use DatabaseTransactions;

    /**
     * Test that deleting a project cascades and deletes all related entities cleanly.
     */
    public function test_deleting_project_cascades_to_all_related_entities(): void
    {
        // 1. Authenticate user
        $user = User::where('user_username', 'admin')->first();
        $this->actingAs($user);

        // 2. Create target project
        $existingProject = Project::first();
        $projectData = $existingProject ? $existingProject->toArray() : [
            'project_name' => 'Original Project',
            'project_company' => 1,
            'project_owner' => $user->user_id,
            'project_creator' => $user->user_id,
            'project_status' => 1,
        ];
        unset($projectData['project_id']);
        unset($projectData['project_start_date']);
        unset($projectData['project_end_date']);
        $projectData['project_name'] = 'Cascade Delete Test Project';
        $projectData['project_short_name'] = 'CDTP';
        $project = Project::create($projectData);

        // 3. Create dependent resources
        // WBS Item
        $wbs = ProjectWbsItem::create([
            'project_id' => $project->project_id,
            'item_name' => 'Test WBS Item',
            'number' => '1',
            'sort_order' => 1,
            'is_leaf' => 1,
            'identation' => '',
        ]);

        // Task
        $existingTask = Task::first();
        $taskData = $existingTask ? $existingTask->toArray() : [
            'task_name' => 'Original Task',
            'task_status' => 0,
        ];
        unset($taskData['task_id']);
        unset($taskData['task_start_date']);
        unset($taskData['task_end_date']);
        $taskData['task_project'] = $project->project_id;
        $taskData['task_name'] = 'Test Task';
        $task = Task::create($taskData);

        // Task Workpackage Pivot
        DB::table('dotp_tasks_workpackages')->insert([
            'task_id' => $task->task_id,
            'eap_item_id' => $wbs->id,
        ]);

        // Risk
        $existingRisk = Risk::first();
        $riskData = $existingRisk ? $existingRisk->toArray() : [
            'risk_name' => 'Original Risk',
            'risk_status' => 0,
        ];
        unset($riskData['risk_id']);
        unset($riskData['risk_period_start_date']);
        unset($riskData['risk_period_end_date']);
        $riskData['risk_project'] = $project->project_id;
        $riskData['risk_name'] = 'Test Risk';
        $risk = Risk::create($riskData);

        // Acquisition
        $acquisition = AcquisitionPlanning::create([
            'project_id' => $project->project_id,
            'items_to_be_acquired' => 'Test Item',
            'contract_type' => 'Test Contract',
            'documents_to_acquisition' => 'Test Doc',
            'supplier_management_process' => 'Test Process',
        ]);

        // Communication
        $channel = DB::table('dotp_communication_channel')->first()?->communication_channel_id;
        if (!$channel) {
            $channel = DB::table('dotp_communication_channel')->insertGetId(['communication_channel' => 'Email']);
        }
        $frequency = DB::table('dotp_communication_frequency')->first()?->communication_frequency_id;
        if (!$frequency) {
            $frequency = DB::table('dotp_communication_frequency')->insertGetId([
                'communication_frequency' => 'Weekly',
                'communication_frequency_hasdate' => 0
            ]);
        }

        $communication = Communication::create([
            'communication_project_id' => $project->project_id,
            'communication_title' => 'Test Comm',
            'communication_information' => 'Test Info',
            'communication_restrictions' => 'None',
            'communication_channel_id' => $channel,
            'communication_frequency_id' => $frequency,
            'communication_date' => now(),
            'communication_responsible_authorization' => $user->user_id,
        ]);

        // Quality Planning
        $quality = QualityPlanning::create([
            'project_id' => $project->project_id,
            'quality_controlling' => 'Test Control',
            'quality_assurance' => 'Test Assurance',
            'quality_policies' => 'Test Policies',
        ]);

        // Initiating Charter
        $initiating = Initiating::create([
            'project_id' => $project->project_id,
            'initiating_title' => 'Test Charter',
            'initiating_manager' => $user->user_id,
            'initiating_create_by' => $user->user_id,
            'initiating_date_create' => now(),
        ]);

        // Initiating Stakeholder
        $contact = UserContact::first() ?? UserContact::create([
            'contact_first_name' => 'Test',
            'contact_last_name' => 'Contact',
        ]);
        $stakeholder = InitiatingStakeholder::create([
            'initiating_id' => $initiating->initiating_id,
            'contact_id' => $contact->contact_id,
            'stakeholder_responsibility' => 'Test Resp',
            'stakeholder_interest' => 'High',
            'stakeholder_power' => 'High',
            'stakeholder_strategy' => 'Strategy',
        ]);

        // Project Minute
        $minute = ProjectMinute::create([
            'project_id' => $project->project_id,
            'minute_date' => now(),
            'description' => 'Test Minute',
        ]);

        // Project Minute Member Pivot
        DB::table('dotp_task_minute_members')->insert([
            'task_minute_id' => $minute->id,
            'user_id' => $user->user_id,
        ]);

        // 4. Send delete request
        $response = $this->delete(route('projects.destroy', $project->project_id));

        // 5. Assert successful redirect response
        $response->assertStatus(302);
        $response->assertRedirect(route('projects.index'));

        // 6. Assert that project and all dependent records are deleted from the database
        $this->assertDatabaseMissing('dotp_projects', ['project_id' => $project->project_id]);
        $this->assertDatabaseMissing('dotp_project_eap_items', ['id' => $wbs->id]);
        $this->assertDatabaseMissing('dotp_tasks', ['task_id' => $task->task_id]);
        $this->assertDatabaseMissing('dotp_tasks_workpackages', [
            'task_id' => $task->task_id,
            'eap_item_id' => $wbs->id,
        ]);
        $this->assertDatabaseMissing('dotp_risks', ['risk_id' => $risk->risk_id]);
        $this->assertDatabaseMissing('dotp_acquisition_planning', ['id' => $acquisition->id]);
        $this->assertDatabaseMissing('dotp_communication', ['communication_id' => $communication->communication_id]);
        $this->assertDatabaseMissing('dotp_quality_planning', ['id' => $quality->id]);
        $this->assertDatabaseMissing('dotp_initiating', ['initiating_id' => $initiating->initiating_id]);
        $this->assertDatabaseMissing('dotp_initiating_stakeholder', ['initiating_stakeholder_id' => $stakeholder->initiating_stakeholder_id]);
        $this->assertDatabaseMissing('dotp_project_minutes', ['id' => $minute->id]);
        $this->assertDatabaseMissing('dotp_task_minute_members', [
            'task_minute_id' => $minute->id,
            'user_id' => $user->user_id,
        ]);
    }

    /**
     * Test that if an exception is thrown during project deletion,
     * the entire operation is rolled back and no records are deleted.
     */
    public function test_project_deletion_rolls_back_on_failure(): void
    {
        // 1. Authenticate user
        $user = User::where('user_username', 'admin')->first();
        $this->actingAs($user);

        // 2. Create target project
        $existingProject = Project::first();
        $projectData = $existingProject ? $existingProject->toArray() : [
            'project_name' => 'Original Project',
            'project_company' => 1,
            'project_owner' => $user->user_id,
            'project_creator' => $user->user_id,
            'project_status' => 1,
        ];
        unset($projectData['project_id']);
        unset($projectData['project_start_date']);
        unset($projectData['project_end_date']);
        $projectData['project_name'] = 'Rollback Test Project';
        $projectData['project_short_name'] = 'RTP';
        $project = Project::create($projectData);

        // Create a dependent minute
        $minute = ProjectMinute::create([
            'project_id' => $project->project_id,
            'minute_date' => now(),
            'description' => 'Rollback Test Minute',
        ]);

        // Create a dependent initiating charter
        $initiating = Initiating::create([
            'project_id' => $project->project_id,
            'initiating_title' => 'Rollback Test Charter',
            'initiating_manager' => $user->user_id,
            'initiating_create_by' => $user->user_id,
            'initiating_date_create' => now(),
        ]);

        // Create a dependent RACI entry
        $hrId = DB::table('dotp_human_resource')->first()?->human_resource_id;
        if (!$hrId) {
            $hrId = DB::table('dotp_human_resource')->insertGetId([
                'human_resource_user_id' => $user->user_id,
            ]);
        }
        DB::table('dotp_raci')->insert([
            'human_resource_id' => $hrId,
            'project_id' => $project->project_id,
            'activity_name' => 'Rollback Test RACI Activity',
            'raci_role' => 'R',
        ]);

        // Register a listener on Initiating deleting to simulate a failure
        Initiating::deleting(function ($i) {
            throw new \RuntimeException('Simulated database failure during initiating deletion.');
        });

        // 3. Send delete request and expect a 500 status code since it throws an exception
        $response = $this->delete(route('projects.destroy', $project->project_id));
        $response->assertStatus(500);

        // 4. Assert that project, initiating, minute, and RACI STILL EXIST in the database due to rollback
        $this->assertDatabaseHas('dotp_projects', ['project_id' => $project->project_id]);
        $this->assertDatabaseHas('dotp_project_minutes', ['id' => $minute->id]);
        $this->assertDatabaseHas('dotp_initiating', ['initiating_id' => $initiating->initiating_id]);
        $this->assertDatabaseHas('dotp_raci', [
            'project_id' => $project->project_id,
            'activity_name' => 'Rollback Test RACI Activity',
        ]);

        // Clean up the event listener so it doesn't affect other tests
        Initiating::flushEventListeners();
    }
}

<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Faker\Factory as Faker;
use App\Models\User\User;
use App\Models\User\UserContact;
use App\Models\Company\Company;
use App\Models\Department\Department;
use App\Models\Project\Project;
use App\Models\Project\Task\Task;

class OfficialDataSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $faker = Faker::create('pt_BR');

        // Disable foreign key checks for clean insertions/truncations if desired,
        // but we'll do it safely by seeding in order.
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');

        // Optional: clear existing records to avoid duplicate keys during stress-test run
        DB::table('dotp_user_tasks')->truncate();
        DB::table('dotp_project_departments')->truncate();
        DB::table('dotp_project_contacts')->truncate();
        DB::table('dotp_tasks')->truncate();
        DB::table('dotp_projects')->truncate();
        DB::table('dotp_departments')->truncate();
        DB::table('dotp_companies')->truncate();
        
        // Keep standard users but we can truncate/delete fake ones
        // To be safe, let's clear dotp_users and dotp_contacts
        DB::table('dotp_users')->truncate();
        DB::table('dotp_contacts')->truncate();

        DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        // 1. Create standard admin user & contact
        $adminContact = UserContact::create([
            'contact_first_name' => 'Admin',
            'contact_last_name' => 'DotProject',
            'contact_title' => 'Administrator',
            'contact_birthday' => '1990-01-01',
            'contact_company' => 'DotProject Corp',
            'contact_email' => 'admin@admin.com',
            'contact_phone' => '11999999999',
            'contact_address1' => 'Rua do TCC, 123',
            'contact_city' => 'São Paulo',
            'contact_state' => 'SP',
            'contact_zip' => '01000-000',
        ]);

        $adminUser = User::create([
            'user_username' => 'admin',
            'user_password' => Hash::make('admin123'),
            'user_contact' => $adminContact->contact_id,
            'user_type' => 1, // Admin / Owner type
            'user_company' => 0,
            'user_department' => 0,
            'user_parent' => 0,
        ]);

        // Create 30 other users / resources
        $users = [$adminUser];
        for ($i = 0; $i < 30; $i++) {
            $contact = UserContact::create([
                'contact_first_name' => $faker->firstName,
                'contact_last_name' => $faker->lastName,
                'contact_title' => $faker->jobTitle,
                'contact_birthday' => $faker->date('Y-m-d', '-20 years'),
                'contact_company' => $faker->company,
                'contact_email' => $faker->unique()->safeEmail,
                'contact_phone' => $faker->phoneNumber,
                'contact_address1' => $faker->streetAddress,
                'contact_city' => $faker->city,
                'contact_state' => $faker->stateAbbr,
                'contact_zip' => substr($faker->postcode, 0, 11),
            ]);

            $user = User::create([
                'user_username' => $faker->unique()->userName,
                'user_password' => Hash::make('password'),
                'user_contact' => $contact->contact_id,
                'user_type' => 0,
                'user_company' => 0,
                'user_department' => 0,
                'user_parent' => 0,
            ]);
            $users[] = $user;
        }

        // 2. Create 25 Companies
        $companies = [];
        for ($i = 0; $i < 25; $i++) {
            $company = Company::create([
                'company_name' => $faker->company,
                'company_phone1' => $faker->phoneNumber,
                'company_address1' => $faker->streetAddress,
                'company_city' => $faker->city,
                'company_state' => $faker->stateAbbr,
                'company_zip' => substr($faker->postcode, 0, 11),
                'company_primary_url' => $faker->url,
                'company_owner' => $adminUser->user_id,
                'company_description' => $faker->sentence,
                'company_type' => $faker->randomElement([0, 1]), // Client or Supplier
                'company_email' => $faker->companyEmail,
            ]);
            $companies[] = $company;
        }

        // 3. Create 75 Departments distributed among companies
        $departments = [];
        $deptNames = ['Tecnologia', 'Recursos Humanos', 'Financeiro', 'Marketing', 'Operações', 'Vendas', 'Jurídico', 'Qualidade'];
        foreach ($companies as $company) {
            $numDepts = rand(2, 4);
            $selectedDepts = $faker->randomElements($deptNames, $numDepts);
            foreach ($selectedDepts as $name) {
                $dept = Department::create([
                    'dept_company' => $company->company_id,
                    'dept_name' => $name,
                    'dept_phone' => $company->company_phone1,
                    'dept_desc' => "Departamento de $name da empresa {$company->company_name}",
                    'dept_owner' => $adminUser->user_id,
                    'dept_parent' => 0,
                ]);
                $departments[] = $dept;
            }
        }

        // 4. Create 150-180 Projects distributed among companies
        $projects = [];
        $projectTemplates = [
            'Implantação de ERP', 'Migração de Nuvem', 'Desenvolvimento de App Mobile', 'Campanha de Marketing Digital',
            'Reestruturação Organizacional', 'Auditoria de Processos', 'Segurança da Informação', 'Portal do Cliente',
            'Integração de APIs', 'Análise de Big Data', 'Infraestrutura de Rede', 'Capacitação de Equipes'
        ];
        $numProjects = rand(150, 180);
        for ($p = 0; $p < $numProjects; $p++) {
            $company = $faker->randomElement($companies);
            $name = $faker->randomElement($projectTemplates) . ' - ' . $faker->words(2, true);
            $startDate = now()->subDays(rand(1, 100));
            $endDate = (clone $startDate)->addDays(rand(30, 365));
            
            $project = Project::create([
                'project_company' => $company->company_id,
                'project_name' => $name,
                'project_short_name' => strtoupper(substr(preg_replace('/[^A-Za-z0-9]/', '', $name), 0, 10)),
                'project_owner' => $adminUser->user_id,
                'project_creator' => $adminUser->user_id,
                'project_start_date' => $startDate,
                'project_end_date' => $endDate,
                'project_status' => $faker->randomElement([0, 1, 2, 3, 4, 5]),
                'project_percent_complete' => rand(0, 100),
                'project_color_identifier' => substr($faker->safeHexColor, 1),
                'project_description' => $faker->paragraph,
                'project_target_budget' => rand(10000, 500000),
                'project_priority' => rand(0, 3),
                'project_type' => 0,
            ]);
            $projects[] = $project;

            // Associate some departments to the project
            $compDepts = array_values(array_filter($departments, fn($d) => $d->dept_company === $company->company_id));
            if (!empty($compDepts)) {
                $projDepts = $faker->randomElements($compDepts, min(count($compDepts), rand(1, 2)));
                foreach ($projDepts as $pd) {
                    DB::table('dotp_project_departments')->insert([
                        'project_id' => $project->project_id,
                        'department_id' => $pd->dept_id,
                    ]);
                }
            }
        }

        // 5. Create 1000+ Tasks/Activities distributed among projects
        $taskTemplates = [
            'Planejamento Inicial', 'Definição de Requisitos', 'Design da Arquitetura', 'Modelagem do Banco de Dados',
            'Desenvolvimento Front-end', 'Desenvolvimento Back-end', 'Configuração do Ambiente', 'Testes Unitários',
            'Testes de Integração', 'Correção de Bugs', 'Homologação com Usuários', 'Deploy em Produção', 'Treinamento',
            'Encerramento do Projeto'
        ];
        
        foreach ($projects as $project) {
            $numTasks = rand(6, 10);
            $projectDuration = $project->project_end_date->diffInDays($project->project_start_date);
            $taskDuration = max(1, floor($projectDuration / $numTasks));

            for ($t = 0; $t < $numTasks; $t++) {
                $taskStart = (clone $project->project_start_date)->addDays($t * $taskDuration);
                $taskEnd = (clone $taskStart)->addDays(rand(1, $taskDuration));
                $taskOwner = $faker->randomElement($users);

                $task = Task::create([
                    'task_name' => ($t + 1) . '. ' . $faker->randomElement($taskTemplates),
                    'task_parent' => 0,
                    'task_milestone' => ($t === $numTasks - 1) ? 1 : 0,
                    'task_project' => $project->project_id,
                    'task_owner' => $taskOwner->user_id,
                    'task_creator' => $adminUser->user_id,
                    'task_start_date' => $taskStart,
                    'task_end_date' => $taskEnd,
                    'task_duration' => rand(4, 40),
                    'task_duration_type' => 1, // hours
                    'task_status' => $faker->randomElement([0, -1, 1, 2]),
                    'task_priority' => rand(-1, 1),
                    'task_percent_complete' => rand(0, 100),
                    'task_description' => $faker->sentence,
                    'task_target_budget' => rand(500, 10000),
                    'task_client_publish' => 0,
                    'task_dynamic' => 0,
                    'task_access' => 0,
                    'task_notify' => 0,
                    'task_order' => $t,
                ]);

                // Assign resources (users) to the task
                $numResources = rand(1, 3);
                $assignedUsers = $faker->randomElements($users, $numResources);
                foreach ($assignedUsers as $au) {
                    DB::table('dotp_user_tasks')->insert([
                        'task_id' => $task->task_id,
                        'user_id' => $au->user_id,
                        'perc_assignment' => rand(10, 100),
                        'user_type' => 0,
                        'user_task_priority' => 0,
                    ]);
                }
            }
        }
    }
}

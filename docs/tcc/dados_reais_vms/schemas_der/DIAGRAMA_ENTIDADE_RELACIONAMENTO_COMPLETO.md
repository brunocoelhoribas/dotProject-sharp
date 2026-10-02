# Diagramas Entidade-Relacionamento (DER) Completos: dotProject+ (2018) vs. dotProject# (2026)

**Projeto:** Modernização do dotProject+ (PHP 5.2 / MyISAM) para dotProject# (PHP 8.4 / Laravel 12 / InnoDB)  
**Instituição:** Instituto Federal Catarinense (IFC) – Campus Camboriú  
**Curso:** Bacharelado em Sistemas de Informação  
**Ambientes de Extração:**
* **dotProject+ (Legado - 2018):** VM `192.168.56.102` | MySQL 5.5 | Base: `dbdotproject_g6` | 140 tabelas | 905 colunas
* **dotProject# (Proposto - 2026):** VM `192.168.56.101` | MySQL 8.0 | Base: `dotprojectplus_2025` | 145 tabelas | 933 colunas

---

## 1. Resumo Executivo e Métricas Comparativas das Bases

A análise estrutural detalhada extraída diretamente dos bancos de dados ativos de ambas as máquinas virtuais revelou a extensão completa da evolução arquitetural:

| Métrica de Banco de Dados | dotProject+ (Legado - VM 102) | dotProject# (Proposto - VM 101) | Variação / Evolução |
| :--- | :--- | :--- | :--- |
| **Total de Tabelas** | 140 tabelas | 145 tabelas | +5 tabelas (+3,6%) |
| **Total de Colunas/Campos** | 905 atributos | 933 atributos | +28 atributos |
| **Chaves Estrangeiras Explícitas (FKs)** | 46 restrições | 52 restrições | +6 restrições formais |
| **Relacionamentos Mapeados (Total)** | 122 relacionamentos | 128 relacionamentos | +6 relacionamentos |
| **Armazenamento de Senhas** | `varchar(32)` (Hash MD5 legado) | `varchar(255)` (Bcrypt / Argon2) | Modernização Criptográfica |
| **Controle de Versão de Esquema** | Scripts `.sql` manuais dispersos | Migrations atômicas do Laravel | Rastreabilidade e Reprodutibilidade |
| **Arquivos DBML e PlantUML Gerados** | `der_dotproject_plus_legado.dbml` | `der_dotproject_sharp_proposto.dbml` | Prontos para [dbdiagram.io](https://dbdiagram.io) |

### Novas Entidades Incorporadas no dotProject#:
1. `dotp_skills`: Catálogo formal de competências técnicas (*hard skills*) e comportamentais (*soft skills*);
2. `dotp_human_resource_skills`: Relação N:M de colaboradores e competências com proficiência Likert de 1 a 5;
3. `dotp_raci`: Matriz de Governança e Responsabilidades RACI (*Responsible, Accountable, Consulted, Informed*);
4. `dotp_human_resource_performance`: Matriz 9-Box de Desempenho e Potencial (notas de 1 a 3, anotações de liderança);
5. `migrations`: Tabela de controle transacional e governança de migrações do framework Laravel.

---

## 2. Visão Macro: Arquitetura Conceitual dos Módulos

```mermaid
graph TD
    classDef core fill:#e1f5fe,stroke:#0288d1,stroke-width:2px;
    classDef rh fill:#e8f5e9,stroke:#388e3c,stroke-width:2px;
    classDef task fill:#fff3e0,stroke:#f57c00,stroke-width:2px;
    classDef cost fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px;
    classDef risk fill:#ffebee,stroke:#d32f2f,stroke-width:2px;
    classDef aux fill:#f5f5f5,stroke:#616161,stroke-width:1px;

    ORG["Módulo 1: Organização & Empresas<br/>(dotp_companies, dotp_departments)"]:::core
    PROJ["Módulo 1: Projetos & Stakeholders<br/>(dotp_projects, dotp_contacts)"]:::core
    USER["Módulo 1: Usuários & Acessos<br/>(dotp_users, dotp_permissions)"]:::core

    RH["Módulo 3: Recursos Humanos & CHA<br/>(dotp_human_resource, dotp_skills, dotp_raci, dotp_performance)"]:::rh
    TASK["Módulo 2: Tarefas, Cronograma & EAP<br/>(dotp_tasks, dotp_project_eap_items, dotp_task_log)"]:::task
    COST["Módulo 4: Custos & Curva S (EVM)<br/>(dotp_budget, dotp_costs, dotp_monitoring_baseline)"]:::cost
    RISK["Módulo 5: Riscos & EAR<br/>(dotp_risks, dotp_project_ear_items)"]:::risk
    OTHER["Módulo 6: Iniciação, Escopo, Qualidade, Aquisições<br/>(dotp_initiating, dotp_scope, dotp_quality, dotp_acquisition)"]:::aux

    ORG -->|possui departamentos e contrata| PROJ
    USER -->|gerencia e atua| PROJ
    USER -->|estende perfil 1:1| RH
    PROJ -->|contém| TASK
    RH -->|alocado em (dotp_user_tasks)| TASK
    RH -->|papel e responsabilidade| PROJ
    PROJ -->|planeja orçamento e monitora| COST
    TASK -->|aponta horas e custos| COST
    PROJ -->|identifica e trata| RISK
    PROJ -->|formaliza governança| OTHER
```

---

## 3. DERs Lógicos Modulares em Alta Resolução

Devido à grande quantidade de tabelas do sistema (145 tabelas), a visualização acadêmica é dividida pelas principais áreas de conhecimento do PMBOK:

### 3.1 Módulo 1: Núcleo Organizacional (Empresas, Departamentos, Usuários e Projetos)

Este módulo estabelece a fundação da governança e hierarquia de clientes, departamentos internos e projetos.

```mermaid
erDiagram
    dotp_companies ||--o{ dotp_departments : "dept_company"
    dotp_departments ||--o{ dotp_departments : "dept_parent (auto-rel)"
    dotp_companies ||--o{ dotp_projects : "project_company"
    dotp_users ||--o{ dotp_projects : "project_owner"
    dotp_contacts ||--o| dotp_users : "user_contact"
    dotp_projects ||--o{ dotp_project_departments : "associa"
    dotp_departments ||--o{ dotp_project_departments : "pertence"

    dotp_companies {
        int company_id PK
        string company_name
        string company_phone1
        string company_email
        int company_owner
    }

    dotp_departments {
        int dept_id PK
        int dept_parent
        int dept_company FK
        string dept_name
        string dept_phone
    }

    dotp_users {
        int user_id PK
        string user_username
        string user_password "varchar(32) legado vs varchar(255) proposto"
        int user_contact FK
        int user_type
    }

    dotp_contacts {
        int contact_id PK
        string contact_first_name
        string contact_last_name
        string contact_email
        string contact_phone
    }

    dotp_projects {
        int project_id PK
        int project_company FK
        int project_department FK
        string project_name
        string project_short_name
        int project_owner FK
        datetime project_start_date
        datetime project_end_date
        int project_status
        int project_priority
        float project_target_budget
        float project_actual_budget
    }
```

---

### 3.2 Módulo 2: Tarefas, Cronograma, EAP (WBS) e Apontamentos

Gerenciamento das entregas decompostas do projeto, dependências lógicas (Predecessoras) e apontamento de esforço em tempo real.

```mermaid
erDiagram
    dotp_projects ||--o{ dotp_tasks : "task_project"
    dotp_projects ||--o{ dotp_project_eap_items : "project_id"
    dotp_tasks ||--o{ dotp_tasks : "task_parent (subtarefas)"
    dotp_tasks ||--o{ dotp_task_dependencies : "dependencies_task_id"
    dotp_tasks ||--o{ dotp_task_dependencies : "dependencies_req_task_id"
    dotp_tasks ||--o{ dotp_task_log : "task_log_task"
    dotp_users ||--o{ dotp_task_log : "task_log_creator"
    dotp_project_eap_items ||--o{ dotp_tasks_workpackages : "eap_item_id"
    dotp_tasks ||--o{ dotp_tasks_workpackages : "task_id"
    dotp_project_eap_items ||--o| dotp_wbs_dictionary : "wbs_item_id"

    dotp_tasks {
        int task_id PK
        string task_name
        int task_project FK
        int task_owner FK
        datetime task_start_date
        datetime task_end_date
        float task_hours
        int task_percent_complete
        int task_priority
        int task_milestone
    }

    dotp_task_log {
        int task_log_id PK
        int task_log_task FK
        string task_log_name
        text task_log_description
        int task_log_creator FK
        float task_log_hours
        datetime task_log_date
    }

    dotp_project_eap_items {
        int id PK
        int project_id FK
        string item_name
        int item_parent_id
        int item_order
    }

    dotp_wbs_dictionary {
        int id PK
        int wbs_item_id FK
        text description
        text criteria
        text deliverables
    }

    dotp_tasks_workpackages {
        int id PK
        int task_id FK
        int eap_item_id FK
    }

    dotp_task_dependencies {
        int dependencies_task_id PK
        int dependencies_req_task_id PK
    }
```

---

### 3.3 Módulo 3: Recursos Humanos, Competências CHA, Governança RACI e Matriz 9-Box

Este é o **módulo central do TCC**, onde reside a maior inovação metodológica e estrutural entre as duas versões.

#### 3.3.1 DER do dotProject+ (Legado - 2018)
O modelo legado tratava o colaborador apenas como uma alocação de horas estáticas por dia da semana (`human_resource_mon` a `human_resource_sun`):

```mermaid
erDiagram
    dotp_users ||--o| dotp_human_resource : "human_resource_user_id (1:1)"
    dotp_human_resource ||--o{ dotp_human_resource_roles : "human_resource_id"
    dotp_human_resources_role ||--o{ dotp_human_resource_roles : "human_resources_role_id"
    dotp_companies ||--o{ dotp_human_resources_role : "company_id"
    dotp_users ||--o{ dotp_user_tasks : "user_id"
    dotp_tasks ||--o{ dotp_user_tasks : "task_id"

    dotp_human_resource {
        int human_resource_id PK
        int human_resource_user_id FK
        text human_resource_lattes_url
        int human_resource_mon "Horas Seg"
        int human_resource_tue "Horas Ter"
        int human_resource_wed "Horas Qua"
        int human_resource_thu "Horas Qui"
        int human_resource_fri "Horas Sex"
        int human_resource_sat "Horas Sab"
        int human_resource_sun "Horas Dom"
    }

    dotp_human_resources_role {
        int human_resources_role_id PK
        int human_resources_role_company_id FK
        string human_resources_role_name
    }

    dotp_human_resource_roles {
        int human_resource_id FK
        int human_resources_role_id FK
    }

    dotp_user_tasks {
        int user_id PK
        int task_id PK
        int perc_assignment "Percentual Alocacao"
    }
```

#### 3.3.2 DER do dotProject# (Proposto - 2026)
O modelo proposto incorpora a modelagem baseada em competências (CHA), matriz RACI para governança situacional de papéis e a matriz 9-Box para gestão contínua de talentos:

```mermaid
erDiagram
    dotp_users ||--o| dotp_human_resource : "human_resource_user_id (1:1)"
    dotp_human_resource ||--o{ dotp_human_resource_roles : "human_resource_id"
    dotp_human_resources_role ||--o{ dotp_human_resource_roles : "human_resources_role_id"
    dotp_companies ||--o{ dotp_human_resources_role : "company_id"
    dotp_companies ||--o{ dotp_human_resource_performance : "company_id FK"

    dotp_human_resource ||--o{ dotp_human_resource_skills : "human_resource_id FK"
    dotp_skills ||--o{ dotp_human_resource_skills : "skill_id FK"

    dotp_human_resource ||--o{ dotp_raci : "human_resource_id FK"
    dotp_projects ||--o{ dotp_raci : "project_id FK"

    dotp_human_resource ||--o{ dotp_human_resource_performance : "human_resource_id FK"

    dotp_skills {
        bigint id PK
        string name "Nome da Habilidade"
        string type "technical | behavioral"
        text description
        datetime created_at
        datetime updated_at
    }

    dotp_human_resource_skills {
        bigint id PK
        int human_resource_id FK
        bigint skill_id FK
        tinyint proficiency_level "Nivel 1 a 5 (Escala Likert)"
        datetime created_at
        datetime updated_at
    }

    dotp_raci {
        bigint id PK
        int human_resource_id FK
        int project_id FK
        string activity_name "Atividade/Pacote EAP"
        string raci_role "R | A | C | I"
        datetime created_at
        datetime updated_at
    }

    dotp_human_resource_performance {
        bigint id PK
        int company_id FK
        int human_resource_id FK
        tinyint performance_score "1:Baixo | 2:Medio | 3:Alto"
        tinyint potential_score "1:Baixo | 2:Medio | 3:Alto"
        text facilitator_notes "Notas da Lideranca"
        date evaluation_date "Data da Sessao"
        datetime created_at
        datetime updated_at
    }

    dotp_human_resource_roles {
        int human_resource_id FK
        int human_resources_role_id FK
        decimal hourly_rate "Custo Horario R$ (Adicionado)"
    }
```

---

### 3.4 Módulo 4: Gestão de Custos, Orçamento e Curva S (EVM)

Controle de orçamentos previstos, reservas de contingência, custos diretos de RH e Linhas de Base (*Baselines*) para o cálculo do Gerenciamento do Valor Agregado (EVM):

```mermaid
erDiagram
    dotp_projects ||--o{ dotp_budget : "budget_project_id"
    dotp_projects ||--o{ dotp_budget_reserve : "budget_reserve_project_id"
    dotp_projects ||--o{ dotp_costs : "cost_project_id"
    dotp_human_resource ||--o{ dotp_costs : "cost_human_resource_id"
    dotp_human_resources_role ||--o{ dotp_costs : "cost_human_resource_role_id"
    dotp_projects ||--o{ dotp_monitoring_baseline : "project_id"
    dotp_monitoring_baseline ||--o{ dotp_monitoring_baseline_task : "baseline_id"

    dotp_budget {
        int budget_id PK
        int budget_project_id FK
        float budget_amount
        string budget_description
    }

    dotp_budget_reserve {
        int budget_reserve_id PK
        int budget_reserve_project_id FK
        float budget_reserve_value
        string budget_reserve_description
    }

    dotp_costs {
        int cost_id PK
        int cost_project_id FK
        int cost_human_resource_id FK
        int cost_human_resource_role_id FK
        float cost_value_hour
        float cost_total
    }

    dotp_monitoring_baseline {
        int baseline_id PK
        int project_id FK
        string baseline_name
        datetime baseline_date
    }

    dotp_monitoring_baseline_task {
        int baseline_task_id PK
        int baseline_id FK
        int task_id FK
        float baseline_task_hours
        float baseline_task_cost
    }
```

---

### 3.5 Módulo 5: Gestão de Riscos e Estrutura Analítica de Riscos (EAR)

Mapeamento de ameaças e oportunidades, probabilidade versus impacto, e decomposição hierárquica por categorias de risco (EAR):

```mermaid
erDiagram
    dotp_projects ||--o{ dotp_risks : "risk_project"
    dotp_users ||--o{ dotp_risks : "risk_owner"
    dotp_projects ||--o{ dotp_project_ear_items : "project_id"
    dotp_risks ||--o{ dotp_risk_actions : "risk_id"
    dotp_project_ear_items ||--o{ dotp_ear_item_risks : "ear_item_id"
    dotp_risks ||--o{ dotp_ear_item_risks : "risk_id"

    dotp_risks {
        int risk_id PK
        string risk_name
        int risk_project FK
        int risk_owner FK
        int risk_probability
        int risk_impact
        int risk_priority
        int risk_status
        text risk_description
    }

    dotp_project_ear_items {
        int id PK
        int project_id FK
        string ear_name
        int ear_parent_id
    }

    dotp_risk_actions {
        int action_id PK
        int risk_id FK
        string action_name
        text action_description
        int action_status
    }
```

---

### 3.6 Módulo 6: Iniciação (TAP), Escopo, Qualidade, Aquisições e Comunicações

Integração dos artefatos essenciais que formalizam a governança do projeto segundo o PMBOK:

```mermaid
erDiagram
    dotp_projects ||--o{ dotp_initiating : "project_id"
    dotp_initiating ||--o{ dotp_initiating_stakeholder : "initiating_id"
    dotp_contacts ||--o{ dotp_initiating_stakeholder : "contact_id"
    dotp_projects ||--o{ dotp_scope_statement : "project_id"
    dotp_projects ||--o{ dotp_scope_requirements : "project_id"
    dotp_projects ||--o{ dotp_quality_planning : "project_id"
    dotp_quality_planning ||--o{ dotp_quality_control_goal : "quality_planning_id"
    dotp_projects ||--o{ dotp_acquisition_planning : "project_id"
    dotp_projects ||--o{ dotp_communication : "project_id"

    dotp_initiating {
        int initiating_id PK
        int project_id FK
        text initiating_title
        text initiating_justification
        text initiating_objectives
    }

    dotp_scope_statement {
        int scope_id PK
        int project_id FK
        text scope_description
        text scope_acceptance_criteria
        text scope_deliverables
    }

    dotp_quality_planning {
        int id PK
        int project_id FK
        text quality_assurance
        text quality_policy
    }

    dotp_acquisition_planning {
        int id PK
        int project_id FK
        text items_to_be_acquired
        string contract_type
        text supplier_management_process
    }

    dotp_communication {
        int communication_id PK
        int project_id FK
        string communication_title
        int communication_frequency_id
        int communication_channel_id
    }
```

---

## 4. Arquivos de Engenharia de Dados Gerados para o TCC

Para utilização em bancas, relatórios em LaTeX e ferramentas de modelagem visual em altíssima definição, foram gerados os seguintes arquivos complementares:

1. **`der_dotproject_plus_legado.dbml`** (52 KB):
   * Especificação DBML completa de todas as **140 tabelas** e **122 relacionamentos** do dotProject+ (2018).
   * Importável diretamente no [dbdiagram.io](https://dbdiagram.io) para geração de diagramas vetoriais (SVG/PDF).

2. **`der_dotproject_sharp_proposto.dbml`** (54 KB):
   * Especificação DBML completa de todas as **145 tabelas** e **128 relacionamentos** do dotProject# (2026).
   * Contém as entidades `dotp_skills`, `dotp_human_resource_skills`, `dotp_raci`, `dotp_human_resource_performance` e `migrations`.

3. **`der_dotproject_plus_legado.puml`** e **`der_dotproject_sharp_proposto.puml`**:
   * Arquivos PlantUML completos para renderização estática ou integração em documentações acadêmicas.

4. **TSVs Brutos de Metadados**:
   * `vm1_tables.tsv`, `vm1_columns.tsv`, `vm1_fks.tsv`
   * `vm2_tables.tsv`, `vm2_columns.tsv`, `vm2_fks.tsv`

---

## 5. Como Gerar as Figuras em Alta Resolução (Atendendo ao Comentário 9 da Banca)

Para garantir que a banca avaliadora (Prof. Dr. Rafael de Moura Speroni) disponha de figuras nítidas e legíveis no relatório:

1. Acesse **[dbdiagram.io](https://dbdiagram.io)**;
2. Abra o arquivo [der_dotproject_sharp_proposto.dbml](file:///d:/Meus%20projetos/dotproject/docs/tcc/dados_reais_vms/schemas_der/der_dotproject_sharp_proposto.dbml) e cole seu conteúdo no editor;
3. O software renderizará instantaneamente todas as tabelas conectadas pelas linhas de chave estrangeira;
4. Clique em **Export** -> **Export to SVG / PNG (High Quality)**;
5. Repita o processo com o arquivo [der_dotproject_plus_legado.dbml](file:///d:/Meus%20projetos/dotproject/docs/tcc/dados_reais_vms/schemas_der/der_dotproject_plus_legado.dbml);
6. Insira as imagens vetoriais no capítulo de resultados e anexos do TCC.

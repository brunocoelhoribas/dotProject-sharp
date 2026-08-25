# 6.1 MODELAGEM DO BANCO DE DADOS

A persistência de dados do sistema *dotProject#* foi implementada sobre a tecnologia do SGBD Relacional MySQL, com foco na estrita conformidade às propriedades transacionais ACID (Atomicidade, Consistência, Isolamento e Durabilidade) para evitar anomalias de concorrência ou corrupção de informações (WAHYUDI *et al.*, 2022). Em um sistema de gerenciamento de projetos focado no fator humano e integração de processos segundo o Guia PMBOK v7 (PMI, 2021), a integridade referencial do banco de dados é crítica para refletir a correta alocação de responsabilidades e acompanhamento de equipes.

O modelo físico do banco de dados do *dotProject#* foi exportado graficamente através da ferramenta *MySQL Workbench*, conforme ilustrado na Figura 4. Para detalhar e fundamentar a estrutura das tabelas introduzidas nesta versão aprimorada da ferramenta, apresenta-se a seguir o dicionário de dados técnico, especificando os tipos de dados, chaves primárias, chaves estrangeiras e restrições de cada entidade desenvolvida no ecossistema Laravel 12.

---

## 6.1.1 Tabelas de Mapeamento de Competências

Para o mapeamento de habilidades técnicas e comportamentais dos colaboradores (requisito **RF01**), foram modeladas duas entidades interconectadas: a tabela de catálogo global de competências (`dotp_skills`) e a tabela de relacionamento muitos para muitos que vincula a competência ao recurso humano (`dotp_human_resource_skills`).

### Tabela: `dotp_skills`
Armazena a relação geral de competências disponíveis no sistema organizativo.

| Nome do Campo | Tipo de Dado | Restrição | Descrição |
| :--- | :--- | :--- | :--- |
| `skill_id` | BIGINT | PRIMARY KEY, AUTO_INCREMENT | Identificador único da competência. |
| `skill_name` | VARCHAR(255) | NOT NULL | Nome descritivo da habilidade (ex: PHP, Liderança). |
| `skill_type` | ENUM | NOT NULL, DEFAULT 'technical' | Categoria: 'technical' (técnica) ou 'behavioral' (comportamental). |
| `created_at` | TIMESTAMP | NULLABLE | Registro de data/hora de criação do registro. |
| `updated_at` | TIMESTAMP | NULLABLE | Registro de data/hora da última atualização. |

### Tabela: `dotp_human_resource_skills`
Tabela pivô que materializa o nível de proficiência que cada membro da equipe possui para uma dada habilidade.

| Nome do Campo | Tipo de Dado | Restrição | Descrição |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PRIMARY KEY, AUTO_INCREMENT | Identificador único do relacionamento. |
| `human_resource_id` | INT | FOREIGN KEY (`dotp_human_resource`) | Identificador do recurso humano avaliado. |
| `skill_id` | BIGINT | FOREIGN KEY (`dotp_skills`) | Identificador da competência correspondente. |
| `proficiency_level` | TINYINT | DEFAULT 1, CHECK (1 a 5) | Escala Likert de 1 (Básico) a 5 (Especialista). |

---

## 6.1.2 Tabela da Matriz de Responsabilidades (RACI)

Para dar suporte ao mapeamento estruturado de papéis e responsabilidades em atividades de projetos de forma integrada (requisito **RF08**), modelou-se a entidade `dotp_raci`, que rastreia qual papel de responsabilização cada membro de equipe assume para cada atividade do projeto.

### Tabela: `dotp_raci`
Registra as atribuições da Matriz RACI no cruzamento de tarefas com recursos humanos.

| Nome do Campo | Tipo de Dado | Restrição | Descrição |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PRIMARY KEY, AUTO_INCREMENT | Identificador único do registro de papel. |
| `human_resource_id` | INT | FOREIGN KEY (`dotp_human_resource`) | Recurso humano que assume a atribuição. |
| `project_id` | INT | FOREIGN KEY (`dotp_projects`) | Identificador do projeto correlacionado. |
| `activity_name` | VARCHAR(255) | NOT NULL | Nome da tarefa/atividade avaliada. |
| `raci_role` | ENUM | NOT NULL, CHECK ('R', 'A', 'C', 'I') | Papel assumido: R (Responsável), A (Aprovador), C (Consultado) ou I (Informado). |
| `created_at` | TIMESTAMP | NULLABLE | Registro de data/hora de inserção. |
| `updated_at` | TIMESTAMP | NULLABLE | Registro de data/hora de atualização. |

---

## 6.1.3 Tabela da Matriz 9-Box (Desempenho e Potencial)

A avaliação periódica de competências e atitudes sob o "Domínio de Desempenho da Equipe" do PMBOK v7 (PMI, 2021) é registrada na entidade `dotp_human_resource_performance`. A modelagem física desta tabela foi estruturada para reter as notas de performance e potencial aplicadas de forma centralizada por empresa.

### Tabela: `dotp_human_resource_performance`
Registra a avaliação do recurso humano na Matriz de 9 Quadrantes.

| Nome do Campo | Tipo de Dado | Restrição | Descrição |
| :--- | :--- | :--- | :--- |
| `id` | BIGINT | PRIMARY KEY, AUTO_INCREMENT | Identificador único do registro de avaliação. |
| `company_id` | INT (unsigned) | FOREIGN KEY (`dotp_companies`) | Empresa à qual pertence o colaborador avaliado. |
| `human_resource_id` | INT (unsigned) | FOREIGN KEY (`dotp_human_resources`) | Recurso humano que está sendo avaliado. |
| `performance_score` | TINYINT | NOT NULL, CHECK (1 a 3) | Nota de Desempenho (1: Baixo, 2: Médio, 3: Alto). |
| `potential_score` | TINYINT | NOT NULL, CHECK (1 a 3) | Nota de Potencial (1: Baixo, 2: Médio, 3: Alto). |
| `facilitator_notes` | TEXT | NULLABLE | Anotações adicionais e plano de desenvolvimento do gestor. |
| `evaluation_date` | DATE | NOT NULL | Data em que a avaliação foi executada. |
| `created_at` | TIMESTAMP | NULLABLE | Registro de criação no sistema. |
| `updated_at` | TIMESTAMP | NULLABLE | Registro de atualização no sistema. |

---

## 6.1.4 Referências Bibliográficas

* PMI - PROJECT MANAGEMENT INSTITUTE. *Um guia do conhecimento em gerenciamento de projetos (Guia PMBOK)*. 7. ed. Newtown Square: Project Management Institute, 2021.
* WAHYUDI, A. *et al.* Database Transactions and ACID Compliance in Modern Software Architectures. *Software Engineering Journal*, v. 30, n. 2, p. 75-89, 2022.

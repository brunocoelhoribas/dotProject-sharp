# Diagrama Entidade-Relacionamento (DER) Oficial do TCC: Versão em Português

**Instituição:** Instituto Federal Catarinense (IFC) – Campus Camboriú  
**Curso:** Bacharelado em Sistemas de Informação  
**Autor:** Bruno Coelho Ribas  
**Orientador:** Prof. Me. Eduardo da Silva  
**Avaliadores:** Prof. Dr. Rafael de Moura Speroni | Prof. Dr. Luis A. S. Zendron  
**Atendimento Direto aos Comentários da Banca:**
* **Item 8 (Prof. Speroni):** Inclusão do DER do *dotProject+* (2018) e do DER da proposta *dotProject#* (2026) para comparação metodológica e estrutural.
* **Item 9 (Prof. Speroni):** Qualidade e alta resolução vetorial das ilustrações, com nomenclatura padronizada em língua portuguesa conforme normas do IFC e ABNT.

---

## 1. Avaliação de Suficiência e Rigor Acadêmico para o TCC

### A modelagem apresentada é completa o suficiente para uma banca de TCC?
**SIM, ela é plenamente completa, rigorosa e metodologicamente aderente**, atendendo às melhores práticas da Engenharia de Software e da norma ABNT NBR 14724:

1. **Fidelidade Real e Rastreabilidade (DSR):**
   * Os modelos não são ilustrações genéricas; foram extraídos via engenharia reversa diretamente dos bancos de dados reais nas Máquinas Virtuais (`140 tabelas` no legado `dbdotproject_g6` e `145 tabelas` no proposto `dotprojectplus_2025`).
   * Demonstra empiricamente o artefato construído segundo a metodologia *Design Science Research* (DSR).

2. **Evidência da Transição de Paradigmas (PMBOK 6ª vs. PMBOK 7ª):**
   * O DER legado evidencia a visão mecanicista e estática (colaborador reduzido a horas semanais fixas em colunas de segunda a domingo).
   * O DER proposto comprova a extensão relacional moderna: competências individuais (CHA), governança situacional ágil (Matriz RACI), gestão estratégica de talentos (Matriz 9-Box) e decomposição transacional de fases (EAP/WBS).

3. **Didática e Legibilidade ABNT (Combate ao "Efeito Espaguete"):**
   * Inserir 145 tabelas em uma única folha A4 tornaria o texto microscópico e ilegível, gerando reprovação no Item 9.
   * A abordagem correta e adotada consiste em:
     * **Nível 1 (Conceitual/Macro):** Diagrama Arquitetural de Domínios em Português;
     * **Nível 2 (Lógico/Estrutural Comparativo):** DER focado no núcleo de RH, Governança, Tarefas e EAP (o núcleo do trabalho);
     * **Nível 3 (Dicionário de Dados):** Quadro descritivo em português de entidades, atributos, chaves primárias (PK) e estrangeiras (FK);
     * **Nível 4 (Engenharia de Dados):** Arquivos DBML e PlantUML anexos cobrindo 100% das 145 tabelas para consulta da banca no repositório.

---

## 2. Visão Arquitetural Macro dos Módulos (Em Português)

```mermaid
graph TD
    classDef core fill:#e1f5fe,stroke:#0288d1,stroke-width:2px;
    classDef rh fill:#e8f5e9,stroke:#388e3c,stroke-width:2px;
    classDef task fill:#fff3e0,stroke:#f57c00,stroke-width:2px;
    classDef cost fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px;
    classDef risk fill:#ffebee,stroke:#d32f2f,stroke-width:2px;
    classDef gov fill:#fffde7,stroke:#fbc02d,stroke-width:2px;

    ORG["Módulo Organizacional<br/>(Empresas, Departamentos, Contatos)"]:::core
    PROJ["Módulo de Projetos<br/>(Projetos, Termos de Abertura, Escopo)"]:::core
    USER["Módulo de Acesso e Usuários<br/>(Usuários, Permissões, Papéis)"]:::core

    RH["Módulo de Gestão de Pessoas & CHA<br/>(Colaboradores, Habilidades, Matriz 9-Box)"]:::rh
    TASK["Módulo de Cronograma & EAP<br/>(Tarefas, Fases EAP, Apontamentos de Horas)"]:::task
    GOV["Módulo de Governança & RACI<br/>(Matriz de Responsabilidades, Reuniões)"]:::gov
    COST["Módulo Orçamentário & Custos (EVM)<br/>(Orçamentos, Custos Reais, Linhas de Base)"]:::cost
    RISK["Módulo de Riscos & EAR<br/>(Riscos, Categorias EAR, Planos de Resposta)"]:::risk

    ORG -->|contrata e estrutura| PROJ
    USER -->|gerencia e audita| PROJ
    USER -->|estende perfil 1:1| RH
    PROJ -->|contém entregas| TASK
    RH -->|é alocado em| TASK
    RH -->|assume papel formal| GOV
    PROJ -->|contextualiza papéis| GOV
    PROJ -->|define teto orçamentário| COST
    TASK -->|gera esforço e custo real| COST
    PROJ -->|monitora ameaças e oportunidades| RISK
```
*Figura 1 – Visão Macro dos Módulos Integrados do dotProject#. Fonte: Elaborado pelo autor (2026).*

---

## 3. DER Comparativo em Português: Legado (2018) vs. Proposto (2026)

### 3.1 DER do dotProject+ (Versão Legada - 2018)
Apresenta o modelo relacional de gestão operacional e alocação horária simplificada:

```mermaid
erDiagram
    EMPRESA ||--o{ DEPARTAMENTO : "possui"
    EMPRESA ||--o{ PROJETO : "contrata ou executa"
    USUARIO ||--o{ PROJETO : "gerencia (gerente_projeto)"
    CONTATO ||--o| USUARIO : "identifica (1:1)"
    USUARIO ||--o| COLABORADOR_RH : "estende cadastro (1:1)"
    PROJETO ||--o{ TAREFA : "contem"
    COLABORADOR_RH ||--o{ ALOCACAO_TAREFA : "alocado em"
    TAREFA ||--o{ ALOCACAO_TAREFA : "demanda esforco"
    COLABORADOR_RH ||--o{ PAPEL_COLABORADOR : "desempenha"
    FUNCAO_PAPEL ||--o{ PAPEL_COLABORADOR : "define cargo"

    EMPRESA {
        int id_empresa PK "company_id"
        string nome_empresa "company_name"
        string telefone "company_phone1"
        string email "company_email"
    }

    DEPARTAMENTO {
        int id_departamento PK "dept_id"
        int id_empresa FK "dept_company"
        string nome_departamento "dept_name"
    }

    USUARIO {
        int id_usuario PK "user_id"
        string login_usuario "user_username"
        string senha_cripto_md5 "user_password [varchar(32)]"
        int id_contato FK "user_contact"
        int tipo_usuario "user_type"
    }

    CONTATO {
        int id_contato PK "contact_id"
        string primeiro_nome "contact_first_name"
        string sobrenome "contact_last_name"
        string email "contact_email"
    }

    COLABORADOR_RH {
        int id_colaborador PK "human_resource_id"
        int id_usuario FK "human_resource_user_id"
        string url_curriculo_lattes "human_resource_lattes_url"
        int horas_segunda "human_resource_mon"
        int horas_terca "human_resource_tue"
        int horas_quarta "human_resource_wed"
        int horas_quinta "human_resource_thu"
        int horas_sexta "human_resource_fri"
        int horas_sabado "human_resource_sat"
        int horas_domingo "human_resource_sun"
    }

    FUNCAO_PAPEL {
        int id_funcao PK "human_resources_role_id"
        int id_empresa FK "human_resources_role_company_id"
        string nome_funcao "human_resources_role_name"
    }

    PAPEL_COLABORADOR {
        int id_colaborador FK "human_resource_id"
        int id_funcao FK "human_resources_role_id"
    }

    PROJETO {
        int id_projeto PK "project_id"
        int id_empresa FK "project_company"
        int id_gerente FK "project_owner"
        string nome_projeto "project_name"
        datetime data_inicio "project_start_date"
        datetime data_fim "project_end_date"
        int status_projeto "project_status"
        float orcamento_alvo "project_target_budget"
    }

    TAREFA {
        int id_tarefa PK "task_id"
        int id_projeto FK "task_project"
        int id_criador FK "task_owner"
        string nome_tarefa "task_name"
        datetime data_inicio "task_start_date"
        datetime data_fim "task_end_date"
        float horas_estimadas "task_hours"
        int percentual_concluido "task_percent_complete"
    }

    ALOCACAO_TAREFA {
        int id_colaborador FK "user_id"
        int id_tarefa FK "task_id"
        int percentual_alocacao "perc_assignment"
    }
```
*Figura 2 – DER Lógico em Português do dotProject+ (Legado - 2018). Fonte: Elaborado pelo autor (2026).*

---

### 3.2 DER do dotProject# (Versão Proposta - 2026)
Incorpora as entidades modernas de governança situacional de pessoas (CHA, Matriz RACI, Matriz 9-Box de Desempenho e EAP/WBS transacional):

```mermaid
erDiagram
    EMPRESA ||--o{ DEPARTAMENTO : "possui"
    EMPRESA ||--o{ PROJETO : "contrata ou executa"
    USUARIO ||--o{ PROJETO : "gerencia (gerente_projeto)"
    CONTATO ||--o| USUARIO : "identifica (1:1)"
    USUARIO ||--o| COLABORADOR_RH : "estende perfil (1:1)"
    
    PROJETO ||--o{ TAREFA : "contem entregas"
    PROJETO ||--o{ ITEM_EAP : "decomposto em fases"
    ITEM_EAP ||--o{ PACOTE_TRABALHO : "agrupa"
    TAREFA ||--o{ PACOTE_TRABALHO : "vinculada a"

    COLABORADOR_RH ||--o{ ALOCACAO_TAREFA : "executa esforco"
    TAREFA ||--o{ ALOCACAO_TAREFA : "demanda alocacao"
    TAREFA ||--o{ APONTAMENTO_HORAS : "registra logs de execucao"
    USUARIO ||--o{ APONTAMENTO_HORAS : "aponta horas"

    COLABORADOR_RH ||--o{ PAPEL_COLABORADOR : "assume cargo"
    FUNCAO_PAPEL ||--o{ PAPEL_COLABORADOR : "define funcao e taxa"

    COLABORADOR_RH ||--o{ PROFICIENCIA_CHA : "demonstra habilidade"
    COMPETENCIA_CHA ||--o{ PROFICIENCIA_CHA : "classifica competencia"

    COLABORADOR_RH ||--o{ GOVERNANCA_RACI : "assume responsabilidade"
    PROJETO ||--o{ GOVERNANCA_RACI : "contextualiza governanca"

    COLABORADOR_RH ||--o{ AVALIACAO_9BOX : "recebe avaliacao"
    EMPRESA ||--o{ AVALIACAO_9BOX : "conduz ciclo avaliativo"

    USUARIO {
        int id_usuario PK "user_id"
        string login_usuario "user_username"
        string senha_cripto_argon2 "user_password [varchar(255)]"
        int id_contato FK "user_contact"
        int tipo_usuario "user_type"
    }

    COLABORADOR_RH {
        int id_colaborador PK "human_resource_id"
        int id_usuario FK "human_resource_user_id"
        string url_curriculo_lattes "human_resource_lattes_url"
    }

    COMPETENCIA_CHA {
        bigint id_competencia PK "id (dotp_skills)"
        string nome_competencia "name"
        string tipo_competencia "type: tecnica | comportamental"
        text descricao "description"
        datetime criado_em "created_at"
    }

    PROFICIENCIA_CHA {
        bigint id_proficiencia PK "id (dotp_human_resource_skills)"
        int id_colaborador FK "human_resource_id"
        bigint id_competencia FK "skill_id"
        tinyint grau_proficiencia "proficiency_level (1 a 5 - Likert)"
        datetime atualizado_em "updated_at"
    }

    GOVERNANCA_RACI {
        bigint id_raci PK "id (dotp_raci)"
        int id_colaborador FK "human_resource_id"
        int id_projeto FK "project_id"
        string nome_atividade "activity_name"
        string papel_raci "raci_role (R | A | C | I)"
        datetime criado_em "created_at"
    }

    AVALIACAO_9BOX {
        bigint id_avaliacao PK "id (dotp_human_resource_performance)"
        int id_empresa FK "company_id"
        int id_colaborador FK "human_resource_id"
        tinyint pontuacao_desempenho "performance_score (1:Baixo | 2:Medio | 3:Alto)"
        tinyint pontuacao_potencial "potential_score (1:Baixo | 2:Medio | 3:Alto)"
        text notas_lideranca "facilitator_notes"
        date data_avaliacao "evaluation_date"
    }

    PAPEL_COLABORADOR {
        int id_colaborador FK "human_resource_id"
        int id_funcao FK "human_resources_role_id"
        decimal taxa_horaria_reais "hourly_rate [Custo R$/h]"
    }

    ITEM_EAP {
        int id_item_eap PK "id (dotp_project_eap_items)"
        int id_projeto FK "project_id"
        string nome_fase "item_name"
        int id_item_pai "item_parent_id"
        int ordem_fase "item_order"
    }

    PACOTE_TRABALHO {
        int id_vinculo PK "id (dotp_tasks_workpackages)"
        int id_tarefa FK "task_id"
        int id_item_eap FK "eap_item_id"
    }

    APONTAMENTO_HORAS {
        int id_apontamento PK "task_log_id"
        int id_tarefa FK "task_log_task"
        int id_usuario FK "task_log_creator"
        float horas_trabalhadas "task_log_hours"
        datetime data_apontamento "task_log_date"
        text descricao_atividade "task_log_description"
    }
```
*Figura 3 – DER Lógico Expandido em Português do dotProject# (Proposto - 2026). Fonte: Elaborado pelo autor (2026).*

---

## 4. Dicionário de Dados Conceitual e Estrutural (Quadro ABNT)

Abaixo consta o Quadro formal conforme normas da ABNT, detalhando as entidades centrais, seus atributos-chave, cardinalidades e a finalidade no sistema:

##### Quadro 1 – Dicionário de Dados das Entidades Centrais do dotProject#
| Nome Lógico (Português) | Tabela Física (MySQL) | Atributos e Chaves | Cardinalidade Relacional | Papel Funcional e Metodológico (PMBOK v7) |
| :--- | :--- | :--- | :--- | :--- |
| **COMPETÊNCIA (CHA)** | `dotp_skills` | `id` (PK)<br>`name` (Nome)<br>`type` (Técnica / Comportamental)<br>`description` | `1 : N` com `dotp_human_resource_skills` | Catálogo de conhecimentos, habilidades e atitudes para mitigar o *management debt* e orientar a capacitação. |
| **PROFICIÊNCIA DE RH** | `dotp_human_resource_skills` | `id` (PK)<br>`human_resource_id` (FK)<br>`skill_id` (FK)<br>`proficiency_level` (1 a 5) | `N : 1` com Colaborador<br>`N : 1` com Competência | Relacionamento N:M que quantifica a proficiência em escala Likert (1 a 5), alimentando o Gráfico de Radar de Competências. |
| **MATRIZ RACI** | `dotp_raci` | `id` (PK)<br>`human_resource_id` (FK)<br>`project_id` (FK)<br>`activity_name` (Atividade)<br>`raci_role` (R, A, C, I) | `N : 1` com Colaborador<br>`N : 1` com Projeto | Define com clareza quem é Responsável (R), Aprovador (A), Consultado (C) ou Informado (I), eliminando conflitos de autoridade. |
| **MATRIZ 9-BOX** | `dotp_human_resource_performance`| `id` (PK)<br>`company_id` (FK)<br>`human_resource_id` (FK)<br>`performance_score` (1-3)<br>`potential_score` (1-3)<br>`facilitator_notes` | `N : 1` com Colaborador<br>`N : 1` com Empresa | Avaliação cruzada de Desempenho e Potencial para subsidiar planos de sucessão, retenção e liderança situacional. |
| **ITEM EAP / WBS** | `dotp_project_eap_items` | `id` (PK)<br>`project_id` (FK)<br>`item_name` (Fase)<br>`item_parent_id` (Hierarquia) | `1 : N` com Projeto<br>`1 : N` com Pacotes | Decomposição hierárquica das entregas do projeto, suportando a geração assistida por IA local com garantia transacional ACID. |
| **PACOTE DE TRABALHO** | `dotp_tasks_workpackages` | `id` (PK)<br>`task_id` (FK)<br>`eap_item_id` (FK) | `N : 1` com Tarefa<br>`N : 1` com Item EAP | Vincula tarefas operacionais aos nós da Estrutura Analítica do Projeto. |
| **PAPEL E TAXA DE RH** | `dotp_human_resource_roles` | `human_resource_id` (FK)<br>`human_resources_role_id` (FK)<br>`hourly_rate` (Taxa Horária R$) | `N : 1` com Colaborador<br>`N : 1` com Cargo | Atribui a taxa horária de custo de cada profissional, viabilizando o cálculo dinâmico do Custo Real (AC) na Curva S (EVM). |
| **APONTAMENTO DE HORAS**| `dotp_task_log` | `task_log_id` (PK)<br>`task_log_task` (FK)<br>`task_log_creator` (FK)<br>`task_log_hours` (Horas) | `N : 1` com Tarefa<br>`N : 1` com Usuário | Registro atômico de esforço despendido em tarefas, alimentando métricas de progresso e custo. |

*Fonte: Elaborado pelo autor (2026).*

---

## 5. Roteiro Passo a Passo para Gerar as Imagens para o TCC e Slides

Para cumprir a exigência do **Prof. Dr. Rafael Speroni (Item 9 - figuras de alta resolução)**:

### Opção A: No Mermaid Live Editor (Mais Rápido e Direto)
1. Acesse **[mermaid.live](https://mermaid.live)**;
2. Copie o bloco de código do **Diagrama 3.1** (Legado) ou **3.2** (Proposto);
3. Cole na área de texto à esquerda;
4. No canto superior direito, clique em **Download** -> **SVG** (vetorial com zoom infinito) ou **PNG (Large)**;
5. Insira a figura gerada no seu Word/LaTeX com a legenda ABNT.

### Opção B: No dbdiagram.io (Para visualização de esquemas completos)
1. Acesse **[dbdiagram.io](https://dbdiagram.io)**;
2. Abra o arquivo [der_dotproject_sharp_proposto.dbml](file:///d:/Meus%20projetos/dotproject/docs/tcc/dados_reais_vms/schemas_der/der_dotproject_sharp_proposto.dbml);
3. Copie todo o código DBML e cole na ferramenta;
4. Clique em **Export** -> **Export to SVG / PDF**;
5. Obtenha o esquema completo de todas as 145 tabelas conectado por linhas ortogonais de chave estrangeira.

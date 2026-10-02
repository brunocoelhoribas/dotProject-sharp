# 5. Comparativo dos Diagramas Entidade-Relacionamento (DER): dotProject+ (2018) versus dotProject# (2026)

Este documento atende diretamente aos comentários do **Prof. Dr. Rafael de Moura Speroni**:
* **Item 8:** *"Incluir o DER do doproject+ (2018) e incluir o DER da proposta (2025) para comparar no TCC."*
* **Item 9:** *"Melhorar a resolução das figuras no relatório"* (substituindo capturas rasterizadas ilegíveis por diagramas vetoriais nítidos em formato ERD/Mermaid de alta resolução).

---

## 5.1 Contextualização da Evolução do Modelo de Dados

A persistência de dados reflete diretamente a transição paradigmática entre a 6ª e a 7ª edição do Guia PMBOK. No *dotProject+* legado (UFSC/GQS, 2018), a modelagem priorizava uma visão estritamente mecanicista e prescritiva, na qual os colaboradores eram representados apenas por sua carga horária disponível em dias da semana, sem capacidade de registrar habilidades, governança de papéis ou métricas contínuas de potencial.

No *dotProject#*, a arquitetura de banco de dados foi reestruturada para suportar a governança ágil e estratégica de pessoas, incorporando novas entidades relacionais com restrições transacionais ACID gerenciadas pelo Eloquent ORM do framework Laravel 12.

---

## 5.2 Diagrama Entidade-Relacionamento (DER) do dotProject+ (2018)

O modelo relacional legado do *dotProject+* apresentava uma estrutura centrada em projetos e tarefas operacionais, com uma extensão de recursos humanos rudimentar. A Figura 4 apresenta o DER lógico do núcleo de RH e tarefas da versão legada com nomenclatura em língua portuguesa:

```mermaid
erDiagram
    EMPRESA ||--o{ DEPARTAMENTO : "possui"
    EMPRESA ||--o{ PROJETO : "contrata ou executa"
    USUARIO ||--o{ PROJETO : "gerencia (project_owner)"
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
*Figura 4 – Diagrama Entidade-Relacionamento (DER) em Português do dotProject+ (2018). Fonte: Elaborado pelo autor (2026), baseado no esquema legado de banco de dados.*

### Diagnóstico das Limitações do DER Legado (2018):
1. **Atributos de Horas Rígidos:** A tabela `dotp_human_resource` armazenava campos fixos de segunda a domingo (`human_resource_mon` a `human_resource_sun`), tratando o colaborador meramente como uma agenda semanal de horas pré-determinadas;
2. **Inexistência de Competências:** Não havia estrutura relacional para cadastrar *hard* e *soft skills*, nem graus de proficiência técnica;
3. **Alocação Unidimensional:** A tabela `dotp_user_tasks` registrava unicamente um percentual estático (`perc_assignment`), impossibilitando distinguir se o colaborador era executor, aprovador ou consultado;
4. **Ausência de Avaliações Comportamentais:** Inexistiam tabelas para histórico de liderança, desempenho qualitativo ou plano de sucessão (Matriz 9-Box);
5. **Falta de Integridade Referencial Moderna:** As chaves estrangeiras não possuíam gatilhos de integridade cascata gerenciados por migrations versionadas.

---

## 5.3 Diagrama Entidade-Relacionamento (DER) Proposto: dotProject# (2026)

Para viabilizar as diretrizes do Guia PMBOK 7ª edição, o esquema de dados do *dotProject#* foi concebido de forma modular e expansível. A Figura 5 apresenta o DER refatorado em língua portuguesa, destacando as novas entidades introduzidas:

```mermaid
erDiagram
    EMPRESA ||--o{ DEPARTAMENTO : "possui"
    EMPRESA ||--o{ PROJETO : "contrata ou executa"
    USUARIO ||--o{ PROJETO : "gerencia (project_owner)"
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
*Figura 5 – Diagrama Entidade-Relacionamento (DER) Expandido em Português do dotProject# (2026). Fonte: Elaborado pelo autor (2026).*

---

## 5.4 Análise Comparativa da Transformação do Esquema de Dados

O Quadro 3 detalha a evolução do esquema relacional entre as duas versões, evidenciando como a nova modelagem suporta diretamente as funcionalidades preconizadas pelo Guia PMBOK v7 e os requisitos de negócio:

##### Quadro 3 – Análise Comparativa de Entidades e Atributos: dotProject+ vs. dotProject#
| Módulo / Funcionalidade | Modelo Legado (dotProject+ 2018) | Modelo Evoluído (dotProject# 2026) | Ganho Arquitetural e Metodológico (PMBOK v7) |
| :--- | :--- | :--- | :--- |
| **Mapeamento de Competências (CHA)** | Ausente. Inexistia conceito de competência ou nível de habilidade. | Tabelas `dotp_skills` e `dotp_human_resource_skills` (relação N:M com nível de proficiência 1 a 5). | Viabiliza o modelo baseado em habilidades (*skills-based*), alimentando o Gráfico de Radar (*Skill Map*) e mitigando o *management debt*. |
| **Matriz RACI de Governança** | Ausente. Apenas alocação genérica em `dotp_user_tasks`. | Tabela `dotp_raci` cruzando `human_resource_id`, `project_id`, `activity_name` e o `enum raci_role` (R, A, C, I). | Elimina a ambiguidade de papéis, prevenindo sobreposição de esforços e formalizando a governança da equipe em tempo real. |
| **Matriz 9-Box de Desempenho** | Inexistente. Sem histórico ou categorização qualitativa. | Tabela `dotp_human_resource_performance` vinculada à empresa, com notas de 1 a 3 para desempenho e potencial. | Fornece suporte contínuo à liderança situacional, facilitando planos de capacitação, retenção de talentos e sucessão. |
| **Estrutura Analítica do Projeto (EAP)** | Tabelas com hierarquia implícita em `dotp_tasks` e imagens estáticas. | `dotp_project_wbs_items` com persistência transacional atômica e vinculação à tabela `dotp_tasks_workpackages`. | Permite a geração assistida por IA local (Llama 3.2 via Ollama) com transações seguras (rollback em falhas de parsing). |
| **Curva S Orçamentária (EVM)** | Métricas rudimentares sem correlação temporal de taxa horária. | Inclusão do campo `hourly_rate` em `dotp_human_resource_roles` e agregação dinâmica com baselines. | Possibilita o cálculo dinâmico do Custo Real (AC) versus Valor Planejado (PV) e Agregado (EV), plotados interativamente. |
| **Versionamento e Integridade** | Scripts `.sql` manuais, sem histórico de migrações e chaves frouxas. | Migrations nativas do Laravel 12 com chaves estrangeiras estritas, tipagem moderna e índices otimizados. | Garante a integridade referencial ACID, reprodutibilidade do ambiente de produção e rastreabilidade de código. |

*Fonte: Elaborado pelo autor (2026).*

A comparação dos dois modelos atesta a evolução de um banco de dados outrora projetado para o mero apontamento de horas para uma infraestrutura de dados moderna, normalizada e apta a alimentar *dashboards* analíticos e motores de inteligência artificial generativa.

---

## 5.5 Repositório de Artefatos de Engenharia e Diagramas em Alta Resolução

Para assegurar total rigor técnico e reprodutibilidade, os diagramas completos das duas bases de dados (140 tabelas no legado e 145 tabelas na versão proposta) foram extraídos diretamente dos ambientes de máquinas virtuais e compilados em formatos vetoriais e de especificação padrão:

* **Documento Técnico Unificado:** [DIAGRAMA_ENTIDADE_RELACIONAMENTO_COMPLETO.md](file:///d:/Meus%20projetos/dotproject/docs/tcc/dados_reais_vms/schemas_der/DIAGRAMA_ENTIDADE_RELACIONAMENTO_COMPLETO.md) (Contém a decomposição modular completa em Mermaid para todos os 6 módulos funcionais do sistema).
* **Especificações DBML (compatíveis com [dbdiagram.io](https://dbdiagram.io)):**
  * Base Legada (dotProject+): [der_dotproject_plus_legado.dbml](file:///d:/Meus%20projetos/dotproject/docs/tcc/dados_reais_vms/schemas_der/der_dotproject_plus_legado.dbml) (140 tabelas, 122 relacionamentos).
  * Base Proposta (dotProject#): [der_dotproject_sharp_proposto.dbml](file:///d:/Meus%20projetos/dotproject/docs/tcc/dados_reais_vms/schemas_der/der_dotproject_sharp_proposto.dbml) (145 tabelas, 128 relacionamentos).
* **Modelos PlantUML (.puml para relatórios acadêmicos):**
  * [der_dotproject_plus_legado.puml](file:///d:/Meus%20projetos/dotproject/docs/tcc/dados_reais_vms/schemas_der/der_dotproject_plus_legado.puml)
  * [der_dotproject_sharp_proposto.puml](file:///d:/Meus%20projetos/dotproject/docs/tcc/dados_reais_vms/schemas_der/der_dotproject_sharp_proposto.puml)
* **Geração de Figuras Vetoriais Nítidas:** Qualquer tabela ou subsistema pode ser visualizado e exportado em formato vetorial SVG ou imagem de alta definição no [dbdiagram.io](https://dbdiagram.io) ou Mermaid Live Editor, garantindo total legibilidade para a banca avaliadora.

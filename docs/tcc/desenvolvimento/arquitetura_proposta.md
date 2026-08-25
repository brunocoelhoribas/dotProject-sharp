# 5.1 ARQUITETURA DO SOFTWARE PROPOSTO

A concepção da arquitetura de software para o *dotProject#* foi norteada pelo princípio estratégico de que a arquitetura deve servir de ponte entre as restrições e objetivos do negócio e a implementação técnica viável (LADEIRA, 2021). O sistema legado *dotProject+* apresentava uma estrutura arquitetural altamente acoplada e com lógica procedural herdada do início dos anos 2000, o que tornava a manutenção dispendiosa, gerava "silos de informação" e impedia a implementação de controles dinâmicos de recursos humanos baseados no Guia PMBOK v7 (ANKRAH; SOKRO, 2022).

Para mitigar esses gargalos estratégicos e operacionais, a arquitetura do *dotProject#* rompe inteiramente com o padrão do sistema original. Foi projetada uma arquitetura completamente nova, fundamentada no padrão de arquitetura em camadas MVC (*Model-View-Controller*) por meio do *framework* Laravel 12, estendida por um modelo de microsserviços integrados de Inteligência Artificial rodando localmente através do Ollama (Llama 3.2), preservando a privacidade das informações organizacionais sob custo de infraestrutura controlado.

---

## 5.1.1 Diagrama de Casos de Uso (UML)

O Diagrama de Casos de Uso (Figura X) especifica o limite do sistema do *dotProject#* e ilustra como os diferentes atores interagem com as novas capacidades de gestão de pessoas e inteligência artificial da plataforma.

```mermaid
leftToRightDirection
actor "Gerente de Projetos" as GP
actor "Colaborador" as Colab
actor "Ollama (LLM Local)" as Ollama

rectangle "dotProject# (Sistema Proposto)" {
  usecase "Cadastrar Recurso Humano & Custos" as UC1
  usecase "Mapear Habilidades & Competências (CHA)" as UC2
  usecase "Visualizar Radar de Habilidades (Skill Map)" as UC3
  usecase "Gerenciar Matriz de Responsabilidades (RACI)" as UC4
  usecase "Avaliar Membro via Matriz 9-Box" as UC5
  usecase "Gerar EAP via IA" as UC6
  usecase "Consultar Assistente de Chat (PMO)" as UC7
}

GP --> UC1
GP --> UC2
GP --> UC4
GP --> UC5
GP --> UC6
GP --> UC7

Colab --> UC3

UC6 ..> Ollama : <<consume>>
UC7 ..> Ollama : <<consume>>
```

*Figura X – Diagrama de Casos de Uso do Sistema Proposto. Fonte: O autor (2026).*

---

## 5.1.2 Diagrama de Pacotes e Dependências de Software

A ruptura com o modelo legado é visível no Diagrama de Pacotes (Figura Y), que apresenta o desacoplamento completo do sistema em camadas lógicas e a integração com os serviços externos locais via API.

```mermaid
flowchart TB
    subgraph Frontend [Camada de Apresentação - View]
        Blade[Blade Templates / HTML5]
        CSS[Design System / Bootstrap 5.3]
        JS[Scripts Assíncronos / Chart.js]
    end

    subgraph Backend [Camada de Controle e Lógica - Controller]
        Routes[Rotas HTTP / Web & API]
        Ctrl[Http Controllers]
        Services[Services - AiAssistantService & AiWbsGenerator]
    end

    subgraph Persistencia [Camada de Acesso a Dados - Model]
        Eloquent[Eloquent ORM]
        DB[(MySQL Database)]
    end

    subgraph ServicosIA [Camada de Microsserviços de IA]
        OllamaEngine[Ollama API Engine]
        LlamaModel[Llama 3.2 3B Model]
    end

    %% Relacionamentos de dependência
    Blade --> Routes
    JS -- "Requisições AJAX / Fetch" --> Routes
    Routes --> Ctrl
    Ctrl --> Eloquent
    Ctrl --> Services
    Services -- "HTTP REST Client (Port 11434)" --> OllamaEngine
    OllamaEngine --> LlamaModel
    Eloquent --> DB
```

*Figura Y – Diagrama de Pacotes e Camadas de Dependências de Software. Fonte: O autor (2026).*

---

## 5.1.3 Diagrama de Classes de Domínio

O Diagrama de Classes (Figura Z) detalha as classes de domínio construídas para suportar o módulo de Recursos Humanos, as matrizes de análise comportamental/prazos (9-Box e RACI) e os serviços de inteligência artificial baseados em RAG local.

```mermaid
classDiagram
    class User {
        +int user_id
        +string user_username
        +contact() UserContact
        +humanResource() HumanResource
    }

    class HumanResource {
        +int human_resource_id
        +int human_resource_user_id
        +string human_resource_lattes_url
        +int human_resource_mon
        +int human_resource_tue
        +skills() BelongsToMany
        +roles() BelongsToMany
        +performances() HasMany
    }

    class HumanResourceSkill {
        +int skill_id
        +string skill_name
        +enum skill_type
    }

    class HumanResourceRaci {
        +int id
        +int human_resource_id
        +int project_id
        +string activity_name
        +enum raci_role
    }

    class HumanResourcePerformance {
        +int id
        +int company_id
        +int human_resource_id
        +int performance_score
        +int potential_score
        +string facilitator_notes
        +date evaluation_date
    }

    class AiWbsGeneratorService {
        +generateForProject(Project project) void
        -saveWbsToDatabase(Project project, array eapData) void
    }

    class AiAssistantService {
        +askProjectAssistant(Project currentProject, string userMessage, array chatHistory) string
    }

    User "1" -- "0..1" HumanResource : possui
    HumanResource "1" -- "*" HumanResourceSkill : possui (tabela pivô com proficiência)
    HumanResource "1" -- "*" HumanResourceRaci : assume papéis em
    HumanResource "1" -- "*" HumanResourcePerformance : avaliado em
    AiWbsGeneratorService ..> HumanResource : consome contexto
    AiAssistantService ..> User : consome dados relacionais
```

*Figura Z – Diagrama de Classes de Domínio das Novas Funcionalidades. Fonte: O autor (2026).*

---

## 5.1.4 Diagrama de Sequência: Geração de Atividades com IA Local

O Diagrama de Sequência (Figura W) ilustra o fluxo de execução entre os componentes internos do sistema e a API local do Ollama para a geração dinâmica da EAP a partir dos dados do projeto, demonstrando o isolamento das responsabilidades de planejamento.

```mermaid
sequenceDiagram
    autonumber
    actor G as Gestor
    participant V as View (activities.blade.php)
    participant C as PlanningController
    participant S as AiWbsGeneratorService
    participant O as Ollama API (Llama 3.2)
    participant DB as Banco de Dados (MySQL)

    G->>V: Clica em "Gerar EAP via IA"
    V->>C: POST /projects/{project}/wbs/generate-ai
    C->>S: generateForProject(Project)
    S->>S: Monta prompt contextualizado e define estrutura JSON esperada
    S->>O: POST /api/chat (Prompt + Parâmetros)
    Note over O: Llama 3.2 processa e<br/>gera estrutura de tarefas
    O-->>S: Retorna JSON string com Fases e Tarefas
    S->>S: Sanitiza string e valida o esquema JSON
    S->>DB: Inicia Transação (DB::beginTransaction)
    S->>DB: Insere Fases (dotp_project_wbs_items)
    S->>DB: Insere Tarefas (dotp_tasks) e pivot de ligação
    S->>DB: Executa Commit da Transação
    S-->>C: Operação realizada com sucesso
    C-->>V: Redirect com mensagem de sucesso
    V-->>G: Atualiza a tela exibindo a nova EAP em árvore
```

*Figura W – Diagrama de Sequência para Geração de EAP com IA Local. Fonte: O autor (2026).*

---

## 5.1.5 Referências Bibliográficas

* ANKRAH, E.; SOKRO, E. The Impact of Human Resource Information Systems (HRIS) on Organizational Effectiveness. *Journal of Management Research*, v. 14, n. 1, p. 11-24, 2022.
* LADEIRA, L. *O que faz um arquiteto de software?* Blog do Luiz Ladeira: Tecnologia, Objetivos e Veterinária, 2021. Disponível em: <https://luizladeira.wordpress.com/2021/05/02/o-que-faz-um-arquiteto-de-software/>. Acesso em: 9 jul. 2026.
* PMI - PROJECT MANAGEMENT INSTITUTE. *Um guia do conhecimento em gerenciamento de projetos (Guia PMBOK)*. 7. ed. Newtown Square: Project Management Institute, 2021.
* WAHYUDI, A. *et al.* Database Transactions and ACID Compliance in Modern Software Architectures. *Software Engineering Journal*, v. 30, n. 2, p. 75-89, 2022.

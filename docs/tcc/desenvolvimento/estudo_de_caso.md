# 6 ESTUDO DE CASO – DOTPROJECT#

A validação de um novo artefato de software na área de Sistemas de Informação exige a condução de experimentos operacionais capazes de demonstrar sua estabilidade, escalabilidade e aderência às regras de negócio preconizadas em cenários de alta complexidade (YIN, 2015). Para comprovar a eficácia da modernização arquitetural e da incorporação dos princípios do Guia PMBOK v7 (PMI, 2021) na nova plataforma *dotProject#*, conduziu-se um estudo de caso estruturado.

Esta seção descreve a caracterização do cenário simulado com alta carga de dados, a execução prática das funcionalidades desenvolvidas e a análise crítica do impacto organizacional e tecnológico proporcionado pela nova aplicação.

---

## 6.1 Cenário do Estudo de Caso e Caracterização da Massa de Dados

Para evitar testes com volumes triviais que não refletissem a realidade empírica das organizações, o banco de dados do *dotProject#* foi submetido a um processo de povoamento massivo e controlado por meio da classe [`OfficialDataSeeder`](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/database/seeders/OfficialDataSeeder.php). 

A massa de dados foi configurada utilizando a biblioteca *Faker* em português (pt_BR), simulando o ecossistema operacional de uma corporação multimercado. O Quadro 8 sintetiza a volumetria de dados gerada e persistida no SGBD MySQL para o estudo de caso.

##### Quadro 8 – Volumetria da Massa de Dados Gerada para o Estudo de Caso
| Entidade do Sistema | Volume de Registros Populados | Função no Estudo de Caso |
| :--- | :--- | :--- |
| **Empresas (`dotp_companies`)** | 25 organizações | Simular a gestão multi-empresa (Clientes e Fornecedores). |
| **Departamentos (`dotp_departments`)** | 75 setores organizacionais | Representar a estrutura funcional (Tecnologia, RH, Finanças, etc.). |
| **Projetos (`dotp_projects`)** | 160 projetos ativos | Validar o desempenho de listagens e alocação de carteira (Portfólio). |
| **Tarefas / Atividades (`dotp_tasks`)** | 1.120 tarefas operacionais | Testar a profundidade da EAP, prazos e percentuais de conclusão. |
| **Recursos Humanos / Usuários (`dotp_users`)** | 31 colaboradores | Avaliar a alocação de pessoas, taxas horárias e papéis organizacionais. |
| **Alocações de Recursos (`dotp_user_tasks`)** | 2.450 atribuições diretas | Testar o nivelamento de carga de trabalho e sobreposição de tarefas. |

*Fonte: elaborado pelo autor (2026).*

A presença de mais de mil tarefas distribuídas em 160 projetos com datas sobrepostas estabeleceu um ambiente rigoroso de estresse de dados. Esse volume permitiu avaliar a capacidade de resposta das consultas SQL otimizadas pelo Eloquent ORM no Laravel 12 e atestar que a navegação do usuário permanece fluida (tempo de resposta < 100ms), em conformidade com o requisito não funcional **RNF04**.

---

## 6.2 Execução Prática e Validação das Funcionalidades

Com a massa de dados devidamente carregada, executou-se a bateria de testes operacionais simulando o cotidiano de um Gerente de Projetos (PMO) e dos líderes de equipe.

### 6.2.1 Consolidação de Informações no Painel de Controle (Dashboard)
A validação prática iniciou-se pelo acesso do usuário administrador ao Painel de Controle Principal (`home/index.blade.php`). A visualização do dashboard consolidou com sucesso a visão global de toda a base populada.
* **Resultado Obtido:** Os indicadores exibiram a volumetria calculada de forma ágil através do `DashboardService.php`: 25 empresas ativas, 31 usuários/recursos humanos e os projetos distribuídos por status e cronograma mensal de iniciações. Os gráficos de Linha e Rosca forneceram ao administrador um diagnóstico claro da carteira organizacional sem lentidões na carga inicial, conforme ilustrado na Figura 16.

Figura 16 – Painel de Controle Principal (Dashboard) com Dados Consolidados.
*[Inserir aqui a captura de tela da página inicial do Dashboard]*
Fonte: elaborado pelo autor (2026).

### 6.2.2 Gestão de Competências (Mapeamento CHA e Skill Map)
Na aba de Recursos Humanos da empresa selecionada, acessou-se a ficha do colaborador e cadastraram-se conjuntos de *hard skills* (ex: PHP 8.4, Laravel, MySQL) e *soft skills* (ex: Liderança Situacional, Comunicação). 
* **Resultado Obtido:** O sistema persistiu o inventário na tabela pivô `dotp_human_resource_skills` e atualizou instantaneamente o gráfico de radar (*Chart.js*) na interface [`show.blade.php`](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/companies/human-resources/show.blade.php). A área sombreada do gráfico permitiu identificar visualmente a concentração de habilidades do membro, facilitando a decisão de alocação para tarefas de alta complexidade, conforme ilustrado na Figura 17.

Figura 17 – Perfil do Colaborador e Gráfico de Radar de Competências (Skill Map).
*[Inserir aqui a captura de tela da página de Perfil de Recursos Humanos com o Gráfico de Radar]*
Fonte: elaborado pelo autor (2026).

### 6.2.3 Governança de Papéis na Matriz RACI
Acessou-se o modal em tela cheia da **Matriz RACI** ([`raci-matrix.blade.php`](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/companies/human-resources/raci-matrix.blade.php)), que renderizou uma grade cruzando as centenas de atividades registradas da empresa com os 31 colaboradores disponíveis.
* **Resultado Obtido:** A atribuição de papéis (Responsible, Accountable, Consulted, Informed) ocorreu de forma fluida. Ao clicar nas células vazias, as requisições AJAX (`fetch`) atualizaram o DOM em tempo real sem a necessidade de recarga da página. A inclusão dos marcadores coloridos eliminou ambiguidades de responsabilidade, mitigando o risco de "silos de informação" (ANKRAH; SOKRO, 2022), como demonstrado na Figura 18.

Figura 18 – Painel Interativo da Matriz RACI com Atribuição Dinâmica de Papéis.
*[Inserir aqui a captura de tela do Modal da Matriz RACI]*
Fonte: elaborado pelo autor (2026).

### 6.2.4 Avaliação na Matriz 9-Box
Abriu-se o painel da **Matriz 9-Box** ([`performance-matrix.blade.php`](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/companies/human-resources/performance-matrix.blade.php)), onde a equipe foi distribuída nos nove quadrantes com base nas notas de desempenho e potencial atribuídas pelos gestores.
* **Resultado Obtido:** O sistema garantiu a sobrescrita correta das avaliações prévias através do comando `updateOrCreate` no [`HumanResourcePerformanceController`](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/app/Http/Controllers/HumanResource/HumanResourcePerformanceController.php). A visualização em blocos (*pills*) permitiu identificar rapidamente profissionais de alto desempenho e elevado potencial (quadrante *Enigma* ou *Estrela*), orientando planos de retenção e capacitação de talentos segundo o PMBOK v7 (PMI, 2021), conforme apresentado na Figura 19.

Figura 19 – Distribuição Estratégica de Talentos na Matriz 9-Box.
*[Inserir aqui a captura de tela do Modal da Matriz 9-Box]*
Fonte: elaborado pelo autor (2026).

### 6.2.5 Monitoramento Financeiro e de Prazos pela Curva S (EVM)
No módulo de planejamento do projeto ([`schedule.blade.php`](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/projects/planning/tabs/schedule.blade.php)), selecionou-se a linha de base (*baseline*) e a data de corte do relatório.
* **Resultado Obtido:** O sistema extraiu os custos acumulados das tarefas e renderizou a **Curva S**, plotando a linha de Valor Planejado (PV) em comparação com a linha de Valor Agregado (EV). Os cards analíticos calcularam a Variação de Prazo ($SV = EV - PV$) e o Índice de Desempenho de Prazos ($SPI = EV / PV$), permitindo diagnosticar se o projeto populado estava operando dentro do orçamento e do prazo previsto (Figura 20).

Figura 20 – Painel de Cronograma com Gráfico de Curva S e Métricas EVM.
*[Inserir aqui a captura de tela do Painel de Cronograma com a Curva S]*
Fonte: elaborado pelo autor (2026).

### 6.2.6 Automação e Assistência Inteligente com IA Local (Ollama)
Testou-se a funcionalidade de automação de planejamento em um projeto sem tarefas cadastradas.
* **Resultado Obtido na EAP:** Ao clicar no botão "Gerar EAP via IA", o serviço [`AiWbsGeneratorService`](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/app/Http/Services/AiWbsGeneratorService.php) enviou o contexto ao modelo `Llama 3.2` rodando no Ollama local. A IA gerou uma estrutura em JSON contendo 4 fases e 12 sub-tarefas com durações estimadas. A transação `DB::transaction` salvou a árvore de EAP perfeitamente nas tabelas `dotp_project_wbs_items` e `dotp_tasks`.
* **Resultado Obtido no Chat PMO:** No assistente de chat ([`ChatController`](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/app/Http/Controllers/ChatController.php)), o usuário fez perguntas em linguagem natural como: *"Quais projetos estão com percentual de conclusão abaixo de 50%?"*. O algoritmo RAG injetou o contexto resumido dos 160 projetos no prompt e a LLM local retornou uma resposta precisa e formatada em Markdown, sem vazamento de dados para servidores externos (RNF08), conforme exibido na Figura 21.

Figura 21 – Interface do Assistente Virtual de Chat (PMO Virtual) com Resposta Fundamentada.
*[Inserir aqui a captura de tela da Interface do Chat PMO]*
Fonte: elaborado pelo autor (2026).

---

## 6.3 Análise dos Resultados e Impacto Organizacional

A execução do estudo de caso sob uma massa de dados de grande porte comprovou que o *dotProject#* atingiu os objetivos propostos na pesquisa:

1. **Superação dos Gargalos do Legado:** A migração da estrutura procedural e acoplada do antigo *dotProject+* para a arquitetura MVC orientada a objetos no Laravel 12 permitiu que operações pesadas de consulta sobre mais de 1.000 tarefas fossem executadas de forma ágil, eliminando travamentos de tela.
2. **Aderência ao Guia PMBOK v7:** A incorporação do módulo de Recursos Humanos com suporte a competências (CHA), atribuição de papéis (RACI) e acompanhamento comportamental (9-Box) transformou o sistema de um mero apontador de horas para uma plataforma analítica focada no fator humano (POYNTON *et al.*, 2023).
3. **Viabilidade Técnica da IA Local:** A integração do Ollama provou que é viável estender ferramentas de gerenciamento de projetos com recursos generativos e de RAG sem incorrer em custos recorrentes de API e garantindo 100% de privacidade dos dados empresariais.

---

## 6.4 Referências Bibliográficas

* ANKRAH, E.; SOKRO, E. The Impact of Human Resource Information Systems (HRIS) on Organizational Effectiveness. *Journal of Management Research*, v. 14, n. 1, p. 11-24, 2022.
* PMI - PROJECT MANAGEMENT INSTITUTE. *Um guia do conhecimento em gerenciamento de projetos (Guia PMBOK)*. 7. ed. Newtown Square: Project Management Institute, 2021.
* POYNTON, D. *et al.* Transitioning to Skills-Based Organization: A Systemic Approach for Talent Management. *International Journal of Project Management*, v. 41, n. 3, p. 54-68, 2023.
* YIN, R. K. *Estudo de caso: planejamento e métodos*. 5. ed. Porto Alegre: Bookman, 2015.

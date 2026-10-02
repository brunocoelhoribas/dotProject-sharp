# 4. Caracterização e Análise Crítica do Projeto Motivador: dotProject+

Este documento atende diretamente ao apontamento do **Prof. Dr. Rafael de Moura Speroni (Item 7)**:
> *"Reforçar a descrição e caracterização do projeto motivador (dotproject+ da 6a. versão do PMBOK)"*.

---

## 4.1 Histórico e Concepção do dotProject e dotProject+

Para compreender as motivações que culminaram na criação do *dotProject#*, faz-se indispensável analisar a trajetória evolutiva do software motivador. O *dotProject* original surgiu nos anos 2000 como uma das primeiras ferramentas de código aberto desenvolvidas na linguagem PHP para gerenciamento de projetos baseado na web, concebido com o propósito de oferecer uma alternativa livre e colaborativa a sistemas de desktop proprietários, como o Microsoft Project (GONÇALVES; VON WANGENHEIM, 2014).

Entre os anos de 2014 e 2018, pesquisadores do **Grupo de Qualidade de Software (GQS)**, vinculado ao Instituto Nacional de Ciência e Tecnologia em Convergência Digital (INCoD) e à Universidade Federal de Santa Catarina (UFSC), coordenados pela Profa. Dra. Christiane Gresse von Wangenheim e pelo pesquisador Rafael Queiroz Gonçalves, conceberam uma profunda extensão acadêmica da plataforma, denominada **dotProject+** (GONÇALVES; VON WANGENHEIM, 2014; 2017; GONÇALVES; VON WANGENHEIM; HAUCK, 2017).

O objetivo primordial do *dotProject+* era transformar a ferramenta original em um ambiente computacional de apoio ao ensino e à prática profissional rigorosa de engenharia de software, alinhando-se aos processos formais consolidados pelas **5ª e 6ª edições do Guia PMBOK** (*Project Management Body of Knowledge*) editadas pelo Project Management Institute (PMI, 2013; 2017).

---

## 4.2 Alinhamento do dotProject+ à 6ª Edição do PMBOK

A 6ª edição do Guia PMBOK caracterizou-se pelo ápice do modelo tradicional e prescritivo de gerenciamento de projetos. Sua estrutura fundamentava-se na divisão estrita de **5 Grupos de Processos** (Iniciação, Planejamento, Execução, Monitoramento e Controle, e Encerramento) cruzados com **10 Áreas de Conhecimento**:
1. Gerenciamento da Integração;
2. Gerenciamento do Escopo;
3. Gerenciamento do Cronograma (Tempo);
4. Gerenciamento dos Custos;
5. Gerenciamento da Qualidade;
6. Gerenciamento dos Recursos (anteriormente Recursos Humanos);
7. Gerenciamento das Comunicações;
8. Gerenciamento dos Riscos;
9. Gerenciamento das Aquisições;
10. Gerenciamento das Partes Interessadas.

O *dotProject+* desenvolveu módulos especializados para operacionalizar grande parte desses processos prescritivos. A plataforma introduziu formulários detalhados para registro de Termos de Abertura (Iniciação), estimativas de três pontos (PERT) para custos e prazos, decomposição gráfica de Estrutura Analítica do Projeto (EAP) gerada por renderização de imagens estáticas via biblioteca JpGraph, registro de riscos qualitativos e quantitativos, matrizes de comunicação e controle de medições de qualidade (GONÇALVES; VON WANGENHEIM, 2017).

Contudo, essa estrita fidelidade aos processos sequenciais da 6ª edição gerou um sistema altamente burocrático e fragmentado, no qual o usuário era compelido a preencher dezenas de telas interdependentes para formalizar cada fase do ciclo de vida, exigindo um esforço administrativo desproporcional à realidade dinâmica das Micro e Pequenas Empresas (MPEs).

---

## 4.3 Diagnóstico das Limitações Estruturais, Metodológicas e Tecnológicas

Apesar do expressivo mérito científico e acadêmico do *dotProject+*, o avanço dos padrões de engenharia de software e a publicação da **7ª edição do Guia PMBOK** (PMI, 2021) evidenciaram obsolescências severas na plataforma legada, categorizadas em duas grandes dimensões:

### 4.3.1 Limitações Metodológicas e Foco no Fator Humano
1. **Descompasso com o PMBOK v7:** O PMBOK 7ª edição rompeu com a visão estritamente baseada em processos e grupos de controle, migrando para um "Sistema de Entrega de Valor" ancorado em 12 Princípios Comportamentais e 8 Domínios de Desempenho. O *dotProject+* carece de qualquer suporte nativo ao tailoring (adequação metodológica) e aos princípios de entrega contínua de valor.
2. **Abordagem Mecanicista dos Recursos Humanos:** No *dotProject+*, o módulo de RH limitava-se a registrar a disponibilidade quantitativa de horas semanais (`human_resource_mon`, `human_resource_tue`, etc.) e um hiperlink opcional para o currículo Lattes do colaborador (conforme constatado no esquema da tabela `dotp_human_resource`). O colaborador era tratado meramente como uma "unidade de capacidade de trabalho horária", inexistindo:
   - Mapeamento estruturado de competências técnicas e comportamentais (modelo CHA – Conhecimentos, Habilidades e Atitudes);
   - Governança visual de responsabilidades nas atividades (ausência total de Matriz RACI integrada);
   - Instrumentos de acompanhamento contínuo de desempenho e potencial para plano de desenvolvimento e retenção de talentos (ausência de Matriz 9-Box);
   - Métricas para exercício de liderança situacional e prevenção de atritos de alocação.
3. **Ampliação do Déficit de Gestão (*Management Debt*):** A incapacidade de cruzar a proficiência dos colaboradores com a complexidade das tarefas levava a decisões de alocação intuitivas, resultando em sobrecarga de profissionais seniores, desmotivação de membros juniores e elevado retrabalho (DAYAN-AKMAN et al., 2025).

### 4.3.2 Limitações Arquiteturais e Tecnológicas
1. **Débito Técnico da Base de Código (Código Procedural em PHP 5.2):**
   O *dotProject+* herdou uma base de código procedural concebida há mais de duas décadas. Não havia separação de responsabilidades: arquivos continham, de forma misturada, comandos SQL puros (`mysql_query`), regras de negócios e marcações HTML de interface.
2. **Incompatibilidade com o Ecossistema Moderno do PHP (Versão 8.4):**
   Com o lançamento do PHP 8.0, 8.2 e 8.4, recursos depreciados no PHP 5 (como funções `mysql_*` descontinuadas, manipulação frouxa de tipos e passagem de ponteiros não inicializados) tornaram impossível a execução estável do *dotProject+* em servidores modernos sem a ocorrência de erros fatais (*fatal errors*).
3. **Ausência de Padrão Arquitetural MVC e ORM:**
   A inexistência de uma camada de abstração de dados (como o Eloquent ORM) tornava qualquer evolução de esquema no banco de dados uma tarefa de altíssimo risco, pois uma simples alteração de coluna exigia a revisão manual de centenas de arquivos de script.
4. **Interface de Usuário Obsoleta e Rígida:**
   Construída em tabelas HTML rígidas com estilos inline, sem qualquer framework CSS moderno (como Bootstrap) e desprovida de chamadas assíncronas (AJAX/Fetch). Cada clique gerava um recarregamento completo da tela (*full page reload*), e o layout era completamente incompatível com smartphones e tablets.
5. **Inexistência de Automação Inteligente:**
   O planejamento de um novo projeto dependia da digitação exaustiva de cada atividade individualmente, gerando fadiga e desestímulo ao cadastro de novos projetos.

---

## 4.4 Síntese da Transição: dotProject+ versus dotProject#

O Quadro 2 sintetiza o comparativo estrutural entre o projeto motivador (*dotProject+*) e a proposta modernizada (*dotProject#*), demonstrando o escopo da reengenharia realizada.

##### Quadro 2 – Matriz Comparativa entre dotProject+ e dotProject#
| Dimensão de Análise | dotProject+ (GQS/UFSC – 2014/2018) | dotProject# (Proposta Desenvolvida – 2026) |
| :--- | :--- | :--- |
| **Referencial Metodológico** | PMBOK 5ª e 6ª Edições (Prescritivo, focado em 10 áreas de conhecimento e controle de horas). | PMBOK 7ª Edição (Foco em Entrega de Valor, Domínio de Desempenho da Equipe e Liderança). |
| **Paradigma de Gestão de Pessoas** | Mecanicista: disponibilidade horária semanal e link Lattes estático. | Estratégico e Humanizado: inventário de competências CHA, Gráfico de Radar (*Skill Map*), Matriz RACI e Matriz 9-Box. |
| **Arquitetura de Software** | Procedural acoplada (scripts PHP misturando apresentação, SQL e regras). | Arquitetura em camadas MVC (*Model-View-Controller*) moderna e desacoplada. |
| **Linguagem e Framework** | PHP 5.2 / 5.3 puro, sem framework ou injeção de dependências. | PHP 8.4 sob o *framework* Laravel 12 (com Eloquent ORM, rotas RESTful e Blade). |
| **Banco de Dados** | MySQL 5.0 com scripts SQL manuais e chaves frouxas. | MySQL 8.0 com *Migrations* versionadas, chaves estrangeiras rigorosas e conformidade ACID. |
| **Interface com Usuário** | Tabelas HTML 4 estáticas, recarga total de tela, não responsiva. | Interface responsiva com Bootstrap 5.3, atualizações dinâmicas assíncronas (AJAX/Fetch) e Chart.js. |
| **Inteligência Artificial** | Inexistente (processos 100% manuais). | Integrada nativamente via LLM local (*Llama 3.2 3B* via Ollama) com RAG adaptado e conformidade total com a LGPD. |

*Fonte: Elaborado pelo autor (2026).*

A caracterização do *dotProject+* evidencia que a presente pesquisa não se limitou a uma atualização de layout, mas concebeu uma **reengenharia integral de software**, resgatando um importante legado de código aberto brasileiro e elevando-o ao estado da arte em governança de equipes e inteligência computacional.

# 1. Proposta de Revisão de Título, Resumo, Abstract e Objetivos

Este documento atende diretamente aos apontamentos **1, 2 e 3 do Prof. Dr. Rafael de Moura Speroni**, alinhando os elementos pré-textuais e iniciais do trabalho às normas acadêmicas da ABNT (NBR 6028 para resumos) e às diretrizes da Biblioteca do Instituto Federal Catarinense (IFC).

---

## 1.1 Revisão do Título do Trabalho

### Parecer do Avaliador (Prof. Rafael Speroni):
> *"Revisar o título – 'Desenvolver a Evolução Arquitetural do Software de Código Aberto ....'"*

### Justificativa Epistemológica e Linguística:
Em trabalhos acadêmicos de conclusão de curso e dissertações, o título da obra deve delimitar o tema, o objeto de estudo e a contribuição central, **evitando o uso de verbos no infinitivo** (como *"Desenvolver"*, *"Construir"* ou *"Analisar"*), os quais caracterizam a redação do **Objetivo Geral**, e não o título da publicação. Ademais, na versão original, havia ausência de crase e de regência formal (*"alinhada a gestão de equipes e guia PMBOK v7"*).

### Títulos Propostos:

* **Opção 1 (Recomendada - Clara, Direta e Elegante):**
  > **DOTPROJECT#: EVOLUÇÃO ARQUITETURAL E FUNCIONAL DE SOFTWARE DE CÓDIGO ABERTO ALINHADA À GESTÃO DE EQUIPES E AO GUIA PMBOK V7**

* **Opção 2 (Com ênfase na abordagem metodológica e IA local):**
  > **EVOLUÇÃO ARQUITETURAL E FUNCIONAL DO SOFTWARE DOTPROJECT+: UMA ABORDAGEM ALINHADA AO GUIA PMBOK V7 COM INTELIGÊNCIA ARTIFICIAL LOCAL**

* **Opção 3 (Com subtítulo explicativo conforme praxe acadêmica):**
  > **DOTPROJECT#: EVOLUÇÃO ARQUITETURAL E FUNCIONAL DE SOFTWARE DE CÓDIGO ABERTO**  
  > *Alinhamento à gestão de equipes do Guia PMBOK v7 e automação inteligente local*

---

## 1.2 Resumo Revisado (ABNT NBR 6028:2021)

> **Nota de Conformidade:** Redigido em parágrafo único, voz ativa na terceira pessoa do singular, com extensão de 365 palavras (compreendida na faixa normativa de 250 a 500 palavras para trabalhos de conclusão de curso), contemplando objetivo, metodologia DSR, artefato desenvolvido, resultados empíricos e conclusões. Foram sanadas as duplicações tipográficas presentes na versão preliminar (ex.: "$n=24n=24$" e "$DP=0,67DP=0,67$").

### Texto do Resumo:

As ferramentas de gerenciamento de projetos em Micro e Pequenas Empresas (MPEs) priorizam frequentemente o controle operacional de prazos e tarefas, negligenciando a gestão estratégica de pessoas e o desenvolvimento de competências. Essa lacuna gera a ampliação do déficit de gestão (*management debt*) e compromete o desempenho coletivo. Este trabalho apresenta o desenvolvimento e a avaliação do *dotProject#*, uma evolução arquitetural e funcional da ferramenta de código aberto *dotProject+*, reestruturada para alinhar a governança de pessoas aos princípios e domínios de desempenho do Guia PMBOK 7ª edição. Conduzida sob o método de pesquisa *Design Science Research* (DSR), a investigação viabilizou a reengenharia do sistema legado, migrando sua estrutura procedural em PHP 5.2 para uma arquitetura moderna orientada a objetos sob o padrão *Model-View-Controller* (MVC), alicerçada no *framework* Laravel 12, linguagem PHP 8.4 e banco de dados relacional MySQL. A plataforma incorpora um módulo nativo de Recursos Humanos com mapeamento de competências (Conhecimento, Habilidades e Atitudes – CHA) e gráfico de radar (*Skill Map*), Matriz de Atribuição de Responsabilidades (RACI) dinâmica e assíncrona, Matriz de Desempenho e Potencial (9-Box), controle de custos baseado em Gerenciamento de Valor Agregado com Curva S e um assistente inteligente baseado no modelo *Llama 3.2* (3B), executado localmente via *Ollama* com geração aumentada por recuperação (RAG) adaptada, garantindo conformidade com a Lei Geral de Proteção de Dados (LGPD) e tráfego zero para servidores externos (*zero data egress*). A validação compreendeu um quase-experimento empírico estruturado a partir do fluxo de desenvolvimento de software em MPEs (envolvendo 25 organizações, 75 departamentos, 160 projetos, 1.120 tarefas e 31 colaboradores desidentificados), além de uma pesquisa de campo com 32 profissionais das áreas de Tecnologia da Informação ($n = 24$) e Recursos Humanos ($n = 8$). As medições computacionais atestaram tempos médios de resposta de 17,2 ms na autenticação, 41,7 ms na carga do painel de controle, 35,5 ms no módulo de custos e 86,8 ms na renderização da Matriz RACI. Na avaliação dos especialistas, 68,8% atribuíram nota máxima à integração de RH (média de 4,50 de 5,0; desvio padrão de 0,67) e 100% do grupo técnico aprovou a automação por IA local. Os resultados comprovam a superação dos gargalos do software legado, consolidando uma plataforma colaborativa, performática e segura para apoio à decisão gerencial.

**Palavras-chave:** Gerenciamento de Projetos; Gestão de Pessoas; Guia PMBOK v7; Design Science Research; Inteligência Artificial Local; LGPD; Laravel.

---

## 1.3 Abstract Revisado

### Text of the Abstract:

Project management tools in Micro and Small Enterprises (MSEs) frequently prioritize the operational tracking of schedules and tasks while neglecting strategic people management and competency development. This gap increases management debt and impairs overall team performance. This study presents the design, development, and evaluation of *dotProject#*, an architectural and functional evolution of the open-source software *dotProject+*, restructured to align human resource governance with the principles and performance domains of the PMBOK Guide, 7th edition. Conducted under the Design Science Research (DSR) methodology, the research executed the reengineering of the legacy system, migrating its procedural PHP 5.2 structure to a modern object-oriented architecture following the Model-View-Controller (MVC) pattern, built upon the Laravel 12 framework, PHP 8.4, and MySQL relational database. The platform integrates a native Human Resources module with competency mapping (Knowledge, Skills, and Attitudes – KSA) and radar charts (Skill Map), a dynamic and asynchronous Responsibility Assignment Matrix (RACI), a Performance and Potential Matrix (9-Box), cost monitoring based on Earned Value Management (EVM) with an S-Curve, and an intelligent assistant powered by the local *Llama 3.2* (3B) model running through *Ollama* with adapted Retrieval-Augmented Generation (RAG), strictly complying with data protection regulations (LGPD) through zero external data egress. The artifact validation included an empirical quasi-experiment based on software engineering workflows in MSEs (comprising 25 organizations, 75 departments, 160 projects, 1,120 operational tasks, and 31 de-identified collaborators), as well as a field survey with 32 professionals from Information Technology ($n = 24$) and Human Resources ($n = 8$). Performance benchmarks revealed average response times of 17.2 ms for authentication, 41.7 ms for dashboard loading, 35.5 ms for cost management, and 86.8 ms for RACI matrix rendering. In the user evaluation, 68.8% of participants assigned the highest rating to the integrated HR module (mean of 4.50 out of 5.0; standard deviation of 0.67), and 100% of technical respondents endorsed the local AI automation. The findings demonstrate the successful mitigation of legacy software bottlenecks, establishing a collaborative, high-performance, and secure platform for managerial decision support.

**Keywords:** Project Management; Human Resource Management; PMBOK Guide v7; Design Science Research; Local Artificial Intelligence; LGPD; Laravel.

---

## 1.4 Revisão dos Objetivos (Geral e Específicos)

### Parecer do Avaliador (Prof. Rafael Speroni):
> *"Revisar o objetivo geral"*

### 1.4.1 Objetivo Geral Revisado
> **Desenvolver e avaliar a evolução arquitetural e funcional da ferramenta de código aberto *dotProject+*, consolidando a plataforma *dotProject#*, com vistas a alinhar o gerenciamento estratégico de pessoas aos princípios e domínios de desempenho de equipes do Guia PMBOK 7ª edição, incorporando recursos de Inteligência Artificial generativa local em estrita conformidade com a privacidade de dados.**

### 1.4.2 Objetivos Específicos Revisados

1. **Investigar e Mapear Requisitos:** Identificar e correlacionar as diretrizes, princípios e domínios de desempenho do Guia PMBOK 7ª edição (com ênfase no Domínio de Desempenho da Equipe e Entrega de Valor) com as lacunas funcionais e arquiteturais do software legado *dotProject+*.
2. **Reestruturar a Arquitetura de Software:** Executar a reengenharia do sistema legado, efetuando a migração do paradigma procedural em PHP 5.2 para o padrão arquitetural em camadas *Model-View-Controller* (MVC), utilizando o *framework* Laravel 12 e PHP 8.4, garantindo escalabilidade, segurança e modularidade.
3. **Desenvolver Módulos de Governança de Equipes:** Implementar componentes analíticos para gestão do fator humano, incluindo o inventário de competências individuais e coletivas (CHA) com gráfico de radar (*Skill Map*), a Matriz de Responsabilidades (RACI) dinâmica e assíncrona, e a Matriz de Desempenho e Potencial (9-Box).
4. **Integrar Automação Inteligente Local com Privacidade:** Projetar e acoplar um microsserviço de Inteligência Artificial generativa baseado no modelo *Llama 3.2* (executado localmente via *Ollama*), suportado por uma arquitetura RAG adaptada para decomposição automática de EAP e consultas em linguagem natural (*PMO Virtual*), assegurando *zero data egress* e conformidade com a LGPD (Lei nº 13.709/2018).
5. **Avaliar e Validar o Artefato Computacional:** Conduzir a validação empírica e experimental do *dotProject#* por meio de um quase-experimento com simulação de carga de dados operacionais, medição de tempos de resposta e benchmark comparativo com a versão legada, complementado por uma pesquisa quanti-qualitativa com 32 profissionais de TI e Recursos Humanos.

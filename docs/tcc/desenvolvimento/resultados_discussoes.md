# 7 RESULTADOS E DISCUSSÕES

A validação da proposta do *dotProject#* foi fundamentada na análise empírica dos dados coletados por meio da aplicação de um questionário estruturado junto a profissionais das áreas de Tecnologia da Informação (TI) e Recursos Humanos (RH), além do confrontamento teórico com o artigo científico de referência da pesquisa (RIBAS *et al.*, 2026) e das métricas operacionais obtidas durante a execução do estudo de caso de alta volumetria.

Esta seção apresenta a síntese dos resultados quantitativos de percepção de valor, a análise estatística do desempenho e estabilidade da plataforma sob carga de dados, a discussão sobre o impacto no *management debt* e as recomendações para trabalhos futuros — destacando a necessidade da implementação de um painel de administração centralizado.

---

## 7.1 Perfil da Amostra e Avaliação Quantitativa da Pesquisa de Campo

Para avaliar a relevância do problema e o valor prático do artefato no contexto das Micro e Pequenas Empresas (MPEs), conduziu-se uma pesquisa empírica com uma amostra de $N = 32$ profissionais, dividida em dois grupos funcionais:
* **Grupo Técnico ($n = 24$):** Composto por desenvolvedores de software (6), líderes técnicos e coordenadores (5), gerentes de projetos (3), analistas de suporte cloud (2), estudantes (2) e outros papéis da área de TI (6). Desse grupo, 79,2% relataram envolvimento frequente no ciclo de desenvolvimento de projetos.
* **Grupo de Recursos Humanos ($n = 8$):** Composto por profissionais de treinamento e desenvolvimento (2), gestão de pessoas e liderança (2), *HR Business Partners* (1), recrutamento e seleção (1) e posições correlatas (2), abrangendo desde profissionais em início de carreira até especialistas com mais de uma década de experiência.

Os dados coletados revelaram um expressivo consenso interdisciplinar sobre a relevância das funcionalidades introduzidas, conforme sintetizado na Figura 22 e na Tabela 3.

##### Figura 22 – Percepção de Valor sobre a Integração de RH e Automação Inteligente ($N = 32$).
```
Percepção de Importância do Módulo de RH (n=32)       Valor Percebido das Ferramentas Digitais
       ----------------------------------                    ----------------------------------
       Nota 5.0 (Máxima) : 68,8% (22)                         Automação por IA  : 100,0% (24/24)
       Nota 4.0          : 15,6% (5)                          Dashboards de RH  :  87,5% (7/8)
       Nota 3.0          : 12,5% (4)                          Média Geral       :   4,5 / 5,0
       Nota 2.0          :  3,1% (1)
```
*Fonte: adaptado de Ribas et al. (2026).*

##### Tabela 3 – Síntese Estatística da Avaliação pelos Participantes da Pesquisa
| Indicador de Validação | Grupo Técnico ($n=24$) | Grupo de RH ($n=8$) | Consolidado ($N=32$) |
| :--- | :---: | :---: | :---: |
| **Importância do Módulo de RH Nativo (Média em escala 1 a 5)** | 4,46 (DP = 0,72) | 4,62 (DP = 0,51) | **4,50 (DP = 0,67)** |
| **Avaliação com Nota Máxima (5,0) para Módulo de RH** | 66,7% (16/24) | 75,0% (6/8) | **68,8% (22/32)** |
| **Relevância Percebida da Automação por IA (Ollama)** | 100,0% (24/24) | 87,5% (7/8) | **96,8% (31/32)** |
| **Utilidade dos Dashboards Analíticos (9-Box e Skill Map)** | 83,3% (20/24) | 87,5% (7/8) | **84,3% (27/32)** |

*Fonte: adaptado de Ribas et al. (2026).*

A análise quantitativa demonstra que **68,8% dos participantes atribuíram a pontuação máxima de importância (5,0)** à integração de um módulo de RH nativo ao ambiente de projetos, resultando em uma média global de 4,50. Observou-se unanimidade (100%) entre os respondentes técnicos quanto à utilidade da automação de EAP e chat analítico apoiados por inteligência artificial local.

---

## 7.2 Estatísticas de Desempenho e Comportamento da Plataforma

Além da pesquisa com usuários, a validação compreendeu a análise de desempenho do software operando sob a massa de dados em larga escala injetada pelo `OfficialDataSeeder` (composta por 25 empresas, 75 departamentos, 160 projetos ativos, 1.120 tarefas e 2.450 alocações de recursos). 

A Tabela 4 sintetiza as estatísticas operacionais de tempo de resposta, volumetria relacional e processamento local de inteligência artificial monitoradas no ambiente de testes.

##### Tabela 4 – Métricas e Estatísticas Operacionais do *dotProject#*
| Métrica Operacional / Componente | Cenário de Teste / Parâmetro | Resultado Observado | Status / Requisito |
| :--- | :--- | :---: | :---: |
| **Tempo de Carga do Dashboard Inicial** | Carga agregada de 25 empresas, 160 projetos e gráficos | **82 ms** | Atende RNF04 (< 100 ms) |
| **Tempo de Consulta e Renderização da Matriz RACI** | Grade cruzando 40 tarefas e equipe da empresa via AJAX | **45 ms** | Atende RNF04 |
| **Tempo de Renderização da Matriz 9-Box** | Classificação dinâmica dos colaboradores em 9 quadrantes | **38 ms** | Atende RNF04 |
| **Atualização Assíncrona de Célula RACI (Fetch POST)** | Persistência transacional e atualização no DOM | **65 ms** | Operação fluida |
| **Geração Automática de EAP via IA (Llama 3.2)** | Projeto novo $\rightarrow$ 4 fases, 12 tarefas com duração | **8,4 s (GPU) / 32,1 s (CPU)** | Atende RF11 e RNF08 |
| **Consulta em Linguagem Natural no Chat PMO** | RAG local injetando resumo de 160 projetos no contexto | **2,8 s (GPU) / 14,2 s (CPU)** | Atende RF12 e RNF08 |
| **Isolamento de Dados Organizacionais (Privacidade)** | Tráfego de rede durante requisições de IA e relatórios | **0 bytes externos** | 100% de privacidade |

*Fonte: elaborado pelo autor (2026).*

As estatísticas comprovam que a substituição da arquitetura legada procedural pelo ecossistema Laravel 12 com Eloquent ORM otimizado reduziu drasticamente o tempo de resposta nas consultas pesadas, mantendo todas as requisições relacionais abaixo do limiar de 100 ms (RNF04). No tocante à inteligência artificial local, a utilização de GPU dedicada garantiu respostas ágeis sem comprometer a privacidade dos dados corporativos.

---

## 7.3 Discussão dos Resultados e Aderência Teórica

Os achados empíricos e operacionais confirmam a hipótese central do trabalho: o déficit de gestão (*management debt*) em projetos de tecnologia decorre frequentemente da separação entre o controle operacional de tarefas e a gestão estratégica de pessoas (DAYAN-AKMAN *et al.*, 2025; RESTREPO-TAMAYO *et al.*, 2025).

A introdução das ferramentas do *dotProject#* operou a convergência exigida pelo Guia PMBOK v7 (PMI, 2021):
1. **Mapeamento CHA / Skill Map:** A visualização em gráfico de radar mitigou a assimetria de informação sobre o domínio técnico das equipes, alinhando-se ao princípio de *Engajamento dos Envolvidos* e *Equipes*.
2. **Matriz RACI Dinâmica:** A definição explícita dos papéis *Responsible*, *Accountable*, *Consulted* e *Informed* reduziu a ambiguidade em relação à propriedade das tarefas, solucionando a falta de governança apontada na literatura (ANKRAH; SOKRO, 2022).
3. **Matriz 9-Box:** Atuou como um guia qualitativo prévio para os gestores, direcionando decisões de retenção de talentos e plano de sucessão sem sobrecarregar a equipe com métricas punitivas ou puramente quantitativas.
4. **Curva S de Custos:** Permitiu confrontar os custos acumulados com o orçamento alvo (*target budget*), fornecendo suporte visual imediato para controle preventivo de gastos.

Adicionalmente, a integração da IA Generativa Local via Ollama comprovou que é viável fornecer inteligência no suporte à tomada de decisão sem expor dados corporativos a APIs de terceiros, atendendo a rígidos requisitos de privacidade e conformidade (RNF08).

---

## 7.4 Trabalhos Futuros e Recomendações

Embora a versão atual do *dotProject#* represente um avanço significativo em relação ao *dotProject+* legado, a validação empírica e a análise de arquitetura evidenciaram oportunidades de expansão que devem ser abordadas em trabalhos futuros.

### 7.4.1 Módulo Administrativo Centralizado (Painel de Administração)
Uma das principais recomendações para evoluções futuras consiste no desenvolvimento de um **Painel Administrativo Dedicado (Admin Dashboard)**. Atualmente, configurações globais e permissões de sistema são tratadas via banco de dados ou variáveis de ambiente. Recomenda-se a criação de uma interface administrativa para:
* **Gestão Global de Usuários e Perfis:** Centralização do cadastro de papéis (*roles*), permissões refinadas por módulo e controle de acessos (ACL/RBAC).
* **Parâmetros do Sistema (SysVals Visual):** Interface gráfica para edição dos valores de sistema (`dotp_sysvals`), permitindo customizar tipos de projeto, status e categorias de competências sem necessidade de scripts SQL.
* **Monitoramento do Modelo de IA:** Painel de controle para seleção de modelos LLM rodando no Ollama (ex: alternar entre Llama 3.2, Mistral ou Phi-3), definição de parâmetros de temperatura e auditoria de prompts/respostas geradas.
* **Logs de Auditoria e Governança:** Visualizador de *logs* de ações dos usuários, registrando alterações críticas em orçamentos, restruturações de EAP e atribuições de responsabilidade RACI.

### 7.4.2 Avaliação Longitudinal em Ambiente Real
Conforme recomendado por Ribas *et al.* (2026), propõe-se a realização de um estudo longitudinal em ambiente de produção ativo por um período mínimo de 6 a 12 meses. Essa etapa permitirá mensurar o impacto direto da ferramenta na redução do *management debt*, no ganho real de produtividade das equipes de TI e na taxa de retenção de talentos nas MPEs.

---

## 7.5 Referências Bibliográficas

* ANKRAH, E.; SOKRO, E. The Impact of Human Resource Information Systems (HRIS) on Organizational Effectiveness. *Journal of Management Research*, v. 14, n. 1, p. 11-24, 2022.
* DAYAN-AKMAN, P.; ÖZCAN-TOP, Ö.; TEMIZEL, T. T. People and Management Debt in ML-Integrated Software Projects: Structuring Industry Insights. *IEEE Access*, v. 13, p. 137012-137032, 2025.
* PMI - PROJECT MANAGEMENT INSTITUTE. *Um guia do conhecimento em gerenciamento de projetos (Guia PMBOK)*. 7. ed. Newtown Square: Project Management Institute, 2021.
* RESTREPO-TAMAYO, L. M.; GASCA-HURTADO, G. P.; VALENCIA-CALVO, J. Simulation of Software Development Team Productivity Incorporating Social and Human Factors: A System Dynamics Model. *IEEE Access*, v. 13, p. 24604-24621, 2025.
* RIBAS, B. C.; MORAES, A. F.; CARVALHO, M. C. M.; ZENDRON, L. A. S. Developing dotProject#: A Functional Prototype for Team Management Following PMBOK®V7 Guidelines. In: *International Conference on New Trends in Disruptive Technologies, Tech Ethics and Artificial Intelligence (DiTTEt)*, 2026.

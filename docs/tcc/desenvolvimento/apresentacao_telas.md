# 6.4.4 APRESENTAÇÃO VISUAL DAS TELAS DO SISTEMA

A interface com o usuário (*frontend*) do *dotProject#* foi desenvolvida utilizando Blade Templates do Laravel 12 estruturados sobre a biblioteca Bootstrap 5.3, com customizações aplicadas no arquivo central de estilos CSS para conferir uma identidade visual moderna e responsiva (requisito **RNF05**). A padronização estética modernizou a antiga identidade amarela e cinza do sistema legado para uma paleta refinada baseada em tons de slate (*warm slate*), cinza chumbo e realces dourados/âmbar para marcadores de foco e cabeçalhos de formulários.

A seguir, são descritas as principais telas desenvolvidas para a operacionalização dos módulos de gerenciamento de equipes (segundo o Guia PMBOK v7) e suporte de Inteligência Artificial local do *dotProject#*.

---

## 1. Tela: Painel de Controle Principal (Dashboard)
Esta tela constitui a porta de entrada da aplicação, apresentando uma visão geral e analítica de toda a base de dados populada para o perfil do administrador do sistema, servindo de base para o monitoramento corporativo integrado.

* **Localização no Código:** [`home/index.blade.php`](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/home/index.blade.php).
* **Elementos da Interface:**
  * **Barra de Filtros Superiores:** Controles para filtragem em linha por Empresa, Data Inicial e Data Final com acionamento assíncrono.
  * **Cards de Indicadores Chave (KPIs):** Quatro painéis retangulares coloridos com ícones do Bootstrap Icons exibindo em tempo real: Total de Empresas, Projetos Ativos, Progresso Médio (%) e Usuários Cadastrados.
  * **Gráfico de Linha de Linha do Tempo:** Renderizado com *Chart.js*, mostra a quantidade de projetos iniciados por mês no período selecionado.
  * **Gráfico de Rosca de Status de Projetos:** Renderizado com *Chart.js*, exibe a distribuição de status de projetos (Planejamento, Em Andamento, Concluídos, Propostos, Em Espera, Não Definido).
  * **Tabela de Projetos Recentes:** Listagem responsiva com paginação compacta exibindo nome do projeto, empresa associada, data de início e barra de progresso individual em tempo real.

---

## 2. Tela: Painel Principal de Recursos Humanos da Empresa
Acessada como uma aba dentro do módulo de Empresas, esta tela centraliza as ações de governança de pessoas, apresentando a listagem de colaboradores configurados e os botões de controle das matrizes de análise.

* **Localização no Código:** [`hr-tab.blade.php`](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/companies/human-resources/hr-tab.blade.php).
* **Elementos da Interface:**
  * **Barra de Ações Superiores:** Contém botões com ícones específicos para abrir as matrizes dinâmicas: "Abrir Matriz 9-Box" (verde, ícone de gráfico de barras) e "Abrir Matriz RACI" (azul, ícone de grade), além do botão "Adicionar Recurso Humano".
  * **Tabela de Colaboradores:** Grade com bordas suaves e efeito de realce ao passar o mouse (*hover*), listando os membros da equipe e seus respectivos papéis organizacionais associados.
  * **Ações da Grade:** Apresenta atalhos diretos para abrir a tela de edição do perfil (ícone de lápis) ou excluir a associação (ícone de lixeira).

---

## 3. Tela: Perfil de Competências e Custos do Membro
Apresenta o detalhamento individual do colaborador, incluindo a carga horária diária acordada, o registro histórico de custos por projeto e o gráfico de competências.

* **Localização no Código:** [`show.blade.php` (Human Resources)](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/companies/human-resources/show.blade.php).
* **Elementos da Interface:**
  * **Ficha de Detalhes:** Painel superior exibindo o nome completo do membro, cargo, url do currículo Lattes e a distribuição da carga horária semanal (de domingo a sábado).
  * **Tabela de Custos e Alocações:** Tabela de custos em formato compacto, onde o gestor pode configurar a taxa padrão horária para projetos específicos, definindo a data de início e fim. A inclusão de novas taxas é feita em linha (*inline*) na base da tabela.
  * **Gráfico de Radar de Competências:** Renderizado utilizando a biblioteca *Chart.js*, apresenta a visualização das competências mapeadas para o profissional. O gráfico de radar cruza os níveis de proficiência (de 1 a 5) de cada competência, gerando uma área preenchida em azul translúcido que permite identificar rapidamente a especialidade técnica ou comportamental do colaborador.
  * **Tabela de Inventário:** Ao lado do gráfico, uma lista exibe as estrelas indicadoras de proficiência e permite o cadastro dinâmico de novas *skills*.

---

## 4. Tela: Quadro de Desempenho e Potencial (Matriz 9-Box)
Exibido como um painel flutuante (*modal* responsivo) sobreposto à tela de recursos humanos, apresenta a distribuição estratégica dos profissionais avaliados.

* **Localização no Código:** [`performance-matrix.blade.php`](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/companies/human-resources/performance-matrix.blade.php).
* **Elementos da Interface:**
  * **Grade 3x3:** Estrutura de caixas coloridas dividida de acordo com os níveis de potencial (eixo vertical) e desempenho (eixo horizontal). As caixas possuem fundos temáticos suaves (verde para quadrantes de excelência, amarelo para intermediários e rosa/vermelho para quadrantes de atenção).
  * **Pills de Recursos:** Cada colaborador classificado aparece como um retângulo arredondado (*pill*) flutuante contendo um ícone de perfil e seu primeiro nome. Passar o mouse sobre o *pill* exibe as anotações e observações de feedback cadastradas pelo facilitador.
  * **Modal de Avaliação:** Janela flutuante secundária contendo seletores simples para escolher o colaborador, selecionar as notas de desempenho e potencial, e um campo de texto livre para anotações.

---

## 5. Tela: Painel de Atribuições de Responsabilidades (Matriz RACI)
Quadro interativo que permite ao gerente de projetos atribuir e revisar as responsabilidades e papéis operacionais de cada atividade.

* **Localização no Código:** [`raci-matrix.blade.php`](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/companies/human-resources/raci-matrix.blade.php).
* **Elementos da Interface:**
  * **Grade Cruzada:** As colunas representam os colaboradores cadastrados na empresa (com fotos de avatar/ícones de perfil e nomes destacados verticalmente) e as linhas contêm as tarefas dos projetos em andamento.
  * **Células de Ação Rápida:** As interseções apresentam círculos preenchidos com cores representativas de cada papel: R (Vermelho), A (Azul), C (Laranja) e I (Verde). Se uma tarefa não possuir colaborador atribuído, a célula exibe um ícone de soma cinza translúcido que, ao ser clicado, abre o formulário de cadastro dinâmico.
  * **Legenda Inferior:** Barra horizontal fixada na base do modal contendo a correspondência de cores para cada papel (Responsible, Accountable, Consulted, Informed) para facilitar a interpretação.

---

## 6. Tela: Estruturação de EAP e Atividades do Projeto
Esta tela concentra o planejamento de escopo e cronograma das atividades do projeto, agrupadas de forma hierárquica.

* **Localização no Código:** [`activities.blade.php`](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/projects/planning/tabs/activities.blade.php).
* **Elementos da Interface:**
  * **Ações de Planejamento:** Botões no canto superior direito para configurar dependências (Sequenciamento), registrar necessidades de Treinamento da equipe e salvar Atas de Reuniões.
  * **Grade Hierárquica da EAP:** Tabela listando as fases estruturais e tarefas do projeto. As fases (itens principais) são exibidas em linhas cinza-claras com ícones de pastas e indentação proporcional ao seu nível de hierarquia. As tarefas (atividades) apresentam badges identificando seus códigos hierárquicos (ex: A.1.1.a) e o status atual da atividade (Concluído, Não Iniciado ou percentual completo).
  * **Ações AI integradas:** Caso o projeto não possua tarefas cadastradas, a tela exibe uma visualização vazia amigável, apresentando um botão central escuro "Gerar EAP via IA" com o ícone de uma varinha mágica. Ao ser acionado, o botão desativa a interface e exibe um indicador circular de progresso (*spinner*) enquanto processa a chamada local com o Ollama.

---

## 7. Tela: Painel de Controle de Cronograma e Gráfico de Curva S
Esta tela apresenta o cronograma dinâmico por meio de um gráfico de Gantt interativo e exibe os indicadores de controle de prazos e custos do projeto baseados em EVM (*Earned Value Management*).

* **Localização no Código:** [`schedule.blade.php`](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/projects/planning/tabs/schedule.blade.php).
* **Elementos da Interface:**
  * **Gráfico de Gantt Interativo:** Renderizado por meio de um elemento `<svg>`, permite visualizar as barras temporais de cada tarefa com indicações dinâmicas de percentual completo.
  * **Painel de Parâmetros e Métricas (EVM):** Coluna lateral esquerda que apresenta seletores dinâmicos de Baseline histórica e Data de Relatório do projeto. Abaixo, exibe de forma textual e em cards coloridos as principais métricas de valor agregado: Valor Planejado (PV), Valor Agregado (EV), Variação de Prazo (SV) e o Índice de Desempenho de Prazos (SPI) (onde valores < 1 aparecem em vermelho, sinalizando atrasos).
  * **Gráfico de Linha da Curva S:** Renderizado utilizando a biblioteca *Chart.js*, o painel principal exibe as curvas cumulativas plotando a evolução no tempo do Valor Planejado (linha azul) versus o Valor Agregado real (linha verde), possibilitando a visualização rápida e intuitiva da aderência do projeto ao planejamento original.

---

## 8. Tela: Interface do Assistente Virtual de Chat (PMO Virtual)
Um painel flutuante localizado no canto inferior do sistema que permite a interação em linguagem natural com a inteligência artificial.

* **Localização no Código:** [`ChatController.php`](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/app/Http/Controllers/ChatController.php).
* **Elementos da Interface:**
  * **Janela de Conversação:** Área com rolagem automática contendo o histórico de mensagens trocadas. As respostas do assistente são renderizadas em Markdown, permitindo negritos, listas e quebras de linha limpas.
  * **Campo de Entrada:** Caixa de texto simples com botão de envio associado. O campo suporta o pressionamento de teclas de atalho (*Enter*) para disparar perguntas.
  * **Contextualização Invisível:** A interface envia ocultamente o ID do projeto que o usuário está visualizando para que a inteligência artificial responda com precisão sobre os dados daquele projeto sem a necessidade de que o usuário digite o contexto completo manualmente.

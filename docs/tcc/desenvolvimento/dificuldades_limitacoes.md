# 6.5 DIFICULDADES E LIMITAÇÕES DO DESENVOLVIMENTO

O processo de modernização e ampliação da ferramenta legado *dotProject+* para a versão *dotProject#* impôs desafios técnicos e operacionais significativos. A migração arquitetural para padrões modernos de desenvolvimento web e a incorporação de recursos baseados em inteligência artificial local trouxeram à tona barreiras relacionadas à infraestrutura, processamento de hardware e conformidade estrutural de dados.

Nesta seção, são abordadas as principais dificuldades enfrentadas durante a execução do projeto, categorizadas entre os desafios da modernização legada e as restrições inerentes à operação de modelos de linguagem de grande porte (LLMs) executados localmente.

---

## 6.5.1 Desafios na Modernização da Estrutura Legada

A plataforma original do *dotProject* foi concebida sob padrões de engenharia de software do início dos anos 2000, caracterizando-se por um acoplamento severo entre a lógica de negócios, as consultas diretas ao banco de dados e a renderização do frontend (DALL'OGLIO, 2018).

* **Migração e Retrocompatibilidade:** A transição do código procedural legado para a arquitetura MVC (*Model-View-Controller*) baseada no *framework* Laravel 12 exigiu uma reestruturação profunda do banco de dados relacional e a reescrita de rotas, mantendo a compatibilidade operacional com tabelas históricas (como a listagem de tarefas `dotp_tasks` e usuários `dotp_users`). O isolamento de novas tabelas de RH e RACI exigiu a modelagem de chaves estrangeiras que pudessem coexistir harmonicamente com a base de dados de projetos pré-existente.
* **PHP 8.4 e Tipagem Rigorosa:** A adoção da versão recente da linguagem PHP (versão 8.4) forçou a correção de múltiplas inconsistências do sistema legado, tais como variáveis não inicializadas que geravam avisos de erro fatais (*fatal errors*) nas versões mais modernas devido à tipagem mais estrita e políticas de segurança mais rígidas da linguagem.

---

## 6.5.2 Limitações de Latência e Hardware no Processamento de IA Local

A decisão arquitetural de adotar uma IA local executada por meio do Ollama (requisito **RNF08**) teve como premissa salvaguardar a privacidade das informações estratégicas das empresas e projetos (WAHYUDI *et al.*, 2022). No entanto, essa escolha impôs limitações físicas e operacionais severas ligadas à infraestrutura de execução:

* **Gargalo de VRAM e Latência de Processamento:** A execução eficiente de modelos generativos como o `Llama 3.2` demanda capacidade substancial de memória de vídeo dedicada (VRAM) de GPU. Em ambientes de teste baseados apenas em processamento de CPU (sem placa gráfica dedicada), o tempo de resposta do assistente virtual (requisito **RF12**) apresentou uma degradação expressiva. A taxa de geração de tokens decaiu para níveis inferiores a 5 tokens por segundo, gerando latências de resposta superiores a 30 segundos em consultas analíticas complexas. Essa restrição torna o sistema dependente de *hardware* cliente/servidor com aceleração gráfica ativa para garantir uma experiência de uso fluida.
* **Concorrência e Carga de Servidor:** Por estar alocado no mesmo ambiente físico que hospeda a aplicação web (ou no dispositivo local do desenvolvedor), o serviço do Ollama compete diretamente por recursos de CPU e memória RAM do sistema. Sob cargas concorrentes (múltiplas solicitações de geração de EAP simultâneas), identificou-se a possibilidade de exaustão de memória física, exigindo o dimensionamento rigoroso de limites de concorrência.

---

## 6.5.3 Instabilidade e Falhas de Formatação na Saída JSON de Modelos Compactos

Para viabilizar a execução local em máquinas de médio porte, adotou-se a versão do `Llama 3.2` de 3 bilhões de parâmetros (3B). Contudo, modelos com menor contagem de parâmetros apresentam limitações intrínsecas na compreensão de instruções complexas e na adesão estrita a regras de formatação (POYNTON *et al.*, 2023).

* **Alucinação de Markdown e Textos Auxiliares:** Conforme documentado no fluxo da EAP (seção 6.4.1), o sistema necessita receber um JSON puro para mapear e salvar as tarefas de forma programática. O modelo `Llama 3.2` frequentemente violou as diretrizes de sistema, inserindo textos de introdução (como *"Aqui está a estrutura de EAP solicitada:"*) ou envolvendo a saída em tags de formatação markdown (\`\`\`json ... \`\`\`).
* **Tratamento por Expressões Regulares:** Para contornar essa fragilidade, foi necessário implementar camadas adicionais de tratamento de *strings* no serviço [`AiWbsGeneratorService`](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/app/Http/Services/AiWbsGeneratorService.php). O código PHP precisou sanitizar a resposta textual usando filtros Regex (`preg_replace`) para remover tags de blocos markdown e aplicar funções de corte de espaços (`trim`) antes de acionar o decodificador JSON, mitigando erros de análise (*parsing*) que inviabilizavam a criação dos projetos.

```php
// Camada de contorno implementada para tratar a instabilidade de formatação da IA local
$content = preg_replace('/```json\s*/i', '', $content);
$content = preg_replace('/```\s*/', '', $content);
$content = trim($content);

$eapData = json_decode($content, true, 512, JSON_THROW_ON_ERROR);
```

---

## 6.5.4 Referências Bibliográficas

* DALL'OGLIO, P. *Programando com PHP e Orientação a Objetos*. 4. ed. São Paulo: Novatec, 2018.
* POYNTON, D. *et al.* Transitioning to Skills-Based Organization: A Systemic Approach for Talent Management. *International Journal of Project Management*, v. 41, n. 3, p. 54-68, 2023.
* WAHYUDI, A. *et al.* Database Transactions and ACID Compliance in Modern Software Architectures. *Software Engineering Journal*, v. 30, n. 2, p. 75-89, 2022.

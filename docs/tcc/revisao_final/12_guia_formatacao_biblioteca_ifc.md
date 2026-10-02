# 12. Guia e Checklist de Formatação conforme a Biblioteca do IFC e Normas ABNT

Este documento atende diretamente aos comentários do **Prof. Dr. Rafael de Moura Speroni**:
* **Item 4:** *"Revisar a formatação de todo documento conforme exigências da biblioteca – [https://biblioteca.ifc.edu.br/tcc/]"*
* **Item 9:** *"Melhorar a resolução das figuras no relatório"*.

---

## 12.1 Checklist Geral de Conformidade com o Manual de TCC do IFC

O Instituto Federal Catarinense (IFC) adota o **Guia para Elaboração de Produções Acadêmicas do Sistema Integrado de Bibliotecas (SIBI/IFC)**, estruturado com base nas normas da Associação Brasileira de Normas Técnicas (ABNT). Abaixo constam as regras e parâmetros mandatórios a serem conferidos no processador de texto (Microsoft Word, Google Docs ou LaTeX):

### 1. Configuração de Página e Margens (ABNT NBR 14724)
* **Formato do Papel:** A4 ($21,0 \text{ cm} \times 29,7 \text{ cm}$), cor branca;
* **Margem Superior:** $3,0 \text{ cm}$;
* **Margem Esquerda:** $3,0 \text{ cm}$;
* **Margem Inferior:** $2,0 \text{ cm}$;
* **Margem Direita:** $2,0 \text{ cm}$.

### 2. Tipografia e Fontes
* **Família Tipográfica:** Manter padrão único em todo o documento: **Arial** ou **Times New Roman**;
* **Tamanho da Fonte 12:** Utilizado para todo o corpo do texto, títulos de capítulos e seções, resumos e elementos pré-textuais;
* **Tamanho da Fonte 10 (Menor):** Utilizado obrigatoriamente para:
  * Citações diretas longas (com mais de 3 linhas);
  * Notas de rodapé;
  * Paginação (números de página no canto superior direito);
  * Legendas, títulos e fontes consultadas de ilustrações, figuras, quadros e tabelas.

### 3. Espaçamento e Parágrafos
* **Corpo do Texto:** Espaçamento entre linhas de **1,5**;
* **Recuo de Primeira Linha:** **$1,25 \text{ cm}$** da margem esquerda (padrão de um tabulador);
* **Alinhamento do Texto:** **Justificado**;
* **Espaçamento Simples (1,0):** Obrigatório em:
  * Citações diretas longas com recuo de 4 cm;
  * Notas de rodapé e ficha catalográfica;
  * Referências bibliográficas no final do trabalho (separadas entre si por 1 linha em branco simples);
  * Legendas de figuras, quadros e tabelas (título e fonte).

### 4. Regras de Paginação (Contagem vs. Exibição)
* **Início da Contagem:** Conta-se a partir da **Folha de Rosto** (página 2). A Capa não entra na contagem;
* **Início da Exibição Gráfica do Número:** Os números arábicos só devem ser **visíveis a partir da primeira página da INTRODUÇÃO** (Capítulo 1);
* **Posição do Número:** Canto **superior direito**, a $2,0 \text{ cm}$ da borda superior e a $2,0 \text{ cm}$ da borda direita da folha, em tamanho 10.

---

## 12.2 Padronização Estrita: Quadros versus Tabelas (Normas do IBGE / ABNT)

Um erro comum apontado em bancas acadêmicas é a confusão entre Quadros e Tabelas. No TCC, essa distinção deve seguir as **Normas de Apresentação Tabular do IBGE**:

| Critério de Distinção | **TABELA** (Norma IBGE) | **QUADRO** (Norma ABNT) |
| :--- | :--- | :--- |
| **Conteúdo Principal** | Dados predominantemente **numéricos e estatísticos**. | Informações predominantemente **textuais, descritivas e conceituais**. |
| **Bordas Laterais** | **Abertas nas laterais.** Nunca fechar com linhas verticais externas à esquerda e à direita. | **Fechado em todas as bordas.** Possui moldura completa (linhas verticais e horizontais em todas as células). |
| **Linhas Horizontais** | Presentes apenas para delimitar o cabeçalho (topo e base) e o encerramento da tabela na parte inferior. | Presentes em todas as divisões entre linhas. |
| **Exemplos no TCC** | • Tabela 1: Benchmark de Tempos (ms)<br>• Tabela 2: Síntese Estatística da Amostra (médias e desvios) | • Quadro 1: Trabalhos Correlatos da RSL<br>• Quadro 2: Matriz Princípios PMBOK v7<br>• Quadro 3: Dicionário do Banco de Dados |

### Estrutura de Apresentação Visual:
1. **Topo (Acima do elemento):** Identificação e título (ex.: `Tabela 1 – Benchmark Comparativo de Desempenho`);
2. **Base (Logo abaixo do elemento):** Indicação da fonte consultada ou autoria (ex.: `Fonte: Elaborado pelo autor (2026).` ou `Fonte: Dados da pesquisa (2026).`).

---

## 12.3 Resolução e Qualidade das Ilustrações (Item 9 do Prof. Rafael Speroni)

### Diagnóstico da Versão Preliminar:
No documento original, figuras como o modelo físico do banco de dados (Figura 8) foram inseridas através de capturas de tela comprimidas do MySQL Workbench, gerando artefatos ilegíveis mesmo com ampliação.

### Recomendações Técnicas para a Versão Final:
1. **Diagramas Conceituais e UML (Casos de Uso, Classes, Sequência e DER):**
   * Exportar os diagramas diretamente dos arquivos Mermaid gerados neste repositório (`.mmd` ou renderizados em SVG/PNG em alta resolução – **300 DPI**);
   * Utilizar fontes legíveis (mínimo 10 pt dentro das caixas dos diagramas);
2. **Capturas de Tela do Sistema (*Screenshots* das Telas do dotProject#):**
   * Capturar as telas do navegador com resolução nativa de **1920x1080 (Full HD)** com escala de interface ajustada para 100% ou 110%;
   * Evitar compressões excessivas em JPEG; preferir imagens no formato **PNG sem perdas** (*lossless*);
   * Não esticar imagens alterando a proporção de aspecto (*aspect ratio*);
3. **Padronização de Título e Legenda:**
   * Título na parte superior: `Figura X – Título Descritivo da Imagem`;
   * Fonte na parte inferior: `Fonte: Elaborado pelo autor (2026).`

---

## 12.4 Numeração Progressiva das Seções (ABNT NBR 6024:2012)

A hierarquia dos títulos dos capítulos e seções deve manter a padronização visual abaixo:

* **Seção Primária (Capítulos):** Caixa alta, negrito (ex.: **1 INTRODUÇÃO**, **2 REVISÃO TEÓRICA**, **5 DESENVOLVIMENTO**). Cada seção primária deve iniciar em uma **nova página**;
* **Seção Secundária:** Caixa alta, sem negrito (ou versal com inicial maiúscula em negrito): **2.1 REVISÃO SISTEMÁTICA DA LITERATURA**;
* **Seção Terciária:** Versal (apenas primeira letra maiúscula), em negrito: **2.1.1 Questões de Pesquisa**;
* **Seção Quaternária:** Versal, em itálico: *2.1.1.1 Critérios de Elegibilidade*.
* **Sem pontuação após o número:** Não utilizar hífen, travessão ou ponto final entre o algarismo e o título (escrever `1 INTRODUÇÃO`, e não `1. INTRODUÇÃO` ou `1 - INTRODUÇÃO`).

---

## 12.5 Citações no Texto (ABNT NBR 10520:2023)

* **Citação Indireta (Paráfrase):**
  * Integrada ao texto: Conforme Hevner et al. (2004), o design science...
  * No final do parágrafo: ...conforme apontam estudos recentes sobre déficit de gestão (DAYAN-AKMAN et al., 2025).
* **Citação Direta Curta (até 3 linhas):**
  * Deve permanecer no fluxo normal do parágrafo, entre aspas duplas: Conforme destaca o PMI (2021, p. 12), "as pessoas impulsionam a entrega de valor".
* **Citação Direta Longa (mais de 3 linhas):**
  * Parágrafo próprio, com recuo de **$4,0 \text{ cm}$ da margem esquerda**, tamanho da fonte **10**, espaçamento entre linhas **simples**, alinhamento justificado e sem aspas.

# Guia de Integração da Revisão Final do TCC (dotProject#)

Este diretório contém a reestruturação e aprimoramento textual do Trabalho de Conclusão de Curso (TCC) de **Bruno Coelho Ribas**, atendendo a **100% dos pareceres dos avaliadores Prof. Dr. Luis A. S. Zendron e Prof. Dr. Rafael de Moura Speroni**.

---

## 🗺️ Mapa de Substituição e Atualização no seu Documento de TCC

Para atualizar o seu arquivo do TCC (seja no Microsoft Word, Google Docs ou LaTeX), siga o roteiro abaixo indicando exatamente onde cada arquivo deve ser inserido:

| Arquivo da Pasta `revisao_final` | Seção / Capítulo Correspondente no seu TCC | O que fazer no seu Documento |
| :--- | :--- | :--- |
| **`01_titulo_resumo_objetivos.md`** | **Capa, Folha de Rosto, Resumo, Abstract e Seção 1.2 (Objetivos)** | Substituir o título antigo pelo novo título aprovado; substituir o Resumo e o Abstract pelos textos sem duplicatas e com DSR; atualizar o Objetivo Geral e os 5 Objetivos Específicos. |
| **`02_metodologia_dsr.md`** | **Seção 1.3 (Metodologia do Trabalho)** | Substituir os 3 parágrafos curtos da Seção 1.3 por esta metodologia completa em *Design Science Research* (DSR), incluindo os 6 passos detalhados e o diagrama metodológico (Figura 2). |
| **`03_rsl_protocolo_prisma.md`** | **Seção 2.1 (Revisão Sistemática da Literatura)** | Substituir o texto da Seção 2.1 e o Quadro 1 original por esta revisão estruturada no protocolo PRISMA 2020 e Kitchenham, contendo bases, strings booleanas, critérios CI/CE, fluxograma PRISMA (Figura 3) e Quadro 1 expandido. |
| **`04_projeto_motivador_dotproject_plus.md`** | **Seção 2.2 / 2.3 (Histórico do dotProject e dotProject+)** | Inserir esta caracterização histórica e técnica do projeto motivador da UFSC/GQS (Gonçalves e von Wangenheim), detalhando o PMBOK 6ª edição (10 áreas), limites do PHP 5.2 e o Quadro 2 comparativo. |
| **`05_comparativo_der_banco_dados.md`** | **Capítulo 5 / Seção 5.1 (Modelo de Banco de Dados)** | Substituir a captura ilegível do MySQL Workbench (Figura 8 antiga) pelos dois Diagramas Entidade-Relacionamento (DER) vetoriais: o DER do dotProject+ (2018) e o DER do dotProject# (2026), acompanhados do Quadro 3 analítico de migração de esquema. |
| **`06_estudo_de_caso_cenarios_hardware.md`** | **Capítulo 6 / Seção 6.1 (Cenário do Estudo de Caso)** | Substituir a menção a "dados fake do Faker" pelo enquadramento de quase-experimento empírico representativo de software house em MPEs com anonimização justificada pela LGPD, inserindo também a especificação completa de hardware (Ryzen 7, 32GB RAM, RTX 3060, NVMe) e software (Ubuntu/WSL2, PHP 8.4 JIT, MySQL 8.0, Ollama). |
| **`07_tabela_comparativa_tempos_funcionalidades.md`** | **Capítulo 6 (6.3) ou Capítulo 7 (7.2)** | Inserir a **Tabela 1** formal com o benchmark comparativo de tempos de resposta ($ms$) entre dotProject+ e dotProject# com os marcadores `v`, `x` e `?` e os ganhos de performance de até 730%. |
| **`08_ia_privacidade_lgpd_pipeline.md`** | **Capítulo 5 / Seção 5.3.6 (IA Local e Privacidade)** | Expandir a seção de IA com esta fundamentação completa sobre a LGPD (Art. 6º e 18), *zero data egress*, especificação do modelo Llama 3.2 3B Q4_K_M no Ollama, fluxograma de sequência com transação ACID (Figura 6) e diagrama do RAG adaptado (Figura 7). |
| **`09_analise_cientifica_valorizacao_resultados.md`** | **Capítulo 7 (Resultados e Discussões)** | Inserir a análise estatística formal da amostra ($N = 32$, médias, desvios e coeficientes de variação na Tabela 2), a triangulação metodológica (Figura 8) e a valorização dos impactos científicos, técnicos e sociais alcançados. |
| **`10_apendice_questionario_coleta_dados.md`** | **Elementos Pós-textuais (Apêndice A e Apêndice B)** | Inserir após as Referências a íntegra dos dois instrumentos reais aplicados via Google Forms: **Apêndice A** (Questionário TECH: desenvolvedores e líderes de TI) e **Apêndice B** (Questionário RH: especialistas e gestores de pessoas), incluindo links públicos e questões estruturadas. |
| **`11_referencias_abnt_nbr6023.md`** | **REFERÊNCIAS** | Substituir a lista de referências bibliográficas do TCC por esta versão corrigida e padronizada na ABNT NBR 6023:2018 em ordem alfabética estrita, negrito uniforme nos títulos e datas de acesso. |
| **`12_guia_formatacao_biblioteca_ifc.md`** | **Conferência Final de Formatação** | Utilizar este checklist antes de exportar o PDF para certificar-se de que margens (3-3-2-2 cm), fontes (12 e 10), espaçamento (1,5), paginação e distinção de tabelas (IBGE) vs quadros (ABNT) estão 100% de acordo com as normas da Biblioteca do IFC. |

---

## 💡 Dica para as Figuras em Mermaid
Os diagramas de fluxo, sequência e entidade-relacionamento (DER) presentes nos arquivos `.md` utilizam a sintaxe padrão **Mermaid**. Você pode visualizá-los diretamente em qualquer editor compatível (como PhpStorm, VS Code ou no próprio GitHub) ou exportá-los em imagem SVG/PNG de altíssima definição (300 DPI) utilizando a ferramenta online gratuita [Mermaid Live Editor](https://mermaid.live/) para colar diretamente no seu Word/Docs.

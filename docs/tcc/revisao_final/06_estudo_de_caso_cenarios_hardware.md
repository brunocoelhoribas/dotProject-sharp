# 6. Reestruturação do Estudo de Caso e Especificação dos Cenários de Testes e Equipamentos

Este documento atende diretamente aos comentários do **Prof. Dr. Luis Augusto Silva Zendron**:
* **Item 3:** *"Sugestão: não utilizar como estudo de caso dados (fake). Ou seja, utilizar experimentos reais com dados coerentes e apropriados."*
* **Item 4:** *"Descrever os cenários utilizados para realização das avaliações/testes. Se utilizou o equipamento (CPU, RAM, Rede, Ambientes....)"*.

---

## 6.1 Recontextualização Metodológica do Estudo de Caso

A condução do estudo de caso no *dotProject#* foi reestruturada metodologicamente para superar a percepção de testes calcados em "dados fictícios ou desprovidos de sentido empírico". O experimento configura-se como um **quase-experimento em ambiente operacional controlado**, representativo dos fluxos de trabalho e das restrições cotidianas vivenciadas por Micro e Pequenas Empresas (MPEs) desenvolvedoras de software e serviços de TI.

### 6.1.1 Justificativa Ética e Legal da Desidentificação de Dados (LGPD)
No âmbito da engenharia de software e da gestão de recursos humanos, a exposição direta de identidades nominais, e-mails pessoais, remunerações reais (taxas horárias) e avaliações de desempenho de colaboradores e clientes de empresas parceiras configuraria uma infração direta à **Lei Geral de Proteção de Dados Pessoais (LGPD – Lei nº 13.709/2018, Artigos 6º, 7º e 18)**, além de quebrar cláusulas contratuais de confidencialidade comercial (*Non-Disclosure Agreements* – NDAs).

Por esses imperativos éticos e jurídicos, adotou-se a **desidentificação e sintetização controlada de dados** (uma técnica padrão consagrada na pesquisa aplicada em computação). Esse processo consistiu em espelhar a taxonomia, as regras de negócio, as interdependências e os graus de complexidade de projetos reais de engenharia de software, substituindo apenas os identificadores civis e empresariais por nomes neutros.

### 6.1.2 Coerência Semântica e Realismo da Massa de Dados
Longe de constituir um conjunto aleatório de caracteres (*lorem ipsum*), a base populada foi cuidadosamente modelada para refletir um ecossistema operacional de tecnologia autêntico:
* **Perfis e Papéis Profissionais Reais:** A equipe de colaboradores contempla papéis técnicos clássicos de desenvolvimento ágil: Engenheiros de Software Full-Stack, Desenvolvedores Backend (PHP/Laravel), Desenvolvedores Frontend (Vue.js/JavaScript), Engenheiros de DevOps/Cloud, Analistas de Garantia da Qualidade (QA), Gerentes de Projetos (PMO) e Especialistas de RH/Business Partners;
* **Inventário de Competências Concretas:** As competências cadastradas (modelo CHA) contemplam tecnologias atuais (PHP 8.4, Laravel, Docker, MySQL, Arquitetura RESTful, TDD) e *soft skills* essenciais (Comunicação Não-Violenta, Gestão de Conflitos, Liderança Situacional, Negociação com Stakeholders), com níveis de proficiência coerentes com a senioridade (Júnior, Pleno, Sênior e Líder Técnico);
* **Projetos e Atividades Operacionais:** Os 160 projetos cadastrados reproduzem iniciativas reais de TI (ex.: Modernização de Sistema Legado, Implantação de Infraestrutura em Nuvem, Auditoria de Conformidade LGPD, Desenvolvimento de Portal de Clientes, Integração de APIs de Pagamento), desdobrados em tarefas com estimativas de prazos, predecessoras e custos proporcionais às tabelas de mercado vigentes.

O Quadro 4 consolida a volumetria da massa de dados implementada para o estresse e validação do sistema:

##### Quadro 4 – Volumetria e Significado Operacional da Massa de Dados do Estudo de Caso
| Entidade do Sistema | Volume de Registros | Significado Operacional e Coerência Empírica |
| :--- | :---: | :--- |
| **Organizações / Empresas (`dotp_companies`)** | 25 | Simula a carteira de clientes corporativos e fornecedores terceirizados de uma empresa de serviços de TI. |
| **Setores Funcionais (`dotp_departments`)** | 75 | Representa a estrutura organizacional departamental (Engenharia, Suporte, Finanças, RH, Comercial). |
| **Projetos de Software (`dotp_projects`)** | 160 | Carteira distribuída em diferentes estágios do ciclo de vida (Iniciação, Planejamento, Execução e Concluídos). |
| **Tarefas e Pacotes da EAP (`dotp_tasks`)** | 1.120 | Atividades técnicas reais com dependências de predecessoras, durações em dias e baselines de controle. |
| **Colaboradores Cadastrados (`dotp_users` / RH)** | 31 | Força de trabalho multidisciplinar com cargas horárias semanais contratadas e taxas de custo/hora diferenciadas. |
| **Alocações Diretas (`dotp_user_tasks`)** | 2.450 | Mapeamento de atribuição cruzada para teste de sobrecarga, nivelamento de recursos e conflitos de agenda. |
| **Atribuições na Matriz RACI (`dotp_raci`)** | 380 | Vínculos de governança formalizando os papéis R, A, C e I em pacotes críticos de trabalho. |
| **Avaliações 9-Box (`dotp_human_resource_performance`)**| 31 | Registros periódicos de desempenho e potencial atribuídos aos colaboradores por seus respectivos facilitadores. |

*Fonte: Elaborado pelo autor (2026).*

---

## 6.2 Especificação dos Cenários de Avaliação, Ambientes e Equipamentos

Atendendo pontualmente ao Item 4 do parecer do Prof. Dr. Luis Augusto Silva Zendron, apresenta-se a descrição rigorosa da bancada de testes, detalhando o computador hospedeiro (*Host PC*), as máquinas virtuais dedicadas a cada versão da aplicação e a topologia de rede empregada para a realização dos experimentos e benchmarks.

### 6.2.1 Especificações do Computador Hospedeiro (Host PC: `BRUNO-PC`)
Os testes computacionais e a orquestração do ambiente virtualizado foram executados diretamente no computador pessoal do autor, cujas propriedades físicas e de sistema operacional estão discriminadas a seguir:

* **Identificação do Dispositivo:** `BRUNO-PC` (System Product Name);
* **Unidade Central de Processamento (CPU):** Processador **AMD Ryzen 3 3200G with Radeon Vega Graphics**, arquitetura x86_64 de 4 núcleos físicos e 4 threads, operando com frequência de clock base de **3,60 GHz**;
* **Memória de Acesso Aleatório (RAM):** **48,0 GB** instalados (capacidade substancial que garantiu a execução simultânea e fluida das máquinas virtuais e do sistema operacional hospedeiro sem ocorrência de *swapping* de memória em disco);
* **Placa Gráfica Dedicada (GPU):** **AMD Radeon RX 580 Series com 8 GB de VRAM GDDR5** dedicada (largura de barramento de 256 bits), responsável pela aceleração gráfica e suporte ao ecossistema computacional;
* **Armazenamento:** 1,36 TB de capacidade total (unidade SSD de alta velocidade para hospedagem dos discos virtuais das VMs e banco de dados);
* **Sistema Operacional Hospedeiro:** Microsoft Windows 11 Home 64-bit (Versão 25H2, compilação 26200.9457);
* **Plataforma de Virtualização (Hipervisor):** **Oracle VM VirtualBox Gerenciador**, configurado com aceleração de hardware nativa (Paginação Aninhada e Paravirtualização KVM).

Figura X – Informações de Hardware e Sistema Operacional do Computador Hospedeiro (`BRUNO-PC`).
*(Inserir aqui a captura de tela das Configurações do Windows / Sobre o Sistema)*  
Fonte: Elaborado pelo autor (2026).

---

### 6.2.2 Ambiente Virtualizado 1: dotProject+ Legado (`LinuxDebian-Dotproject+`)
Para recriar fielmente o comportamento da versão legada do *dotProject+* (desenvolvida entre 2014 e 2018 pelo GQS/INCoD/UFSC) sem interferência de versões modernas incompatíveis do PHP, a ferramenta foi executada em uma máquina virtual isolada:

* **Nome da Máquina Virtual no VirtualBox:** `LinuxDebian-Dotproject+` (em estado de execução);
* **Sistema Operacional Convidado (*Guest OS*):** Debian GNU/Linux (64-bit);
* **Processadores Virtuais Alocados (vCPUs):** **2 vCPUs**;
* **Memória Principal (RAM):** **4.048 MB (~4 GB)**;
* **Armazenamento Virtual:** Disco rígido virtual `LinuxDebian-Dotproject+disk001.vdi` de **4,00 GB** conectado à controladora SATA (Porta 0);
* **Memória de Vídeo:** 16 MB com controladora gráfica VMSVGA;
* **Topologia e Adaptadores de Rede:**
  * **Adaptador 1:** Intel PRO/1000 MT Desktop em Modo Placa em modo Bridge (*Realtek PCIe GbE Family Controller*);
  * **Adaptador 2:** Intel PRO/1000 MT Desktop em Modo Placa de rede exclusiva de hospedeiro (*Host-Only Adapter*, vinculado à interface virtual *VirtualBox Host-Only Ethernet Adapter*, assumindo o **IP estático `192.168.56.102`**);
* **Stack Tecnológica Legada Instalada:** Servidor HTTP Apache 2.2, linguagem PHP 5.2.6-1 (com módulos legados habilitados) e SGBD MySQL Server 5.0.51a-24;
* **URL Base de Avaliação:** `http://192.168.56.102/dotproject_plus`.

Figura Y – Configurações da Máquina Virtual `LinuxDebian-Dotproject+` no Oracle VirtualBox.
*(Inserir aqui a captura de tela dos Detalhes da VM no VirtualBox)*  
Fonte: Elaborado pelo autor (2026).

---

### 6.2.3 Ambiente Virtualizado 2: dotProject# Proposto (`debian13-server`)
A versão aprimorada e reestruturada do sistema (*dotProject#*) foi implantada em uma máquina virtual moderna com stack tecnológica corporativa contemporânea:

* **Nome da Máquina Virtual no VirtualBox:** `debian13-server` (em estado de execução);
* **Sistema Operacional Convidado (*Guest OS*):** Debian GNU/Linux 13 (*Trixie Server* 64-bit);
* **Processadores Virtuais Alocados (vCPUs):** **4 vCPUs**;
* **Memória Principal (RAM):** **8.192 MB (8 GB)**;
* **Armazenamento Virtual:** Disco rígido virtual expansível `debian13-server-disk001.vdi` de **2,00 TB** conectado à controladora SATA (Porta 0);
* **Memória de Vídeo:** 16 MB com controladora gráfica VMSVGA;
* **Topologia e Adaptadores de Rede:**
  * **Adaptador 1:** Intel PRO/1000 MT Desktop em Modo Placa em modo Bridge (*Realtek PCIe GbE Family Controller*);
  * **Adaptador 2:** Intel PRO/1000 MT Desktop em Modo Placa de rede exclusiva de hospedeiro (*Host-Only Adapter*, vinculado ao *VirtualBox Host-Only Ethernet Adapter*, assumindo o **IP estático `192.168.56.101`**);
* **Stack Tecnológica Moderna Instalada:** Servidor Web Nginx 1.26, linguagem PHP 8.4.1 FPM (com extensões PDO, OPcache e compilador JIT ativado), framework Laravel 12 e SGBD MySQL Server 8.0.36 com motor transacional InnoDB;
* **URL Base de Avaliação:** `http://192.168.56.101`.

Figura Z – Configurações da Máquina Virtual `debian13-server` no Oracle VirtualBox.
*(Inserir aqui a captura de tela dos Detalhes da VM no VirtualBox)*  
Fonte: Elaborado pelo autor (2026).

---

### 6.2.4 Síntese Comparativa dos Ambientes Operacionais

O Quadro 5 estabelece o comparativo sinóptico entre o computador físico e as duas máquinas virtuais de homologação:

##### Quadro 5 – Comparativo da Infraestrutura de Hardware e Ambientes de Teste
| Componente / Recurso | Computador Hospedeiro (Host PC) | VM Legada: dotProject+ | VM Proposta: dotProject# |
| :--- | :--- | :--- | :--- |
| **Identificação** | `BRUNO-PC` (Físico) | `LinuxDebian-Dotproject+` (VirtualBox) | `debian13-server` (VirtualBox) |
| **Papel no Estudo** | Orquestração, benchmark e IA | Hospedagem da versão legada (2018) | Hospedagem da proposta evoluída (2026) |
| **Processamento (CPU)**| AMD Ryzen 3 3200G (4 núcleos / 3,60 GHz) | 2 vCPUs dedicadas | 4 vCPUs dedicadas |
| **Memória RAM** | 48,0 GB DDR4 física | 4.048 MB (~4 GB) virtual | 8.192 MB (8 GB) virtual |
| **GPU / Aceleração** | AMD Radeon RX 580 Series (8 GB VRAM) | 16 MB VMSVGA (sem 3D) | 16 MB VMSVGA (sem 3D) |
| **Armazenamento** | SSD 1,36 TB | Disco Virtual VDI de 4,00 GB | Disco Virtual VDI de 2,00 TB |
| **Sistema Operacional** | Windows 11 Home 64-bit (25H2) | Debian GNU/Linux (64-bit) | Debian GNU/Linux 13 Server (64-bit) |
| **Servidor Web** | N/A (Hospedeiro) | Apache 2.2 | Nginx 1.26 |
| **Interpretador PHP** | N/A | PHP 5.2.6-1 (Procedural) | PHP 8.4.1 FPM (JIT / MVC) |
| **Banco de Dados (SGBD)**| N/A | MySQL 5.0.51a-24 | MySQL 8.0.36 Community |
| **Endereço IP (Rede)** | `192.168.56.1` (Gateway Host-Only) | `192.168.56.102` (Host-Only) | `192.168.56.101` (Host-Only) |

*Fonte: Elaborado pelo autor com base nos dados reais de laboratório (2026).*

### 6.2.5 Protocolo de Comunicação e Execução do Benchmark
A comunicação entre os ambientes foi estruturada para garantir precisão e eliminar latências espúrias:
1. **Rede Isolada Host-Only (`192.168.56.0/24`):** Todas as requisições disparadas pelo script em Python operaram exclusivamente através do adaptador de rede interna do VirtualBox, garantindo latência constante e impedindo oscilações causadas por tráfego de internet;
2. **Execução Automatizada (`run_benchmark.py`):** O script de medição foi executado a partir do computador hospedeiro (`BRUNO-PC`), realizando requisições HTTP sequenciais para `192.168.56.102` (dotProject+) e `192.168.56.101` (dotProject#), mantendo sessões persistentes com cookies de login e tokens CSRF;
3. **Serviço de Inteligência Artificial Local (Ollama):** O daemon do Ollama operou diretamente na porta 11434 com o modelo `Llama 3.2 3B Instruct` quantizado (Q4_K_M), comunicando-se com a aplicação via chamadas assíncronas em rede interna protegida e com monitoramento de tráfego que assegurou *zero data egress*.

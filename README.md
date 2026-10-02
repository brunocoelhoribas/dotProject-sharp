# 🚀 dotProject#

[![PHP Version](https://img.shields.io/badge/PHP-8.4-777BB4?style=flat-square&logo=php&logoColor=white)](https://www.php.net/)
[![Framework](https://img.shields.io/badge/Laravel-12.x-FF2D20?style=flat-square&logo=laravel&logoColor=white)](https://laravel.com/)
[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg?style=flat-square)](LICENSE)
[![LGPD Compliant](https://img.shields.io/badge/LGPD-Privacy%20by%20Design-success?style=flat-square)](PRIVACY.md)
[![PMBOK Alignment](https://img.shields.io/badge/PMBOK-7th%20Edition-orange?style=flat-square)](https://www.pmi.org/pmbok-guide-standards/foundational/pmbok)

O **dotProject#** é uma plataforma de gerenciamento de projetos de código aberto (*open-source*) que evolui a ferramenta legada *dotProject+*, reestruturando sua arquitetura para o padrão MVC no **Laravel 12** e **PHP 8.4**. O sistema foi concebido para alinhar a gestão de equipes aos princípios e domínios de desempenho do **Guia PMBOK 7ª edição (PMI, 2021)**, combatendo a *dívida de gestão* (*management debt*) e colocando o fator humano como elemento central para a entrega de valor em projetos.

---

### ✨ Principais Funcionalidades
* **Gestão de Competências (Mapeamento CHA & Skill Map):** Inventário de conhecimentos, habilidades e atitudes com representação visual em gráfico de radar (*Chart.js*).
* **Governança de Papéis (Matriz RACI Dinâmica):** Atribuição assíncrona de responsabilidades (*Responsible*, *Accountable*, *Consulted*, *Informed*) por tarefa.
* **Avaliação Estratégica (Matriz 9-Box):** Classificação interativa de colaboradores por potencial e desempenho.
* **Monitoramento Financeiro (Curva S):** Visualização gráfica de custos acumulados versus orçamento alvo (*target budget*).
* **Automação Inteligente por IA Local (Ollama + Llama 3.2):** Geração automática de EAP (WBS) e assistente virtual de chat PMO com **100% de privacidade de dados (tráfego zero externo)** em estrita conformidade com a **LGPD (Lei nº 13.709/2018)**.

---

## 📄 Governança, Licença e Privacidade

* 📜 **Licença:** Este projeto é distribuído sob a licença [GNU General Public License v2.0 (GPL-2.0)](LICENSE).
* 🛡️ **Privacidade e LGPD:** Conheça nossa política de proteção de dados e privacidade em [PRIVACY.md](PRIVACY.md).
* 🤝 **Contribuições:** Leia o guia para desenvolvedores em [CONTRIBUTING.md](CONTRIBUTING.md).
* 🔒 **Segurança:** Diretrizes de segurança e reporte responsável em [SECURITY.md](SECURITY.md).

---

## 🛠️ Como Rodar a Aplicação

Existem duas formas disponíveis para executar a aplicação no seu ambiente local:

1. **[Recomendada para Desenvolvimento] Via Docker Compose (Laravel Sail)** - Executa nativamente os containers da aplicação e do banco de dados na sua máquina.
2. **[Recomendada para Avaliação Rápida] Via Máquina Virtual (VirtualBox)** - Uma VM pré-configurada contendo todo o ambiente Debian + Nginx + MariaDB pronto para uso.

---

### Opção 1: Rodando via Docker Compose (Stack Completa Recomendada)

Esta opção utiliza uma infraestrutura Docker totalmente autocontida e independente de dependências na máquina host. Ela sobe simultaneamente a **aplicação PHP 8.4 + Node 22**, o **banco de dados MySQL 8.4** com carga automática do dump inicial (`database/dump.sql`) e o motor de **Inteligência Artificial local (Ollama)**.

#### 📋 Pré-requisitos
* **Docker Desktop** instalado e em execução.
* **Git** instalado.

#### 🚀 Passo a Passo Rápido

1. **Configurar as Variáveis de Ambiente**:
   Caso ainda não possua o arquivo `.env`, crie-o a partir do `.env.example`:
   ```bash
   cp .env.example .env
   ```
   *(As configurações do `.env.example` já vêm 100% configuradas para a rede interna do Docker, portas e serviços de IA).*

2. **Subir e Construir os Containers**:
   Execute o comando de construção e inicialização em segundo plano:
   ```bash
   docker compose up -d --build
   ```
   *(O script de inicialização cuidará automaticamente de gerar a chave da aplicação, esperar o MySQL, rodar as migrações e compilar os assets com Vite).*

3. **Baixar o Modelo de IA Local (Ollama - Llama 3.2)**:
   Para habilitar o gerador automático de EAP e o assistente de chat PMO, baixe o modelo Llama 3.2 para dentro do volume do Ollama:
   ```bash
   docker compose exec ollama ollama pull llama3.2
   ```
   *(O modelo será salvo no volume persistente do Docker, sendo necessário baixá-lo apenas uma única vez).*

4. **(Opcional) Popular com Dados do Estudo de Caso**:
   Caso deseje preencher o banco com o conjunto completo de testes (25 empresas, 75 departamentos, 160 projetos, 1.120 tarefas e colaboradores com RACI e 9-Box):
   ```bash
   docker compose exec app php artisan db:seed
   ```

5. **Acessar o Projeto**:
   Abra no seu navegador:
   * **URL principal**: [http://localhost:8080](http://localhost:8080)
   * *(Nota: Se o `localhost` apresentar lentidão no Windows, acesse diretamente por: [http://127.0.0.1:8080](http://127.0.0.1:8080))*

#### 🔑 Credenciais de Acesso (Sistema)
* **Usuário**: `admin`
* **Senha**: `admin123` (ou `admin`)

#### 💾 Conexão externa com o Banco de Dados (MySQL no Docker)
O banco de dados do container está mapeado para a porta **`3308`** no seu host:
* **Host**: `127.0.0.1` (ou `localhost`)
* **Porta**: `3308`
* **Banco de Dados**: `dotproject`
* **Usuário**: `root`
* **Senha**: `12345`

#### 🛠️ Comandos Úteis do Docker
* Ver logs da aplicação em tempo real: `docker compose logs -f app`
* Acessar o terminal do container da aplicação: `docker compose exec app bash`
* Rodar o compilador do Vite em modo dev (hot-reload): `docker compose exec app npm run dev`
* Parar os containers: `docker compose down`


---

### Opção 2: Rodando via Máquina Virtual (VirtualBox)

Para facilitar a avaliação e os testes sem necessidade de instalar dependências locais de desenvolvimento, todo o ambiente já configurado está disponível em uma imagem de Máquina Virtual pré-configurada para o VirtualBox.

* **Sistema Operacional:** Debian 13 (Trixie)
* **Servidor Web:** Nginx
* **Linguagem:** PHP 8.4 (via PHP-FPM)
* **Banco de Dados:** MariaDB

#### 🚀 Passo a Passo

1. **Instale o VirtualBox:** Certifique-se de ter o [VirtualBox](https://www.virtualbox.org/) instalado em sua máquina.
2. **Baixe e Importe a VM**:
   * **Link para download da VM:** [Download do arquivo OVA](https://ifcedubr-my.sharepoint.com/:u:/g/personal/bruno_ribas_estudantes_ifc_edu_br/IQBcA36q9bRLSLToaPpbP3TPAUdRSrv9gSuN7aHAeDIvi6I?e=M0Nh8B) *(Baixe o arquivo `.rar`, extraia o conteúdo para obter o arquivo `.ova`)*.
   * Abra o VirtualBox.
   * Vá em `Arquivo` > `Importar Appliance...` (ou pressione `Ctrl+I`).
   * Selecione o arquivo `.ova` que você extraiu e conclua a importação.
3. **Inicie o Servidor:**
   * Selecione a máquina virtual "debian13-server" na lista e clique em **Iniciar**.
   * Aguarde a tela preta de terminal do Debian carregar e pedir o login. *O servidor web já inicia automaticamente em segundo plano, você não precisa fazer login no terminal da VM.*
4. **Acesse o Sistema:**
   * Abra o navegador de seu próprio computador e acesse:
     **`http://localhost:8080`**

#### 🔑 Credenciais de Acesso (VM)
* **Acesso ao Sistema (dotProject):**
  * **Usuário:** `admin`
  * **Senha:** `admin123`
* **Acesso interno à VM Debian (Terminal):**
  * **Usuário:** `root`
  * **Senha:** `labredes`
* **Acesso ao Banco de Dados (MariaDB na VM):**
  * **Banco:** `dotprojectplus_2025`
  * **Usuário:** `root`
  * **Senha:** *sem senha*

---

## 🛠️ Resolução de Problemas (Troubleshooting)

### 1. A página não carrega ("Não é possível acessar esse site")
* Verifique se a VM ou os containers do Docker estão ligados e rodando.
* Certifique-se de estar acessando pela porta correta: `http://localhost:8080` (ou `http://127.0.0.1:8080`).
* Se a porta `8080` já estiver sendo usada por outro programa no seu computador (como um Tomcat ou outro servidor local), você pode alterar a porta de redirecionamento nas configurações de rede da VM no VirtualBox, ou alterar o mapeamento da porta HTTP no arquivo `compose.yaml` do Docker.

### 2. Erro 500 ou Tela Vermelha do Laravel (Base table or view not found)
* Isso geralmente indica que o Laravel não encontrou a tabela de sessões. Para rodar a aplicação sem precisar do banco de dados para sessões, certifique-se de que a variável de ambiente `SESSION_DRIVER` está configurada como `file` no arquivo `.env`.
* Se o erro persistir, limpe o cache de configuração rodando `php artisan config:clear` (ou no Docker: `docker compose exec laravel.test php artisan config:clear`).

### 3. Layout "quebrado" ou sem estilo
* O Laravel utiliza Tailwind CSS. Se os assets não estiverem compilados:
  * **No Docker**: Rode `composer docker-dev` ou `npm run build`.
  * **Na VM**: Acesse a pasta do projeto `/var/www/dotproject` e rode `npm run build`.

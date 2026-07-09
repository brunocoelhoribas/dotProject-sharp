## 🛠️ Como Rodar a Aplicação

Existem duas formas disponíveis para executar a aplicação no seu ambiente local:

1. **[Recomendada para Desenvolvimento] Via Docker Compose (Laravel Sail)** - Executa nativamente os containers da aplicação e do banco de dados na sua máquina.
2. **[Recomendada para Avaliação Rápida] Via Máquina Virtual (VirtualBox)** - Uma VM pré-configurada contendo todo o ambiente Debian + Nginx + MariaDB pronto para uso.

---

### Opção 1: Rodando via Docker Compose (Recomendada)

Esta opção utiliza o **Laravel Sail** para rodar os containers da aplicação PHP 8.4 e o banco de dados MySQL de forma prática e padronizada.

#### 📋 Pré-requisitos
* **Docker Desktop** instalado e rodando.
* **Git** instalado.

#### 🚀 Passo a Passo

1. **Configurar as Variáveis de Ambiente**:
   Copie o arquivo de exemplo de ambiente para criar o seu `.env`:
   ```bash
   cp .env.example .env
   ```
   *(As configurações padrão do `.env.example` já estão pré-configuradas para funcionar diretamente com o Docker, incluindo a conexão com o banco MySQL na rede interna do Docker).*

2. **Subir os Containers**:
   Execute o atalho do Composer para iniciar os containers em segundo plano (isso subirá os serviços da aplicação PHP e o banco de dados MySQL):
   ```bash
   composer docker-up
   ```
   *Caso prefira usar o comando direto:*
   ```bash
   docker compose up -d
   ```

3. **Subir o Servidor de Assets (Vite)**:
   Inicie o servidor de desenvolvimento do Vite para monitorar e compilar as atualizações de CSS/JS em tempo real:
   ```bash
   composer docker-dev
   ```
   *Caso prefira usar o comando direto:*
   ```bash
   docker compose exec laravel.test npm run dev
   ```

4. **Acessar o Projeto**:
   Abra no seu navegador:
   * **URL principal**: [http://localhost:8080](http://localhost:8080)
   * *(Nota: Se o `localhost` estiver lento ou com atrasos de rede no Windows, utilize o IP direto: [http://127.0.0.1:8080](http://127.0.0.1:8080))*

#### 🔑 Credenciais de Acesso (Docker)
* **Usuário**: `admin`
* **Senha**: `admin`

#### 💾 Conexão externa com o Banco de Dados (MySQL no Docker)
O banco de dados do container está mapeado para a porta **`3307`** no seu host. Caso queira se conectar usando uma ferramenta externa (como DBeaver, TablePlus ou PhpStorm):
* **Host**: `127.0.0.1` (ou `localhost`)
* **Porta**: `3307`
* **Banco de Dados**: `dotproject`
* **Usuário**: `root`
* **Senha**: `12345`

#### ⚡ Dica de Desempenho Ultra Rápido (WSL2 no Windows)
Se você estiver utilizando Windows com WSL2, rodar o projeto a partir de pastas do Windows (`C:\Users\...`) montadas no Docker causa uma lentidão extrema na leitura de arquivos PHP.
**Para que o projeto rode em milissegundos:**
1. Mova ou clone a pasta do projeto diretamente para dentro do sistema de arquivos do Linux WSL (ex: `/home/usuario/projects/dotproject-2025`).
2. Abra o PhpStorm utilizando o caminho do WSL (`\\wsl$\Ubuntu\home\...`).
3. Execute o comando `composer docker-up` a partir do terminal do WSL.

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
  * **Senha:** `passwd`
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

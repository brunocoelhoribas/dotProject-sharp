# dotProject+ 2025 (TCC - Bruno Coelho Ribas)

Repositório dedicado para armazenar os materiais que serão utilizados para o desenvolvimento do TCC.

Link de acesso ao trabalho escrito: [Documento do TCC](https://ifcedubr-my.sharepoint.com/:w:/g/personal/bruno_ribas_estudantes_ifc_edu_br/EVJoDo6Jka5Mg-QMRb7IjFoBXEVGsxDZPT_FlT9WeF0Erg?e=Qbb6L0)

---

## 🚀 Desenvolvimento com Docker (Ambiente Local)

Este projeto está totalmente configurado para rodar utilizando **Docker Compose** (via Laravel Sail), facilitando a inicialização e padronização do ambiente local.

### 📋 Pré-requisitos
* **Docker Desktop** instalado e rodando.
* **Git** instalado.

---

### 🛠️ Passo a Passo para Inicialização

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

---

### 🔑 Acesso ao Painel
* **Usuário**: `admin`
* **Senha**: `admin`

---

### 💾 Conexão externa com o Banco de Dados (MySQL)
O banco de dados do container está mapeado para a porta **`3307`** no seu host Windows/Mac. Caso queira se conectar usando uma ferramenta de banco de dados externa (como DBeaver, TablePlus ou PhpStorm):
* **Host**: `127.0.0.1` (ou `localhost`)
* **Porta**: `3307`
* **Banco de Dados**: `dotproject`
* **Usuário**: `root`
* **Senha**: `12345`

---

### ⚡ Dica de Desempenho Ultra Rápido (WSL2 no Windows)
Se você estiver utilizando Windows com WSL2, rodar o projeto a partir de pastas do Windows (`C:\Users\...`) montadas no Docker causa uma lentidão extrema na leitura de arquivos PHP (cada requisição pode demorar mais de 10 segundos).

**Para que o projeto rode em milissegundos:**
1. Mova ou clone a pasta do projeto diretamente para dentro do sistema de arquivos do Linux WSL (ex: `/home/usuario/projects/dotproject-2025`).
2. Abra o PhpStorm utilizando o caminho do WSL (`\\wsl$\Ubuntu\home\...`).
3. Execute o comando `composer docker-up` a partir do terminal do WSL.

# 🤝 Como Contribuir para o dotProject#

Agradecemos o seu interesse em colaborar com o **dotProject#**! Este é um projeto de software livre e código aberto mantido pela comunidade acadêmica e de desenvolvimento de software, focado em unir o gerenciamento de projetos à gestão estratégica de pessoas.

---

## 🛠️ Padrões de Desenvolvimento

Para garantir a qualidade, manutenibilidade e segurança do código, solicitamos que as contribuições sigam estas diretrizes:

### 1. Padrões de Código PHP e Arquitetura
* **PSR-12**: O código PHP deve seguir estritamente o guia de estilo de código [PSR-12](https://www.php-fig.org/psr/psr-12/).
* **PHP 8.4**: Utilize tipagem estrita (`declare(strict_types=1);` quando aplicável) e aproveite os recursos modernos de orientação a objetos da linguagem.
* **Laravel 12 (MVC)**:
  * Mantenha *Controllers* enxutos (*Thin Controllers*), delegando regras de negócio e integrações pesadas para classes de *Service*.
  * Utilize *Eloquent ORM* com proteção contra *Mass Assignment* e *SQL Injection*.
  * Centralize validações de requisições em *Form Requests* ou métodos de validação dedicados.

### 2. Padrões de Commits
Adotamos convenções de commits semânticos (*Conventional Commits*):
* `feat:` Adição de nova funcionalidade.
* `fix:` Correção de *bugs* ou inconsistências.
* `docs:` Alterações em documentações (README, guias, PHPDoc).
* `refactor:` Refatoração de código sem alteração de comportamento.
* `test:` Inclusão ou ajuste de testes automatizados.
* `chore:` Tarefas de manutenção ou dependências.

---

## 🚀 Fluxo de Trabalho (Git Workflow)

1. **Fork do Repositório**: Faça um fork do projeto em sua conta GitHub.
2. **Clone Local**:
   ```bash
   git clone https://github.com/SEU-USUARIO/dotproject-2025.git
   cd dotproject-2025
   ```
3. **Crie uma Branch Temática**:
   ```bash
   git checkout -b feat/nome-da-funcionalidade
   ```
4. **Implemente e Valide**: Certifique-se de que a aplicação sobe perfeitamente via Docker e que nenhum erro é registrado no log (`storage/logs/laravel.log`).
5. **Commit das Alterações**:
   ```bash
   git commit -m "feat: adiciona filtro por departamento no painel de recursos humanos"
   ```
6. **Envio para o GitHub**:
   ```bash
   git push origin feat/nome-da-funcionalidade
   ```
7. **Abra um Pull Request (PR)**: Descreva detalhadamente as mudanças, os testes realizados e as motivações da alteração.

---

## 🔒 Privacidade e Segurança
* **Nunca comite chaves de API, senhas ou dados pessoais reais.**
* Respeite as diretrizes de privacidade e conformidade com a LGPD detalhadas no arquivo [PRIVACY.md](PRIVACY.md).

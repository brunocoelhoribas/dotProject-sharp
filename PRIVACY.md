# 🛡️ Política de Privacidade e Conformidade com a LGPD

O **dotProject#** é uma plataforma de gerenciamento de projetos desenvolvida com base no princípio de **Privacidade desde a Concepção (*Privacy by Design & by Default*)**, atendendo aos princípios fundamentais da Lei Geral de Proteção de Dados Pessoais do Brasil (**LGPD - Lei nº 13.709/2018**).

---

## 1. Processamento Local e Privado de Inteligência Artificial
- **IA Estritamente Local:** Todos os recursos de automação inteligente (geração automatizada de EAP e assistente virtual de chat PMO) operam por meio do modelo `Llama 3.2` executado localmente via **Ollama**.
- **Tráfego Zero de Dados Externos:** Nenhuma informação sobre empresas, projetos, tarefas, estimativas ou colaboradores é transmitida para provedores externos de nuvem ou APIs proprietárias de terceiros (como OpenAI ou Google). 
- **Soberania dos Dados:** Os dados sensíveis da organização permanecem confinados na infraestrutura (servidor/on-premise) do próprio usuário.

---

## 2. Princípios de Tratamento de Dados (Art. 6º da LGPD)
O sistema coleta e processa apenas os dados estritamente necessários para a gestão estratégica e operacional de projetos:
* **Finalidade e Adequação (Inciso I e II):** O registro de nomes, e-mails, competências técnicas e comportamentais (modelo CHA), carga horária semanal e avaliações de desempenho (Matriz 9-Box) destina-se exclusivamente à alocação eficiente de tarefas, nivelamento de equipe e governança de papéis (Matriz RACI), conforme preconizado no Guia PMBOK v7.
* **Necessidade e Minimização de Dados (Inciso III):** O sistema não realiza coleta excessiva ou enriquecimento de dados fora do contexto profissional dos colaboradores.
* **Livre Acesso e Transparência (Inciso IV e VI):** Colaboradores cadastrados possuem visibilidade sobre suas competências atribuídas, histórico de alocações e responsabilidades através de suas respectivas interfaces.
* **Segurança e Prevenção (Inciso VII e VIII):** O sistema utiliza o framework Laravel 12, implementando proteção nativa contra *SQL Injection* (via PDO/Eloquent ORM), *Cross-Site Scripting* (XSS via Blade sanitization) e *Cross-Site Request Forgery* (CSRF Tokens).

---

## 3. Dados de Teste e Demonstração
- A massa de dados para testes de estresse e validação é gerada de forma puramente sintética e controlada por meio do `OfficialDataSeeder` (utilizando a biblioteca *Faker*).
- Nenhuma base de dados real ou dados de pessoas identificáveis são utilizados para fins de demonstração, homologação ou testes de carga.

---

## 4. Direitos dos Titulares (Art. 18 da LGPD)
O administrador da organização (Controlador) tem à disposição ferramentas para:
1. Confirmar a existência de tratamento dos dados de colaboradores.
2. Atualizar ou corrigir dados incompletos ou inexatos.
3. Anonimizar ou excluir registros de colaboradores e históricos de alocações caso não haja mais vínculo operacional com a organização.

---

*Para dúvidas ou orientações relacionadas à segurança e privacidade, consulte o arquivo [SECURITY.md](SECURITY.md).*

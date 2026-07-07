# dotProject-2025 Constitution

## Core Principles

### I. Laravel Convention First
Every feature must align with standard Laravel conventions (e.g. routing, controllers, Eloquent models, and DB migrations). Avoid custom helper files or structures where built-in Laravel equivalents exist. All PHP code must adhere to PSR-12/PER styling standards, enforced and styled via Laravel Pint.

### II. Test-Driven Development (TDD)
Specifications and test cases must be defined before the core implementation begins. Use PHPUnit to write both Feature (integration) and Unit tests. Every new feature must have at least 80% test coverage, and all existing tests must pass before code is merged.

### III. Database Integrity via Migrations
Direct database schema modifications (e.g. via DB clients on local or production) are strictly forbidden. Any changes to the database structure must be introduced via Laravel migrations. Ensure all migrations are reversible (using the `down` method or standard anonymous migration patterns).

### IV. Secure by Default
Strictly leverage Laravel's built-in security mechanisms. Every form/POST request must include CSRF protection. Direct user inputs must be sanitized and validated using custom Request classes. Use Eloquent or query builder bindings to prevent SQL Injection. Enforce access control via Laravel Gates and Policies.

### V. High Observability and Logging
Use Laravel's standard Log facade to output structured and meaningful logs. Include relevant context (e.g., user IDs, event names) inside context arrays rather than raw string concatenation. Keep production logs clean of debug spam.

## Architectural Constraints

- **Language**: PHP ^8.2
- **Framework**: Laravel ^12.0
- **Database**: SQLite (default local) / PostgreSQL (production compatibility). Migrations must be database-agnostic.
- **Frontend Stack**: Tailwind/Vite, Vanilla CSS, modern HTML5, and clean JS logic. Keep components reusable and semantic.
- **Dependency Management**: Composer for backend packages; NPM for frontend packages. Do not commit `vendor/` or `node_modules/`.

## Development Workflow

- **Specification**: Define requirements in a feature-specific directory under `specs/` (e.g., `specs/001-user-auth/spec.md`) using `/speckit-specify`.
- **Clarification**: Ask targeted clarification questions and document answers before planning.
- **Planning**: Create a detailed `implementation_plan.md` using `/speckit-plan`.
- **Task List**: Break the plan into granular, dependency-ordered tasks in `task.md` using `/speckit-tasks`.
- **Implementation**: Execute the plan using `/speckit-implement`, ensuring tests are written and pass.

## Governance

- This constitution serves as the source of truth for repository structure and code quality.
- Any modifications or amendments to this constitution must be made through consensus and a Pull Request, incrementing the version accordingly:
  - MAJOR: Removal of core principles or major workflow shifts.
  - MINOR: Additions of new principles/constraints.
  - PATCH: Clarifications, phrasing improvements, typo fixes.

**Version**: 1.0.0 | **Ratified**: 2026-06-22 | **Last Amended**: 2026-06-22

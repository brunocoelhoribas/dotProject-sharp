# Research Notes: Cascading Project Delete

## Chosen Decision
Use Eloquent model events via the `booted` method in the `Project` model, catching the `deleting` event.

## Rationale
- **Encapsulation**: Deletion logic is kept within the model layer rather than leaking into controllers or service classes.
- **Dry/Reusability**: No matter if a project is deleted in a controller, a console command, a database seeder, or during tests, the cascade will always be triggered automatically.
- **Safety**: Running the deletes of related items inside the event callback ensures they are removed before the project itself is deleted.

## Alternatives Considered
- **Database level cascades (`ON DELETE CASCADE`)**:
  - *Why rejected*: Modifying all existing tables to have foreign keys with `ON DELETE CASCADE` would require a large set of migrations, which is risky for a legacy table structure.
- **Controller-level manual deletion**:
  - *Why rejected*: Code duplication if we need to delete projects from seeders, test setup, or custom CLI commands. High risk of missing new tables.

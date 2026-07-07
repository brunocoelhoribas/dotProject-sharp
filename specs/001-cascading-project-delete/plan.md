# Implementation Plan: Cascading Project Delete

**Branch**: `001-cascading-project-delete` | **Date**: 2026-06-22 | **Spec**: [spec.md](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/specs/001-cascading-project-delete/spec.md)

**Input**: Feature specification from `/specs/001-cascading-project-delete/spec.md`

## Summary

When deleting a project, we need to cascade the deletion to all its related models to prevent orphaned records in the database.
We will hook into the Eloquent model lifecycle events on the `Project` model. When the `deleting` event is fired, we will find and delete all associated tasks, WBS items, risks, acquisitions, communications, quality plannings, initiating charter, and project minutes.
This entire operation will be wrapped in a database transaction to ensure rollback on failure.

## Technical Context

**Language/Version**: PHP 8.2+

**Primary Dependencies**: Laravel Framework 12.x

**Storage**: MySQL (local/production) & SQLite (testing)

**Testing**: PHPUnit

**Target Platform**: Web Server

**Project Type**: web-service

**Performance Goals**: Delete completes under 1 second.

**Constraints**: All related entities deleted inside a transaction.

**Scale/Scope**: Cleans up tables: `dotp_tasks`, `dotp_tasks_workpackages`, `dotp_project_wbs_items`, `dotp_risks`, `dotp_acquisitions`, `dotp_communications`, `dotp_quality_plannings`, `dotp_initiating`, `dotp_initiating_stakeholders`, `dotp_project_minutes`, `dotp_project_minute_members`.

## Constitution Check

- **Laravel Convention First**: Yes. Using Eloquent model events/observers is the standard way in Laravel to handle cascading deletes.
- **TDD (Test-First)**: Yes. We will write feature tests to verify the cascading delete functionality.
- **Database Integrity via Migrations**: Yes. The database schema already exists; we are cleaning up records.
- **Secure by Default**: Yes. Ensure the transaction prevents partial deletions.

## Project Structure

### Documentation (this feature)

```text
specs/001-cascading-project-delete/
├── spec.md              # Feature specification
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
└── quickstart.md        # Phase 1 output
```

### Source Code (repository root)

```text
app/
├── Models/
│   └── Project/
│       └── Project.php    # Hooking deleting model boot event
└── Http/
    └── Controllers/
        └── Project/
            └── ProjectController.php  # Transaction wrapping inside destroy

tests/
└── Feature/
    └── ProjectDeleteTest.php  # Tests verifying cascading delete
```

**Structure Decision**: Single Laravel application.

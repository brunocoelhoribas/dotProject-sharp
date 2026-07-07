# Tasks: Cascading Project Delete

**Input**: Design documents from `/specs/001-cascading-project-delete/`

**Prerequisites**: plan.md (required), spec.md (required)

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2)
- Include exact file paths in descriptions

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [x] T001 Verify project environment is ready by running tests in tests/Feature/ExampleTest.php

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core model modifications that all stories depend on

- [x] T002 Update relationship definitions in app/Models/Project/Project.php to support dependent entities (initiating, wbsItems, risks, acquisitions, communications, quality)

---

## Phase 3: User Story 1 - Clean Project Deletion (Priority: P1) 🎯 MVP

**Goal**: Delete a project along with all its dependent resources (tasks, risks, communications, acquisitions, quality plans, stakeholders, minutes, WBS items) to prevent database orphans.

**Independent Test**: Seed a project with all dependent resources, delete the project, and check that no related records remain in the database.

### Tests for User Story 1

- [x] T003 [P] [US1] Create project cascading delete feature test in tests/Feature/ProjectDeleteTest.php

### Implementation for User Story 1

- [x] T004 [US1] Register Eloquent `deleting` model event on Project model in app/Models/Project/Project.php
- [x] T005 [US1] Implement cascading delete for tasks and task workpackages pivot in app/Models/Project/Project.php
- [x] T006 [US1] Implement cascading delete for WBS items, risks, and acquisitions in app/Models/Project/Project.php
- [x] T007 [US1] Implement cascading delete for communications, quality planning, and initiating stakeholders in app/Models/Project/Project.php
- [x] T008 [US1] Implement cascading delete for project minutes and pivot members in app/Models/Project/Project.php

---

## Phase 4: User Story 2 - Transactional Safety (Priority: P2)

**Goal**: Guarantee all deletes roll back if any query fails during project removal.

**Independent Test**: Simulate database failure on deleting related records and assert project is not deleted.

### Tests for User Story 2

- [x] T009 [P] [US2] Add transactional safety test case in tests/Feature/ProjectDeleteTest.php

### Implementation for User Story 2

- [x] T010 [US2] Wrap project delete in DB transaction within destroy method in app/Http/Controllers/Project/ProjectController.php

---

## Phase 5: Polish & Cross-Cutting Concerns

**Purpose**: Verification and documentation

- [x] T011 Update project documentation in README_SPECKIT.md to note the cascading project delete behavior
- [x] T012 Run all verification tests with `php artisan test --filter=ProjectDeleteTest`

---

## Dependencies & Execution Order

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion
- **User Stories (Phase 3+)**: All depend on Foundational completion
- **Polish (Final Phase)**: Depends on all user stories being complete

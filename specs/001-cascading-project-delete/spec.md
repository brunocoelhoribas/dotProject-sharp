# Feature Specification: Cascading Project Delete

**Feature Branch**: `001-cascading-project-delete`

**Created**: 2026-06-22

**Status**: Draft

**Input**: User description: "Implement cascading delete logic when a project is removed, ensuring all dependent resources (tasks, risks, communications, acquisitions, quality plans, stakeholders, minutes, WBS items) are also deleted to prevent database orphans."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Clean Project Deletion (Priority: P1)

When a project manager deletes an existing project, all related planning, execution, and initiating assets must be cleanly removed from the database, leaving no orphan records.

**Why this priority**: Preventing database bloat and maintaining database integrity are critical. Orphaned records can cause foreign key violations, page loading crashes, and general instability.

**Independent Test**: Can be tested by creating a dummy project with WBS items, tasks, risks, communications, and minutes, deleting it, and asserting that database tables no longer contain any of these items.

**Acceptance Scenarios**:

1. **Given** a project with ID 42 exists and contains 3 tasks, 2 risks, and 1 project minute, **When** a delete request is sent for project 42, **Then** project 42 is deleted, and its tasks, risks, and minutes are also deleted from the database.

---

### User Story 2 - Transactional Safety (Priority: P2)

If any error occurs during the deletion of a project or its related resources, the entire operation must roll back, ensuring the project and all its related items remain intact.

**Why this priority**: A partial deletion leaves the database in an inconsistent state, where a project has lost some of its tasks or plans but still exists.

**Independent Test**: Triggering a deletion while injecting an database exception and verifying that the project and all relations still exist.

**Acceptance Scenarios**:

1. **Given** a project with ID 43 and related resources exists, **When** a deletion is attempted but database fails to delete task records, **Then** the deletion is rolled back, and the project and all its tasks and risks remain completely intact.

---

### Edge Cases

- **Project with no related entities**: The deletion must still succeed without throwing empty query errors or null pointer exceptions.
- **Cascading deletion of Pivot Tables**: Pivot tables such as `dotp_project_contacts` and `dotp_project_departments` must have their associations removed without deleting the actual contacts or departments themselves.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: When a project is deleted, all its related `dotp_tasks` must be deleted.
- **FR-002**: When a task is deleted, its pivot entries in `dotp_tasks_workpackages` must be deleted.
- **FR-003**: All WBS items (`dotp_project_wbs_items`) related to the project must be deleted.
- **FR-004**: All project risks (`dotp_risks`), acquisitions (`dotp_acquisitions`), communications (`dotp_communications`), and quality plans (`dotp_quality_plannings`) must be deleted.
- **FR-005**: The related initiating charter (`dotp_initiating`) and all its stakeholders (`dotp_initiating_stakeholders`) must be deleted.
- **FR-006**: All project minutes (`dotp_project_minutes`) and their member associations must be deleted.
- **FR-007**: The entire deletion process MUST run inside a single database transaction.

### Key Entities *(include if feature involves data)*

- **Project**: Represents the project entity being deleted.
- **Dependent Entities**: Tasks, WBS items, Risks, Acquisitions, Communications, Quality plans, Project Minutes, and Initiating Charter.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of related database records in dependent tables are deleted when a project is removed.
- **SC-002**: Project deletion completes in under 1 second for a project containing up to 100 tasks and related entities.

## Assumptions

- We will implement this cascading delete logic via Eloquent model events (specifically, the `deleting` boot event on the `Project` model) or directly inside the `destroy` method of `ProjectController`. Since some entities might be deleted using query builder, a clean and robust approach is using Eloquent `deleting` model boot event or explicitly doing it inside a database transaction in the controller/service.
- Actual users (owners) or companies associated with the project must NOT be deleted.

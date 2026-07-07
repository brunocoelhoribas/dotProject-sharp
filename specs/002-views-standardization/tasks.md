# Tasks: Views Standardization & Responsiveness

**Input**: Design documents from `/specs/002-views-standardization/`

**Prerequisites**: plan.md (required), spec.md (required for user stories)

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Style system configuration

- [ ] T001 Configure design token variables and add media-query-aware joined form styles in `public/css/custom.css`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Base layout structure verification

- [ ] T002 [P] Verify viewport meta tag and Inter font import in `resources/views/layouts/app.blade.php`
- [ ] T003 [P] Standardize container margins and footer styling in `resources/views/dashboard.blade.php`

---

## Phase 3: User Story 1 - Unified Responsive Layout & Navigation (Priority: P1) 🎯 MVP

**Goal**: Fully responsive application header, navbar, footer, and login/splash screens.

**Independent Test**: Navigate through all main views on a mobile phone simulator. Ensure navbar collapses, dropdowns align correctly, and no header elements overflow the screen width.

### Implementation for User Story 1

- [ ] T004 [US1] Implement collapsible hamburger navigation bar menu in `resources/views/dashboard.blade.php`
- [ ] T005 [P] [US1] Modernize layout container and form fields in `resources/views/auth/login.blade.php`
- [ ] T006 [P] [US1] Make login and main splash elements fully responsive in `resources/views/welcome.blade.php`

---

## Phase 4: User Story 2 - Standardized Directory & Listing Tables (Priority: P1)

**Goal**: Responsive, scroll-wrap directories for companies, projects, and costs.

**Independent Test**: Load the Companies, Projects, and Costs listing pages on a mobile viewport. Ensure search bars wrap vertically and data tables are wrapped in scroll containers.

### Implementation for User Story 2

- [ ] T007 [US2] Wrap company directory listing table in `.table-responsive` and make filters responsive in `resources/views/companies/index.blade.php`
- [ ] T008 [US2] Wrap project directory listing table in `.table-responsive` and standardize table status badges in `resources/views/projects/index.blade.php`
- [ ] T009 [P] [US2] Add responsive table layout and card structures in `resources/views/costs/index.blade.php`

---

## Phase 5: User Story 3 - Responsive Forms, Input Groups & Modals (Priority: P2)

**Goal**: Forms and modals that adapt nicely to mobile viewports.

**Independent Test**: Open Company/Project edit forms and task/budget creation modals on mobile. Verify labels stack vertically and inputs take up 100% of the viewport width.

### Implementation for User Story 3

- [ ] T010 [US3] Refactor Company input fields and label structures in `resources/views/companies/form.blade.php`
- [ ] T011 [US3] Refactor Project input fields and label structures in `resources/views/projects/create.blade.php` and `resources/views/projects/edit.blade.php`
- [ ] T012 [P] [US3] Standardize task modal widths and layouts in `resources/views/projects/planning/create_activity_modal.blade.php` and `resources/views/projects/planning/edit_activity_modal.blade.php`
- [ ] T013 [P] [US3] Standardize WBS and deletion confirmation modal designs in `resources/views/projects/planning/create_wbs_modal.blade.php` and `resources/views/projects/planning/delete_wbs_modal.blade.php`

---

## Phase 6: User Story 4 - Responsive Complex Matrices & Charts (Priority: P2)

**Goal**: Complex components (RACI, 9-Box, Organogram, Gantt) adapt gracefully on small/medium screens.

**Independent Test**: Open the 9-box performance matrix and RACI grid on mobile/tablet viewports. Verify components scroll horizontally and labels remain readable.

### Implementation for User Story 4

- [ ] T014 [US4] Remove hardcoded yellow table header styles and apply `.thead-dotproject` class in `resources/views/companies/human-resources/hr-tab.blade.php` and `resources/views/companies/organogram/organogram_tab.blade.php`
- [ ] T015 [US4] Remove hardcoded `#FFC107` header backgrounds in `resources/views/companies/human-resources/show.blade.php`
- [ ] T016 [US4] Wrap the 9-Box grid inside a scrollable `.nine-box-container` container in `resources/views/companies/human-resources/performance-matrix.blade.php`
- [ ] T017 [US4] Refactor Gantt layout to flex wrap on mobile screen sizes in `resources/views/projects/planning/tabs/schedule.blade.php`

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Verify style consistency and execute test suite regressions

- [ ] T018 Run the complete PHPUnit test suite to ensure zero regressions in view rendering or controllers
- [ ] T019 Conduct a manual visual check of all pages simulating mobile, tablet, and desktop screens

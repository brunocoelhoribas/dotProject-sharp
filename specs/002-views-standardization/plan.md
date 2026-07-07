# Implementation Plan: Views Standardization & Responsiveness

**Branch**: `002-views-standardization` | **Date**: 2026-06-22 | **Spec**: [spec.md](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/specs/002-views-standardization/spec.md)

## Summary

We will build a cohesive, modern visual standard and verify responsiveness across all views in the codebase.
The yellow/amber legacy visual identity will be modernized using a refined golden-amber color system with deep charcoal accents, soft slate table headers, and left border highlights for form labels.
Responsiveness on small viewports will be achieved using Bootstrap 5 fluid containers, responsive utility classes (`d-block d-md-flex`, etc.), custom media queries for legacy forms, and scroll wraps (`.table-responsive`, `.nine-box-container`) for complex grids.

## Technical Context

- **Language/Version**: PHP 8.5
- **Primary Dependencies**: Laravel 12, Bootstrap 5.3
- **Storage**: SQLite/MySQL (no storage changes)
- **Testing**: manual responsiveness check, lighthouse audit, PHPUnit regression check
- **Target Platform**: Responsive Web browsers (Chrome, Safari, Firefox, Edge)
- **Project Type**: Web Application views
- **Performance Goals**: Keep CSS payload under 15KB, fast UI render times (<100ms)
- **Constraints**: Maintain Bootstrap compatibility, do not break existing forms name bindings or controller mappings.

## Constitution Check

- **I. Laravel Convention First**: Standard Blade templates, Bootstrap 5 classes, and standard asset compilations are used.
- **II. Test-Driven Development (TDD)**: The existing functional/regression test suite must pass with 100% success.
- **III. Database Integrity via Migrations**: No database changes are required.
- **IV. Secure by Default**: CSRF and validation inputs are preserved intact.

## Proposed Changes

### 1. Global Layout & Design Tokens

Define the new modern gold-accented style variables and clean form wrappers in the central stylesheet.

#### [MODIFY] [custom.css](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/public/css/custom.css)
- Refine `--dp-tab-on` to a premium amber color (`#d97706`).
- Refine `--dp-tab-head` to a soft warm slate (`#f1f5f9`).
- Wrap the joined-paddings form style in `@media (min-width: 576px)` so that labels and inputs stack cleanly with appropriate border-radius on mobile screens.
- Enhance `.col-form-label` to use a left-border layout indicator (`border-left: 4px solid var(--dp-tab-on)`) and soft background (`#f1f5f9`) rather than a solid bright yellow background block on desktop.
- Add `.nine-box-container` horizontal scroll wrap rule for mobile screens.
- Implement soft animations on hover for links and action items.

#### [MODIFY] [app.blade.php](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/layouts/app.blade.php)
- Verify viewport meta tag exists.
- Ensure the main container wraps content correctly.

#### [MODIFY] [dashboard.blade.php](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/dashboard.blade.php)
- Modernize the navigation bar colors, using a dark premium aesthetic (`bg-dark`, shadow, golden logo color).
- Set layout container margins to align correctly on mobile and desktop viewports.

---

### 2. View Refactoring & Standardization

Update each view to remove hardcoded color styles, align layouts using Bootstrap grid/flexbox, and ensure tables scroll properly.

#### [MODIFY] [index.blade.php (Companies)](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/companies/index.blade.php)
- Replace yellow color text/badges with standard bootstrap/class-based styles.
- Add `.table-responsive` around the listing table.
- Wrap search and action buttons in a responsive flex row (`d-flex flex-column flex-md-row`).

#### [MODIFY] [show.blade.php (Companies)](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/companies/show.blade.php)
- Standardize metadata layout cards.
- Add responsive table wrappers for listing tabs.

#### [MODIFY] [hr-tab.blade.php (Companies HR)](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/companies/human-resources/hr-tab.blade.php)
- Remove hardcoded `#FFC107` header backgrounds and apply CSS classes (`thead-dotproject`).
- Clean up table row structures.

#### [MODIFY] [show.blade.php (Companies HR Detail)](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/companies/human-resources/show.blade.php)
- Remove hardcoded `#FFC107` header backgrounds on the cost tables.

#### [MODIFY] [organogram_tab.blade.php (Companies Organogram)](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/companies/organogram/organogram_tab.blade.php)
- Remove hardcoded `#FFC107` header backgrounds.

#### [MODIFY] [index.blade.php (Projects)](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/projects/index.blade.php)
- Standardize grid and table.
- Wrap lists in `.table-responsive`.

#### [MODIFY] [show.blade.php (Projects Detail)](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/projects/show.blade.php)
- Update detail layout panel and status icons.
- Ensure the project planning tabs align cleanly.

#### [MODIFY] [costs.blade.php (Project Costs)](file:///c:/Users/bruno/PhpstormProjects/dotproject-2025/resources/views/projects/planning/tabs/costs/costs.blade.php)
- Refactor the cost details forms and tables.

---

## Verification Plan

### Automated Tests
- Run existing unit and feature tests to ensure no view rendering regressions or route errors:
  ```bash
  vendor/bin/phpunit
  ```

### Manual Verification
- Deploy to local server and resize browser to simulate Mobile (iPhone SE, Pixel 7), Tablet (iPad Air), and Desktop screens.
- Verify forms, dropdowns, tables, and buttons render cleanly and do not overflow horizontally.

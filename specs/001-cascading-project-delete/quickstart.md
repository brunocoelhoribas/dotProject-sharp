# Quickstart: Cascading Project Delete Validation

This guide shows how to run validation tests to verify that deleting a project successfully cleans up all related resources.

## Runnable Verification

We will create a feature test `tests/Feature/ProjectDeleteTest.php` that performs the following steps:
1. Seed a project along with related:
   - WBS Items
   - Tasks
   - Risks
   - Acquisitions
   - Communications
   - Quality Plannings
   - Initiating Charter
   - Initiating Stakeholders
   - Project Minutes
2. Call the destroy route for the project: `DELETE /projects/{id}`
3. Assert a successful redirect response.
4. Assert that the project record and ALL related records are deleted from their respective database tables.
5. Assert that unrelated projects and resources are NOT affected.

## Execution Command

Run the test suite using:
```bash
php artisan test --filter=ProjectDeleteTest
```
All assertions should pass successfully.

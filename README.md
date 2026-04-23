# Project 2 — RECREATE THE BICLASS DATABASE STAR SCHEMA  
## Group Category: EOS_grp  
## Group Name: EOS_grp_2  

This folder contains our completed group project files for **Project 2 - RECREATE THE BICLASS DATABASE STAR SCHEMA**.

## Project Summary
In this project, we recreated the BIClass database star schema based on the professor’s instructions. The project includes the SQL Server database work, stored procedures, workflow tracking, and JDBC-based Java demo for execution and presentation.

## Included Files
This submission folder contains:

- SQL scripts for creating and loading the project database
- Java files for JDBC configuration and project demo UI
- BIClass framework backup file
- test and verification SQL files
- final project support and submission materials

## Work Completed
The following parts were completed and checked:

- recreated the BIClass star schema
- created the required database objects and workflow-related procedures
- created and tested load procedures
- created and tested the master load procedure
- checked final verification queries
- tested the JDBC connection
- tested the Java UI
- confirmed:
  - `LoadStarSchemaData` works
  - `Show Workflow Steps` works
  - `Show Fact Count` works

## JDBC / Java Demo
The Java demo is designed to connect to SQL Server and run the required procedures for Project 2.

### Database connection used
- SQL Server: `localhost:13001`
- Database: `G9_2`
- Login: `sa`

If needed, update the password in `DbConfig.java`.

## Main Java Files
- `DbConfig.java`
- `Project2DemoUI.java`

## Main SQL Files
- `01_create_G9_2.sql`
- `02_copy_source_tables.sql`
- `03_create_sequences.sql`
- `04_create_security_and_workflow.sql`
- `05_create_core_tables_from_BIClass.sql`
- `06_create_new_product_dimensions.sql`
- `07_create_foreign_keys.sql`
- `08_create_workflow_procedures.sql`
- `09_create_load_procedures_part1.sql`
- `10_create_load_procedures_part2.sql`
- `11_create_master_load_procedure.sql`
- `12_test_queries.sql`
- `13_final_verification.sql`

## Testing Status
This project was reviewed and tested from our side. The SQL and Java parts were checked, and the core required actions ran successfully.

## Submission Note
This folder is organized as our final project representation for submission.

## Contributor
**Amrina Qayyum**

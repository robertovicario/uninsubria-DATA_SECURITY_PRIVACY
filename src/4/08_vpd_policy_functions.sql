-- Task 4 - VPD policy functions
-- Run as CT_OWNER after app/1/01_create_schema.sql.

CREATE OR REPLACE FUNCTION vpd_studies_by_assignment(
  schema_var IN VARCHAR2,
  table_var  IN VARCHAR2
)
RETURN VARCHAR2
IS
BEGIN
  RETURN q'[
    EXISTS (
      SELECT 1
      FROM (
        SELECT a.study_id AS assigned_study_id,
               sm.username AS assigned_username
        FROM ct_owner.study_assignments a
        JOIN ct_owner.staff_members sm
          ON sm.staff_id = a.staff_id
      ) user_assignment
      WHERE assigned_username = SYS_CONTEXT('USERENV', 'SESSION_USER')
        AND assigned_study_id = study_id
    )
  ]';
END vpd_studies_by_assignment;
/

CREATE OR REPLACE FUNCTION vpd_participants_by_site(
  schema_var IN VARCHAR2,
  table_var  IN VARCHAR2
)
RETURN VARCHAR2
IS
BEGIN
  RETURN q'[
    EXISTS (
      SELECT 1
      FROM (
        SELECT a.study_id AS assigned_study_id,
               a.site_id AS assigned_site_id,
               a.assignment_role AS assigned_role,
               sm.username AS assigned_username
        FROM ct_owner.study_assignments a
        JOIN ct_owner.staff_members sm
          ON sm.staff_id = a.staff_id
      ) user_assignment
      WHERE assigned_username = SYS_CONTEXT('USERENV', 'SESSION_USER')
        AND assigned_study_id = study_id
        AND (
          assigned_site_id = site_id
          OR assigned_site_id IS NULL
          OR assigned_role IN ('PI', 'DATA_MANAGER', 'AUDITOR')
        )
        AND assigned_role IN ('PI', 'COORDINATOR', 'DATA_MANAGER', 'AUDITOR')
    )
  ]';
END vpd_participants_by_site;
/

CREATE OR REPLACE FUNCTION vpd_documents_by_assignment(
  schema_var IN VARCHAR2,
  table_var  IN VARCHAR2
)
RETURN VARCHAR2
IS
BEGIN
  RETURN q'[
    EXISTS (
      SELECT 1
      FROM (
        SELECT a.study_id AS assigned_study_id,
               a.site_id AS assigned_site_id,
               a.assignment_role AS assigned_role,
               sm.username AS assigned_username
        FROM ct_owner.study_assignments a
        JOIN ct_owner.staff_members sm
          ON sm.staff_id = a.staff_id
      ) user_assignment
      WHERE assigned_username = SYS_CONTEXT('USERENV', 'SESSION_USER')
        AND assigned_study_id = study_id
        AND (
          assigned_site_id = site_id
          OR site_id IS NULL
          OR assigned_site_id IS NULL
          OR assigned_role IN ('PI', 'DATA_MANAGER', 'REGULATORY_REVIEWER', 'AUDITOR', 'SPONSOR_VIEWER')
        )
        AND (
          assigned_role IN ('PI', 'DATA_MANAGER', 'AUDITOR')
          OR (assigned_role = 'COORDINATOR'
              AND document_type IN ('INFORMED_CONSENT', 'PROTOCOL'))
          OR (assigned_role = 'MONITOR'
              AND document_type = 'MONITORING_REPORT')
          OR (assigned_role = 'REGULATORY_REVIEWER'
              AND document_type IN ('REGULATORY_SUBMISSION', 'PROTOCOL', 'INFORMED_CONSENT'))
          OR (assigned_role = 'SPONSOR_VIEWER'
              AND document_type <> 'FINANCIAL_CONTRACT')
        )
    )
  ]';
END vpd_documents_by_assignment;
/

CREATE OR REPLACE FUNCTION vpd_events_by_assignment(
  schema_var IN VARCHAR2,
  table_var  IN VARCHAR2
)
RETURN VARCHAR2
IS
BEGIN
  RETURN q'[
    EXISTS (
      SELECT 1
      FROM (
        SELECT a.study_id AS assigned_study_id,
               a.assignment_role AS assigned_role,
               sm.username AS assigned_username
        FROM ct_owner.study_assignments a
        JOIN ct_owner.staff_members sm
          ON sm.staff_id = a.staff_id
      ) user_assignment
      WHERE assigned_username = SYS_CONTEXT('USERENV', 'SESSION_USER')
        AND assigned_study_id = study_id
        AND assigned_role IN ('PI', 'DATA_MANAGER', 'AUDITOR')
    )
  ]';
END vpd_events_by_assignment;
/

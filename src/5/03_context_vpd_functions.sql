-- Task 5 - VPD policy functions using CT_APP_CTX
-- Run as CT_OWNER after app/5/01_context_package.sql and app/5/02_create_context_and_logon_trigger.sql.

CREATE OR REPLACE FUNCTION ctx_vpd_studies_by_assignment(
  schema_var IN VARCHAR2,
  table_var  IN VARCHAR2
)
RETURN VARCHAR2
IS
BEGIN
  RETURN q'[
    EXISTS (
      SELECT 1
      FROM ct_owner.study_assignments a
      WHERE a.staff_id = TO_NUMBER(SYS_CONTEXT('CT_APP_CTX', 'STAFF_ID'))
        AND a.study_id = study_id
    )
  ]';
END ctx_vpd_studies_by_assignment;
/

CREATE OR REPLACE FUNCTION ctx_vpd_participants_by_site(
  schema_var IN VARCHAR2,
  table_var  IN VARCHAR2
)
RETURN VARCHAR2
IS
BEGIN
  RETURN q'[
    EXISTS (
      SELECT 1
      FROM ct_owner.study_assignments a
      WHERE a.staff_id = TO_NUMBER(SYS_CONTEXT('CT_APP_CTX', 'STAFF_ID'))
        AND a.study_id = study_id
        AND (
          a.site_id = site_id
          OR a.site_id IS NULL
          OR SYS_CONTEXT('CT_APP_CTX', 'JOB_ROLE') IN (
            'PRINCIPAL_INVESTIGATOR',
            'DATA_MANAGER',
            'QUALITY_AUDITOR'
          )
        )
        AND a.assignment_role IN ('PI', 'COORDINATOR', 'DATA_MANAGER', 'AUDITOR')
    )
  ]';
END ctx_vpd_participants_by_site;
/

CREATE OR REPLACE FUNCTION ctx_vpd_documents_by_assignment(
  schema_var IN VARCHAR2,
  table_var  IN VARCHAR2
)
RETURN VARCHAR2
IS
BEGIN
  RETURN q'[
    EXISTS (
      SELECT 1
      FROM ct_owner.study_assignments a
      WHERE a.staff_id = TO_NUMBER(SYS_CONTEXT('CT_APP_CTX', 'STAFF_ID'))
        AND a.study_id = study_id
        AND (
          a.site_id = site_id
          OR site_id IS NULL
          OR a.site_id IS NULL
          OR SYS_CONTEXT('CT_APP_CTX', 'JOB_ROLE') IN (
            'PRINCIPAL_INVESTIGATOR',
            'DATA_MANAGER',
            'REGULATORY_OFFICER',
            'QUALITY_AUDITOR',
            'SPONSOR_REPRESENTATIVE'
          )
        )
        AND (
          a.assignment_role IN ('PI', 'DATA_MANAGER', 'AUDITOR')
          OR (a.assignment_role = 'COORDINATOR'
              AND document_type IN ('INFORMED_CONSENT', 'PROTOCOL'))
          OR (a.assignment_role = 'MONITOR'
              AND document_type = 'MONITORING_REPORT')
          OR (a.assignment_role = 'REGULATORY_REVIEWER'
              AND document_type IN ('REGULATORY_SUBMISSION', 'PROTOCOL', 'INFORMED_CONSENT'))
          OR (a.assignment_role = 'SPONSOR_VIEWER'
              AND document_type <> 'FINANCIAL_CONTRACT')
        )
    )
  ]';
END ctx_vpd_documents_by_assignment;
/

CREATE OR REPLACE FUNCTION ctx_vpd_events_by_assignment(
  schema_var IN VARCHAR2,
  table_var  IN VARCHAR2
)
RETURN VARCHAR2
IS
BEGIN
  RETURN q'[
    EXISTS (
      SELECT 1
      FROM ct_owner.study_assignments a
      WHERE a.staff_id = TO_NUMBER(SYS_CONTEXT('CT_APP_CTX', 'STAFF_ID'))
        AND a.study_id = study_id
        AND a.assignment_role IN ('PI', 'DATA_MANAGER', 'AUDITOR')
        AND SYS_CONTEXT('CT_APP_CTX', 'CLEARANCE') = 'RESTRICTED'
    )
  ]';
END ctx_vpd_events_by_assignment;
/

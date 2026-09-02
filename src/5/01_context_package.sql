-- Task 5 - Application context package
-- Run as CT_OWNER after app/1/01_create_schema.sql.

CREATE OR REPLACE PACKAGE set_ct_ctx_pkg IS
  PROCEDURE set_context;
END set_ct_ctx_pkg;
/

CREATE OR REPLACE PACKAGE BODY set_ct_ctx_pkg IS
  PROCEDURE set_context
  IS
    v_username  staff_members.username%TYPE;
    v_staff_id  staff_members.staff_id%TYPE;
    v_job_role  staff_members.job_role%TYPE;
    v_region    staff_members.region%TYPE;
    v_clearance staff_members.clearance%TYPE;
  BEGIN
    v_username := SYS_CONTEXT('USERENV', 'SESSION_USER');

    SELECT staff_id, job_role, region, clearance
    INTO v_staff_id, v_job_role, v_region, v_clearance
    FROM staff_members
    WHERE username = v_username;

    DBMS_SESSION.SET_CONTEXT('CT_APP_CTX', 'USERNAME', v_username);
    DBMS_SESSION.SET_CONTEXT('CT_APP_CTX', 'STAFF_ID', TO_CHAR(v_staff_id));
    DBMS_SESSION.SET_CONTEXT('CT_APP_CTX', 'JOB_ROLE', v_job_role);
    DBMS_SESSION.SET_CONTEXT('CT_APP_CTX', 'REGION', v_region);
    DBMS_SESSION.SET_CONTEXT('CT_APP_CTX', 'CLEARANCE', v_clearance);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_SESSION.SET_CONTEXT('CT_APP_CTX', 'USERNAME', v_username);
      DBMS_SESSION.SET_CONTEXT('CT_APP_CTX', 'STAFF_ID', NULL);
      DBMS_SESSION.SET_CONTEXT('CT_APP_CTX', 'JOB_ROLE', 'UNMAPPED');
      DBMS_SESSION.SET_CONTEXT('CT_APP_CTX', 'REGION', 'NONE');
      DBMS_SESSION.SET_CONTEXT('CT_APP_CTX', 'CLEARANCE', 'PUBLIC');
  END set_context;
END set_ct_ctx_pkg;
/

GRANT EXECUTE ON set_ct_ctx_pkg TO PUBLIC;

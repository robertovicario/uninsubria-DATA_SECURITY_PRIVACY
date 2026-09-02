-- Task 5 - Application context and logon trigger
-- Run as ADMIN or another user with CREATE ANY CONTEXT and ADMINISTER DATABASE TRIGGER privileges.
-- Run app/5/01_context_package.sql first.

CREATE OR REPLACE CONTEXT ct_app_ctx USING ct_owner.set_ct_ctx_pkg;

CREATE OR REPLACE TRIGGER set_ct_ctx_after_logon
AFTER LOGON ON DATABASE
BEGIN
  IF ORA_LOGIN_USER LIKE 'CT\_%' ESCAPE '\' THEN
    ct_owner.set_ct_ctx_pkg.set_context;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/

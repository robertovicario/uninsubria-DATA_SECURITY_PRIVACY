-- Task 6 - Oracle Label Security policy container
-- Run as LBACSYS or as a user authorized to administer Oracle Label Security.

BEGIN
  SA_SYSDBA.DROP_POLICY(
    policy_name => 'CT_OLS_POL',
    drop_column => TRUE
  );
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE NOT IN (-12416, -12432) THEN RAISE; END IF;
END;
/

BEGIN
  SA_SYSDBA.CREATE_POLICY(
    policy_name     => 'CT_OLS_POL',
    column_name     => 'OLS_LABEL',
    default_options => 'READ_CONTROL'
  );
END;
/

EXEC SA_SYSDBA.ENABLE_POLICY('CT_OLS_POL');

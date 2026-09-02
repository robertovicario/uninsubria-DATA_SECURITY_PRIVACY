-- Task 6 - Apply OLS policy to sensitive tables
-- Run as a user with the CT_OLS_POL_DBA role enabled.

BEGIN
  SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
    policy_name  => 'CT_OLS_POL',
    schema_name  => 'CT_OWNER',
    table_name   => 'STUDIES',
    table_options => 'READ_CONTROL'
  );

  SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
    policy_name  => 'CT_OLS_POL',
    schema_name  => 'CT_OWNER',
    table_name   => 'PARTICIPANTS',
    table_options => 'READ_CONTROL'
  );

  SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
    policy_name  => 'CT_OLS_POL',
    schema_name  => 'CT_OWNER',
    table_name   => 'TRIAL_DOCUMENTS',
    table_options => 'READ_CONTROL'
  );

  SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
    policy_name  => 'CT_OLS_POL',
    schema_name  => 'CT_OWNER',
    table_name   => 'ADVERSE_EVENTS',
    table_options => 'READ_CONTROL'
  );
END;
/

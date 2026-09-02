-- Task 4 - Add VPD policies
-- Run as CT_OWNER, or as ADMIN if CT_OWNER does not have DBMS_RLS privileges.
-- Execute app/4/00_cleanup_vpd_policies.sql first when re-running.

BEGIN
  SYS.DBMS_RLS.ADD_POLICY(
    object_schema   => 'CT_OWNER',
    object_name     => 'STUDIES',
    policy_name     => 'VPD_STUDIES_BY_ASSIGNMENT',
    function_schema => 'CT_OWNER',
    policy_function => 'VPD_STUDIES_BY_ASSIGNMENT',
    statement_types => 'SELECT'
  );
END;
/

BEGIN
  SYS.DBMS_RLS.ADD_POLICY(
    object_schema   => 'CT_OWNER',
    object_name     => 'PARTICIPANTS',
    policy_name     => 'VPD_PARTICIPANTS_BY_SITE',
    function_schema => 'CT_OWNER',
    policy_function => 'VPD_PARTICIPANTS_BY_SITE',
    statement_types => 'SELECT'
  );
END;
/

BEGIN
  SYS.DBMS_RLS.ADD_POLICY(
    object_schema   => 'CT_OWNER',
    object_name     => 'TRIAL_DOCUMENTS',
    policy_name     => 'VPD_DOCUMENTS_BY_ASSIGNMENT',
    function_schema => 'CT_OWNER',
    policy_function => 'VPD_DOCUMENTS_BY_ASSIGNMENT',
    statement_types => 'SELECT'
  );
END;
/

BEGIN
  SYS.DBMS_RLS.ADD_POLICY(
    object_schema   => 'CT_OWNER',
    object_name     => 'ADVERSE_EVENTS',
    policy_name     => 'VPD_EVENTS_BY_ASSIGNMENT',
    function_schema => 'CT_OWNER',
    policy_function => 'VPD_EVENTS_BY_ASSIGNMENT',
    statement_types => 'SELECT'
  );
END;
/

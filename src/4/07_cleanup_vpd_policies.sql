-- Task 4 - Cleanup VPD policies
-- Run as CT_OWNER, or as ADMIN if CT_OWNER does not have DBMS_RLS privileges.

BEGIN
  SYS.DBMS_RLS.DROP_POLICY(
    object_schema => 'CT_OWNER',
    object_name   => 'STUDIES',
    policy_name   => 'VPD_STUDIES_BY_ASSIGNMENT'
  );
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE NOT IN (-28102, -28104) THEN RAISE; END IF;
END;
/

BEGIN
  SYS.DBMS_RLS.DROP_POLICY(
    object_schema => 'CT_OWNER',
    object_name   => 'PARTICIPANTS',
    policy_name   => 'VPD_PARTICIPANTS_BY_SITE'
  );
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE NOT IN (-28102, -28104) THEN RAISE; END IF;
END;
/

BEGIN
  SYS.DBMS_RLS.DROP_POLICY(
    object_schema => 'CT_OWNER',
    object_name   => 'TRIAL_DOCUMENTS',
    policy_name   => 'VPD_DOCUMENTS_BY_ASSIGNMENT'
  );
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE NOT IN (-28102, -28104) THEN RAISE; END IF;
END;
/

BEGIN
  SYS.DBMS_RLS.DROP_POLICY(
    object_schema => 'CT_OWNER',
    object_name   => 'ADVERSE_EVENTS',
    policy_name   => 'VPD_EVENTS_BY_ASSIGNMENT'
  );
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE NOT IN (-28102, -28104) THEN RAISE; END IF;
END;
/

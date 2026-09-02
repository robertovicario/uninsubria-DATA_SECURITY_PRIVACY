-- ==================================================
-- TASK 3: RBAC -- Inspection Queries
-- ==================================================

COLUMN role FORMAT A28
COLUMN grantee FORMAT A28
COLUMN granted_role FORMAT A28
COLUMN table_name FORMAT A38
COLUMN privilege FORMAT A10

SELECT role
FROM dba_roles
WHERE role LIKE 'CT\_%' ESCAPE '\'
ORDER BY role;

SELECT grantee, granted_role, admin_option
FROM dba_role_privs
WHERE grantee LIKE 'CT\_%' ESCAPE '\'
   OR granted_role LIKE 'CT\_%' ESCAPE '\'
ORDER BY grantee, granted_role;

SELECT grantee, table_name, privilege
FROM dba_tab_privs
WHERE owner = 'CT_OWNER'
    AND grantee LIKE 'CT\_%' ESCAPE '\'
ORDER BY grantee, table_name;

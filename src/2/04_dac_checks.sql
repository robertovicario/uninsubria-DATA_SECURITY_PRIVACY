-- ==================================================
-- Task 2: DAC Inspection Queries
-- ==================================================

COLUMN grantee     FORMAT A24
COLUMN table_name  FORMAT A34
COLUMN privilege   FORMAT A10

SELECT
    grantee,
    table_name,
    privilege,
    grantable
FROM user_tab_privs
WHERE table_name LIKE 'V\_%' ESCAPE '\'
ORDER BY
    table_name,
    grantee;

-- Task 5 - Application context and VPD checks

COLUMN namespace FORMAT A16
COLUMN schema FORMAT A16
COLUMN package FORMAT A32
COLUMN object_name FORMAT A24
COLUMN policy_name FORMAT A32
COLUMN function FORMAT A36

SELECT namespace, schema, package
FROM dba_context
WHERE namespace = 'CT_APP_CTX';

SELECT object_name, policy_name, function
FROM all_policies
WHERE object_owner = 'CT_OWNER'
ORDER BY object_name, policy_name;

-- Run these after connecting as an application user.
--
-- BEGIN
--   ct_owner.set_ct_ctx_pkg.set_context;
-- END;
-- /
--
-- SELECT SYS_CONTEXT('CT_APP_CTX', 'USERNAME') AS username,
--        SYS_CONTEXT('CT_APP_CTX', 'STAFF_ID') AS staff_id,
--        SYS_CONTEXT('CT_APP_CTX', 'JOB_ROLE') AS job_role,
--        SYS_CONTEXT('CT_APP_CTX', 'REGION') AS region,
--        SYS_CONTEXT('CT_APP_CTX', 'CLEARANCE') AS clearance
-- FROM dual;
--
-- SELECT * FROM ct_owner.studies;
-- SELECT * FROM ct_owner.trial_documents;

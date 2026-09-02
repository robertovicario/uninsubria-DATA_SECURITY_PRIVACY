-- Task 4 - VPD inspection and test queries

COLUMN object_owner FORMAT A16
COLUMN object_name FORMAT A24
COLUMN policy_name FORMAT A32
COLUMN pf_owner FORMAT A16
COLUMN package FORMAT A32
COLUMN function FORMAT A32

SELECT object_owner, object_name, policy_name, pf_owner, package, function
FROM all_policies
WHERE object_owner = 'CT_OWNER'
ORDER BY object_name, policy_name;

-- Example tests as application users:
--
-- CONNECT ct_coord_bianchi/"LabTask1_2026#"
-- SELECT study_id, site_id, subject_code FROM ct_owner.participants;
-- SELECT document_id, study_id, site_id, document_type FROM ct_owner.trial_documents;
--
-- CONNECT ct_cra_verdi/"LabTask1_2026#"
-- SELECT document_id, study_id, site_id, document_type FROM ct_owner.trial_documents;
--
-- CONNECT ct_sponsor_lila/"LabTask1_2026#"
-- SELECT document_id, study_id, document_type, approval_status FROM ct_owner.trial_documents;
--
-- CONNECT ct_auditor_gialli/"LabTask1_2026#"
-- SELECT event_id, study_id, severity, expectedness FROM ct_owner.adverse_events;

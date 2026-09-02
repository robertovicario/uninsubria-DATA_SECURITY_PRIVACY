-- Task 6 - Grants and OLS inspection queries
-- Run grants as CT_OWNER; run DBA_* queries with dictionary privileges.

GRANT SELECT ON studies TO
  ct_pi_rossi,
  ct_coord_bianchi,
  ct_cra_verdi,
  ct_data_neri,
  ct_reg_blu,
  ct_auditor_gialli,
  ct_sponsor_lila;

GRANT SELECT ON participants TO
  ct_pi_rossi,
  ct_coord_bianchi,
  ct_data_neri,
  ct_auditor_gialli;

GRANT SELECT ON trial_documents TO
  ct_pi_rossi,
  ct_coord_bianchi,
  ct_cra_verdi,
  ct_data_neri,
  ct_reg_blu,
  ct_auditor_gialli,
  ct_sponsor_lila;

GRANT SELECT ON adverse_events TO
  ct_pi_rossi,
  ct_data_neri,
  ct_auditor_gialli;

COLUMN policy_name FORMAT A16
COLUMN column_name FORMAT A16
COLUMN table_name FORMAT A24
COLUMN user_name FORMAT A24

SELECT policy_name, column_name, status
FROM all_sa_policies
WHERE policy_name = 'CT_OLS_POL';

SELECT policy_name, schema_name, table_name
FROM dba_sa_table_policies
WHERE policy_name = 'CT_OLS_POL'
ORDER BY table_name;

SELECT policy_name, user_name, max_read_label, min_write_label, def_label
FROM dba_sa_users
WHERE policy_name = 'CT_OLS_POL'
ORDER BY user_name;

-- Example tests:
--
-- CONNECT ct_reg_blu/"LabTask1_2026#"
-- SELECT document_id, document_type, classification FROM ct_owner.trial_documents;
--
-- CONNECT ct_auditor_gialli/"LabTask1_2026#"
-- SELECT document_id, document_type, classification FROM ct_owner.trial_documents;
-- SELECT event_id, severity, safety_label FROM ct_owner.adverse_events;

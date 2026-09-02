-- ==================================================
-- Task 2: DAC Policies
-- ==================================================

BEGIN
    FOR v IN (
        SELECT view_name
        FROM user_views
        WHERE view_name IN (
            'V_STUDY_PUBLIC_INFO',
            'V_PI_ROSSI_STUDIES',
            'V_COORD_BIANCHI_PARTICIPANTS',
            'V_CRA_VERDI_MONITORING_DOCS',
            'V_REG_BLU_SUBMISSIONS',
            'V_SPONSOR_LILA_NON_FINANCIAL_DOCS',
            'V_AUDITOR_GIALLI_SAFETY_EVENTS'
        )
    ) LOOP
        EXECUTE IMMEDIATE 'DROP VIEW ' || v.view_name;
    END LOOP;
END;
/

CREATE VIEW v_study_public_info AS
SELECT
    study_id,
    code,
    title,
    therapeutic_area,
    phase,
    sponsor,
    status,
    sensitivity_label
FROM studies;

GRANT SELECT
ON v_study_public_info
TO
    ct_pi_rossi,
    ct_coord_bianchi,
    ct_cra_verdi,
    ct_data_neri,
    ct_reg_blu,
    ct_auditor_gialli,
    ct_sponsor_lila;

CREATE VIEW v_pi_rossi_studies AS
SELECT
    s.study_id,
    s.code,
    s.title,
    s.therapeutic_area,
    s.phase,
    s.sponsor,
    s.principal_inv_id,
    s.budget_eur,
    s.status,
    s.sensitivity_label
FROM studies s
JOIN study_assignments a
    ON a.study_id = s.study_id
WHERE a.staff_id = 1
  AND a.assignment_role = 'PI';

GRANT SELECT
ON v_pi_rossi_studies
TO ct_pi_rossi;

CREATE VIEW v_coord_bianchi_participants AS
SELECT
    p.participant_id,
    p.study_id,
    p.site_id,
    p.subject_code,
    p.age_band,
    p.sex,
    p.enrollment_date,
    p.consent_status,
    p.randomization_group
FROM participants p
JOIN study_assignments a
    ON a.study_id = p.study_id
   AND a.site_id = p.site_id
WHERE a.staff_id = 2
  AND a.assignment_role = 'COORDINATOR';

GRANT SELECT
ON v_coord_bianchi_participants
TO ct_coord_bianchi;

CREATE VIEW v_cra_verdi_monitoring_docs AS
SELECT
    d.document_id,
    d.study_id,
    d.site_id,
    d.document_type,
    d.title,
    d.version_no,
    d.owner_staff_id,
    d.approval_status,
    d.classification,
    d.storage_uri
FROM trial_documents d
JOIN study_assignments a
    ON a.study_id = d.study_id
   AND a.site_id = d.site_id
WHERE a.staff_id = 3
  AND a.assignment_role = 'MONITOR'
  AND d.document_type = 'MONITORING_REPORT';

GRANT SELECT
ON v_cra_verdi_monitoring_docs
TO ct_cra_verdi;

CREATE VIEW v_reg_blu_submissions AS
SELECT
    d.document_id,
    d.study_id,
    d.document_type,
    d.title,
    d.version_no,
    d.owner_staff_id,
    d.approval_status,
    d.classification,
    d.storage_uri
FROM trial_documents d
JOIN study_assignments a
    ON a.study_id = d.study_id
WHERE a.staff_id = 5
  AND a.assignment_role = 'REGULATORY_REVIEWER'
  AND d.document_type IN (
        'REGULATORY_SUBMISSION',
        'PROTOCOL',
        'INFORMED_CONSENT'
    );

GRANT SELECT
ON v_reg_blu_submissions
TO ct_reg_blu;

CREATE VIEW v_sponsor_lila_non_financial_docs AS
SELECT
    d.document_id,
    d.study_id,
    d.site_id,
    d.document_type,
    d.title,
    d.version_no,
    d.approval_status,
    d.classification,
    d.storage_uri
FROM trial_documents d
JOIN study_assignments a
    ON a.study_id = d.study_id
WHERE a.staff_id = 7
  AND a.assignment_role = 'SPONSOR_VIEWER'
  AND d.document_type <> 'FINANCIAL_CONTRACT';

GRANT SELECT
ON v_sponsor_lila_non_financial_docs
TO ct_sponsor_lila;

CREATE VIEW v_auditor_gialli_safety_events AS
SELECT
    e.event_id,
    e.participant_id,
    e.study_id,
    e.reported_by,
    e.event_date,
    e.severity,
    e.expectedness,
    e.narrative,
    e.safety_label
FROM adverse_events e
JOIN study_assignments a
    ON a.study_id = e.study_id
WHERE a.staff_id = 6
  AND a.assignment_role = 'AUDITOR';

GRANT SELECT
ON v_auditor_gialli_safety_events
TO ct_auditor_gialli;

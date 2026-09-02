-- ==================================================
-- Task 3: RBAC Policies
-- ==================================================

BEGIN
    FOR r IN (
        SELECT role
        FROM dba_roles
        WHERE role IN (
            'CT_STUDY_READER',
            'CT_STUDY_OPERATOR',
            'CT_STUDY_COORDINATOR',
            'CT_STUDY_LEADER',
            'CT_MONITOR',
            'CT_COMPLIANCE_READER',
            'CT_REGULATORY_READER',
            'CT_AUDITOR',
            'CT_SPONSOR_READER'
        )
    ) LOOP
        EXECUTE IMMEDIATE 'DROP ROLE ' || r.role;
    END LOOP;
END;
/

CREATE ROLE ct_study_reader;
CREATE ROLE ct_study_operator;
CREATE ROLE ct_study_coordinator;
CREATE ROLE ct_study_leader;
CREATE ROLE ct_monitor;
CREATE ROLE ct_compliance_reader;
CREATE ROLE ct_regulatory_reader;
CREATE ROLE ct_auditor;
CREATE ROLE ct_sponsor_reader;

GRANT ct_study_reader       TO ct_study_operator;
GRANT ct_study_operator     TO ct_study_coordinator;
GRANT ct_study_operator     TO ct_study_leader;
GRANT ct_study_operator     TO ct_monitor;
GRANT ct_study_reader       TO ct_compliance_reader;
GRANT ct_compliance_reader  TO ct_regulatory_reader;
GRANT ct_compliance_reader  TO ct_auditor;
GRANT ct_study_reader       TO ct_sponsor_reader;

GRANT ct_study_leader       TO ct_pi_rossi;
GRANT ct_study_coordinator  TO ct_coord_bianchi;
GRANT ct_monitor            TO ct_cra_verdi;
GRANT ct_study_operator     TO ct_data_neri;
GRANT ct_regulatory_reader  TO ct_reg_blu;
GRANT ct_auditor            TO ct_auditor_gialli;
GRANT ct_sponsor_reader     TO ct_sponsor_lila;

GRANT SELECT ON v_study_public_info               TO ct_study_reader;
GRANT SELECT ON v_coord_bianchi_participants      TO ct_study_coordinator;
GRANT SELECT ON v_pi_rossi_studies                TO ct_study_leader;
GRANT SELECT ON v_cra_verdi_monitoring_docs       TO ct_monitor;
GRANT SELECT ON v_reg_blu_submissions             TO ct_regulatory_reader;
GRANT SELECT ON v_auditor_gialli_safety_events    TO ct_auditor;
GRANT SELECT ON v_sponsor_lila_non_financial_docs TO ct_sponsor_reader;

-- ==================================================
-- Task 1: Schema
-- ==================================================

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE adverse_events CASCADE CONSTRAINTS PURGE';

EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;

/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE trial_documents CASCADE CONSTRAINTS PURGE';

EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;

/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE participants CASCADE CONSTRAINTS PURGE';

EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;

/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE study_assignments CASCADE CONSTRAINTS PURGE';

EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;

/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE staff_members CASCADE CONSTRAINTS PURGE';

EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;

/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE sites CASCADE CONSTRAINTS PURGE';

EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;

/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE studies CASCADE CONSTRAINTS PURGE';

EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;

/
CREATE TABLE studies (

        study_id NUMBER (6) PRIMARY KEY,
        code VARCHAR2 (20) NOT NULL UNIQUE,
        title VARCHAR2 (160) NOT NULL,
        therapeutic_area VARCHAR2 (60) NOT NULL,
        phase VARCHAR2 (12) NOT NULL,
        sponsor VARCHAR2 (80) NOT NULL,
        principal_inv_id NUMBER (6),
        budget_eur NUMBER (12, 2) NOT NULL,
        status VARCHAR2 (20) NOT NULL,
        sensitivity_label VARCHAR2 (20) DEFAULT 'INTERNAL' NOT NULL,
        CONSTRAINT ck_studies_phase CHECK (phase IN ('I', 'II', 'III', 'IV')),
        CONSTRAINT ck_studies_status CHECK (
            status IN ('PLANNED', 'ACTIVE', 'SUSPENDED', 'CLOSED')
        ),
        CONSTRAINT ck_studies_label CHECK (
            sensitivity_label IN (
                'PUBLIC',
                'INTERNAL',
                'CONFIDENTIAL',
                'RESTRICTED'
            )
        )
    );

CREATE TABLE sites (

        site_id NUMBER (6) PRIMARY KEY,
        site_name VARCHAR2 (120) NOT NULL,
        country VARCHAR2 (40) NOT NULL,
        region VARCHAR2 (30) NOT NULL,
        lead_investigator VARCHAR2 (120) NOT NULL,
        contact_email VARCHAR2 (120) NOT NULL,
        CONSTRAINT ck_sites_region CHECK (region IN ('EU', 'US', 'APAC'))
    );

CREATE TABLE staff_members (

        staff_id NUMBER (6) PRIMARY KEY,
        username VARCHAR2 (30) NOT NULL UNIQUE,
        full_name VARCHAR2 (120) NOT NULL,
        job_role VARCHAR2 (40) NOT NULL,
        organization VARCHAR2 (80) NOT NULL,
        region VARCHAR2 (30) NOT NULL,
        clearance VARCHAR2 (20) DEFAULT 'INTERNAL' NOT NULL,
        CONSTRAINT ck_staff_role CHECK (
            job_role IN (
                'PRINCIPAL_INVESTIGATOR',
                'STUDY_COORDINATOR',
                'CLINICAL_RESEARCH_ASSOCIATE',
                'DATA_MANAGER',
                'REGULATORY_OFFICER',
                'SPONSOR_REPRESENTATIVE',
                'QUALITY_AUDITOR'
            )
        ),
        CONSTRAINT ck_staff_region CHECK (region IN ('EU', 'US', 'APAC', 'GLOBAL')),
        CONSTRAINT ck_staff_clearance CHECK (
            clearance IN (
                'PUBLIC',
                'INTERNAL',
                'CONFIDENTIAL',
                'RESTRICTED'
            )
        )
    );

ALTER TABLE studies ADD CONSTRAINT fk_studies_pi FOREIGN KEY (principal_inv_id) REFERENCES staff_members (staff_id);

CREATE TABLE study_assignments (

        assignment_id NUMBER (6) PRIMARY KEY,
        study_id NUMBER (6) NOT NULL,
        staff_id NUMBER (6) NOT NULL,
        site_id NUMBER (6),
        assignment_role VARCHAR2 (40) NOT NULL,
        start_date DATE NOT NULL,
        end_date DATE,
        CONSTRAINT fk_assign_study FOREIGN KEY (study_id) REFERENCES studies (study_id),
        CONSTRAINT fk_assign_staff FOREIGN KEY (staff_id) REFERENCES staff_members (staff_id),
        CONSTRAINT fk_assign_site FOREIGN KEY (site_id) REFERENCES sites (site_id),
        CONSTRAINT uq_assign_staff_study_role UNIQUE (study_id, staff_id, assignment_role),
        CONSTRAINT ck_assign_role CHECK (
            assignment_role IN (
                'PI',
                'COORDINATOR',
                'MONITOR',
                'DATA_MANAGER',
                'REGULATORY_REVIEWER',
                'SPONSOR_VIEWER',
                'AUDITOR'
            )
        )
    );

CREATE TABLE participants (

        participant_id NUMBER (8) PRIMARY KEY,
        study_id NUMBER (6) NOT NULL,
        site_id NUMBER (6) NOT NULL,
        subject_code VARCHAR2 (30) NOT NULL UNIQUE,
        age_band VARCHAR2 (10) NOT NULL,
        sex CHAR(1) NOT NULL,
        enrollment_date DATE NOT NULL,
        consent_status VARCHAR2 (20) NOT NULL,
        randomization_group VARCHAR2 (40),
        personal_data_label VARCHAR2 (20) DEFAULT 'RESTRICTED' NOT NULL,
        CONSTRAINT fk_part_study FOREIGN KEY (study_id) REFERENCES studies (study_id),
        CONSTRAINT fk_part_site FOREIGN KEY (site_id) REFERENCES sites (site_id),
        CONSTRAINT ck_part_sex CHECK (sex IN ('F', 'M', 'X')),
        CONSTRAINT ck_part_consent CHECK (
            consent_status IN ('SIGNED', 'WITHDRAWN', 'PENDING')
        ),
        CONSTRAINT ck_part_label CHECK (
            personal_data_label IN ('CONFIDENTIAL', 'RESTRICTED')
        )
    );

CREATE TABLE trial_documents (

        document_id NUMBER (8) PRIMARY KEY,
        study_id NUMBER (6) NOT NULL,
        site_id NUMBER (6),
        document_type VARCHAR2 (40) NOT NULL,
        title VARCHAR2 (160) NOT NULL,
        version_no VARCHAR2 (20) NOT NULL,
        owner_staff_id NUMBER (6) NOT NULL,
        approval_status VARCHAR2 (20) NOT NULL,
        classification VARCHAR2 (20) DEFAULT 'CONFIDENTIAL' NOT NULL,
        storage_uri VARCHAR2 (240) NOT NULL,
        CONSTRAINT fk_doc_study FOREIGN KEY (study_id) REFERENCES studies (study_id),
        CONSTRAINT fk_doc_site FOREIGN KEY (site_id) REFERENCES sites (site_id),
        CONSTRAINT fk_doc_owner FOREIGN KEY (owner_staff_id) REFERENCES staff_members (staff_id),
        CONSTRAINT ck_doc_type CHECK (
            document_type IN (
                'PROTOCOL',
                'INFORMED_CONSENT',
                'MONITORING_REPORT',
                'SAFETY_REPORT',
                'REGULATORY_SUBMISSION',
                'FINANCIAL_CONTRACT'
            )
        ),
        CONSTRAINT ck_doc_status CHECK (
            approval_status IN ('DRAFT', 'UNDER_REVIEW', 'APPROVED', 'ARCHIVED')
        ),
        CONSTRAINT ck_doc_class CHECK (
            classification IN (
                'PUBLIC',
                'INTERNAL',
                'CONFIDENTIAL',
                'RESTRICTED'
            )
        )
    );

CREATE TABLE adverse_events (

        event_id NUMBER (8) PRIMARY KEY,
        participant_id NUMBER (8) NOT NULL,
        study_id NUMBER (6) NOT NULL,
        reported_by NUMBER (6) NOT NULL,
        event_date DATE NOT NULL,
        severity VARCHAR2 (20) NOT NULL,
        expectedness VARCHAR2 (20) NOT NULL,
        narrative VARCHAR2 (500) NOT NULL,
        safety_label VARCHAR2 (20) DEFAULT 'RESTRICTED' NOT NULL,
        CONSTRAINT fk_event_part FOREIGN KEY (participant_id) REFERENCES participants (participant_id),
        CONSTRAINT fk_event_study FOREIGN KEY (study_id) REFERENCES studies (study_id),
        CONSTRAINT fk_event_reporter FOREIGN KEY (reported_by) REFERENCES staff_members (staff_id),
        CONSTRAINT ck_event_severity CHECK (
            severity IN ('MILD', 'MODERATE', 'SEVERE', 'LIFE_THREATENING')
        ),
        CONSTRAINT ck_event_expectedness CHECK (expectedness IN ('EXPECTED', 'UNEXPECTED')),
        CONSTRAINT ck_event_label CHECK (safety_label IN ('CONFIDENTIAL', 'RESTRICTED'))
    );

INSERT INTO staff_members
VALUES (

        1,
        'CT_PI_ROSSI',
        'Anna Rossi',
        'PRINCIPAL_INVESTIGATOR',
        'University Hospital Milan',
        'EU',
        'RESTRICTED'
    );

INSERT INTO staff_members
VALUES (

        2,
        'CT_COORD_BIANCHI',
        'Luca Bianchi',
        'STUDY_COORDINATOR',
        'University Hospital Milan',
        'EU',
        'CONFIDENTIAL'
    );

INSERT INTO staff_members
VALUES (

        3,
        'CT_CRA_VERDI',
        'Marta Verdi',
        'CLINICAL_RESEARCH_ASSOCIATE',
        'CRO Northwind',
        'EU',
        'CONFIDENTIAL'
    );

INSERT INTO staff_members
VALUES (

        4,
        'CT_DATA_NERI',
        'Paolo Neri',
        'DATA_MANAGER',
        'TrialData Services',
        'GLOBAL',
        'RESTRICTED'
    );

INSERT INTO staff_members
VALUES (

        5,
        'CT_REG_BLU',
        'Giulia Blu',
        'REGULATORY_OFFICER',
        'Regulatory Affairs EU',
        'EU',
        'RESTRICTED'
    );

INSERT INTO staff_members
VALUES (

        6,
        'CT_AUDITOR_GIALLI',
        'Marco Gialli',
        'QUALITY_AUDITOR',
        'Independent QA Board',
        'GLOBAL',
        'RESTRICTED'
    );

INSERT INTO staff_members
VALUES (

        7,
        'CT_SPONSOR_LILA',
        'Sara Lila',
        'SPONSOR_REPRESENTATIVE',
        'BioFuture Pharma',
        'GLOBAL',
        'CONFIDENTIAL'
    );

INSERT INTO studies
VALUES (

        101,
        'BF-CARD-301',
        'CardioSafe phase III cardiovascular outcomes trial',
        'Cardiology',
        'III',
        'BioFuture Pharma',
        1,
        1850000,
        'ACTIVE',
        'CONFIDENTIAL'
    );

INSERT INTO studies
VALUES (

        102,
        'BF-ONC-210',
        'OncoNova dose escalation study',
        'Oncology',
        'II',
        'BioFuture Pharma',
        1,
        940000,
        'PLANNED',
        'RESTRICTED'
    );

INSERT INTO studies
VALUES (

        103,
        'BF-VAX-410',
        'Respiratory vaccine follow-up registry',
        'Immunology',
        'IV',
        'BioFuture Pharma',
        1,
        420000,
        'ACTIVE',
        'INTERNAL'
    );

INSERT INTO sites
VALUES (

        201,
        'University Hospital Milan',
        'Italy',
        'EU',
        'Anna Rossi',
        'trial.milan@example.org'
    );

INSERT INTO sites
VALUES (

        202,
        'St. Anne Research Clinic',
        'Germany',
        'EU',
        'Erik Schneider',
        'trial.berlin@example.org'
    );

INSERT INTO sites
VALUES (

        203,
        'Pacific Clinical Center',
        'Singapore',
        'APAC',
        'Mei Tan',
        'trial.sg@example.org'
    );

INSERT INTO study_assignments
VALUES (
301, 101, 1, 201, 'PI', DATE '2026-01-10', NULL);

INSERT INTO study_assignments
VALUES (

        302,
        101,
        2,
        201,
        'COORDINATOR',
        DATE '2026-01-15',
        NULL
    );

INSERT INTO study_assignments
VALUES (

        303,
        101,
        3,
        202,
        'MONITOR',
        DATE '2026-02-01',
        NULL
    );

INSERT INTO study_assignments
VALUES (

        304,
        101,
        4,
        NULL,
        'DATA_MANAGER',
        DATE '2026-01-20',
        NULL
    );

INSERT INTO study_assignments
VALUES (

        305,
        102,
        5,
        NULL,
        'REGULATORY_REVIEWER',
        DATE '2026-03-01',
        NULL
    );

INSERT INTO study_assignments
VALUES (

        306,
        102,
        7,
        NULL,
        'SPONSOR_VIEWER',
        DATE '2026-03-01',
        NULL
    );

INSERT INTO study_assignments
VALUES (

        307,
        103,
        6,
        NULL,
        'AUDITOR',
        DATE '2026-02-15',
        NULL
    );

INSERT INTO participants
VALUES (

        1001,
        101,
        201,
        'BF-CARD-301-IT-0001',
        '45-64',
        'F',
        DATE '2026-02-03',
        'SIGNED',
        'ARM_A',
        'RESTRICTED'
    );

INSERT INTO participants
VALUES (

        1002,
        101,
        202,
        'BF-CARD-301-DE-0008',
        '65-74',
        'M',
        DATE '2026-02-12',
        'SIGNED',
        'ARM_B',
        'RESTRICTED'
    );

INSERT INTO participants
VALUES (

        1003,
        102,
        201,
        'BF-ONC-210-IT-0002',
        '35-44',
        'X',
        DATE '2026-04-08',
        'PENDING',
        NULL,
        'RESTRICTED'
    );

INSERT INTO participants
VALUES (

        1004,
        103,
        203,
        'BF-VAX-410-SG-0012',
        '25-34',
        'F',
        DATE '2026-03-18',
        'SIGNED',
        'OBSERVATIONAL',
        'CONFIDENTIAL'
    );

INSERT INTO trial_documents
VALUES (

        2001,
        101,
        NULL,
        'PROTOCOL',
        'BF-CARD-301 master protocol',
        '3.1',
        1,
        'APPROVED',
        'CONFIDENTIAL',
        '/docs/bf-card-301/protocol-v3.1.pdf'
    );

INSERT INTO trial_documents
VALUES (

        2002,
        101,
        201,
        'INFORMED_CONSENT',
        'Italian informed consent form',
        '2.0',
        2,
        'APPROVED',
        'CONFIDENTIAL',
        '/docs/bf-card-301/it-icf-v2.0.pdf'
    );

INSERT INTO trial_documents
VALUES (

        2003,
        101,
        202,
        'MONITORING_REPORT',
        'Berlin site monitoring visit 1',
        '1.0',
        3,
        'UNDER_REVIEW',
        'RESTRICTED',
        '/docs/bf-card-301/berlin-monitoring-01.pdf'
    );

INSERT INTO trial_documents
VALUES (

        2004,
        102,
        NULL,
        'REGULATORY_SUBMISSION',
        'OncoNova ethics package',
        '0.9',
        5,
        'DRAFT',
        'RESTRICTED',
        '/docs/bf-onc-210/ethics-package.pdf'
    );

INSERT INTO trial_documents
VALUES (

        2005,
        103,
        NULL,
        'SAFETY_REPORT',
        'Quarterly vaccine safety summary',
        '1.0',
        6,
        'APPROVED',
        'INTERNAL',
        '/docs/bf-vax-410/safety-q1.pdf'
    );

INSERT INTO trial_documents
VALUES (

        2006,
        101,
        NULL,
        'FINANCIAL_CONTRACT',
        'CRO monitoring service agreement',
        '1.2',
        7,
        'APPROVED',
        'RESTRICTED',
        '/docs/bf-card-301/cro-contract.pdf'
    );

INSERT INTO adverse_events
VALUES (

        3001,
        1001,
        101,
        2,
        DATE '2026-03-01',
        'MODERATE',
        'EXPECTED',
        'Transient dizziness after second administration; resolved without sequelae.',
        'RESTRICTED'
    );

INSERT INTO adverse_events
VALUES (

        3002,
        1002,
        101,
        3,
        DATE '2026-03-10',
        'SEVERE',
        'UNEXPECTED',
        'Hospitalization for arrhythmia; expedited safety review opened.',
        'RESTRICTED'
    );

INSERT INTO adverse_events
VALUES (

        3003,
        1004,
        103,
        6,
        DATE '2026-04-02',
        'MILD',
        'EXPECTED',
        'Injection-site pain reported during follow-up visit.',
        'CONFIDENTIAL'
    );

COMMIT;

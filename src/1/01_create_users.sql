-- ==================================================
-- Task 1: Users
-- ==================================================

CREATE USER ct_owner
    IDENTIFIED BY "LabTask1_2026#";

GRANT
    CREATE SESSION,
    CREATE TABLE,
    CREATE VIEW,
    CREATE SEQUENCE,
    CREATE PROCEDURE
TO ct_owner;

ALTER USER ct_owner
    QUOTA UNLIMITED ON DATA;

CREATE USER ct_pi_rossi
    IDENTIFIED BY "LabTask1_2026#";

CREATE USER ct_coord_bianchi
    IDENTIFIED BY "LabTask1_2026#";

CREATE USER ct_cra_verdi
    IDENTIFIED BY "LabTask1_2026#";

CREATE USER ct_data_neri
    IDENTIFIED BY "LabTask1_2026#";

CREATE USER ct_reg_blu
    IDENTIFIED BY "LabTask1_2026#";

CREATE USER ct_auditor_gialli
    IDENTIFIED BY "LabTask1_2026#";

CREATE USER ct_sponsor_lila
    IDENTIFIED BY "LabTask1_2026#";

GRANT CREATE SESSION TO
    ct_pi_rossi,
    ct_coord_bianchi,
    ct_cra_verdi,
    ct_data_neri,
    ct_reg_blu,
    ct_auditor_gialli,
    ct_sponsor_lila;

-- Task 4 - Base SELECT grants for VPD testing
-- Run as CT_OWNER after adding the VPD policies.

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

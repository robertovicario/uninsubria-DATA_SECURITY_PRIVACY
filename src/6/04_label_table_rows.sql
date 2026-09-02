-- Task 6 - Assign OLS labels to existing rows
-- Run as CT_OWNER after CT_OWNER receives FULL privilege on CT_OLS_POL.

UPDATE studies
SET ols_label =
  CASE sensitivity_label
    WHEN 'PUBLIC' THEN CHAR_TO_LABEL('CT_OLS_POL', 'P:CLIN')
    WHEN 'INTERNAL' THEN CHAR_TO_LABEL('CT_OLS_POL', 'I:CLIN')
    WHEN 'CONFIDENTIAL' THEN CHAR_TO_LABEL('CT_OLS_POL', 'C:CLIN')
    WHEN 'RESTRICTED' THEN CHAR_TO_LABEL('CT_OLS_POL', 'R:CLIN')
  END;

UPDATE participants
SET ols_label =
  CASE personal_data_label
    WHEN 'CONFIDENTIAL' THEN CHAR_TO_LABEL('CT_OLS_POL', 'C:CLIN')
    WHEN 'RESTRICTED' THEN CHAR_TO_LABEL('CT_OLS_POL', 'R:CLIN')
  END;

UPDATE trial_documents
SET ols_label =
  CASE
    WHEN document_type = 'FINANCIAL_CONTRACT'
      THEN CHAR_TO_LABEL('CT_OLS_POL', 'R:FIN')
    WHEN document_type = 'SAFETY_REPORT' AND classification = 'RESTRICTED'
      THEN CHAR_TO_LABEL('CT_OLS_POL', 'R:SAFE')
    WHEN document_type = 'SAFETY_REPORT'
      THEN CHAR_TO_LABEL('CT_OLS_POL', 'C:SAFE')
    WHEN document_type = 'REGULATORY_SUBMISSION' AND classification = 'RESTRICTED'
      THEN CHAR_TO_LABEL('CT_OLS_POL', 'R:REG')
    WHEN document_type = 'REGULATORY_SUBMISSION'
      THEN CHAR_TO_LABEL('CT_OLS_POL', 'C:REG')
    WHEN classification = 'PUBLIC'
      THEN CHAR_TO_LABEL('CT_OLS_POL', 'P:CLIN')
    WHEN classification = 'INTERNAL'
      THEN CHAR_TO_LABEL('CT_OLS_POL', 'I:CLIN')
    WHEN classification = 'CONFIDENTIAL'
      THEN CHAR_TO_LABEL('CT_OLS_POL', 'C:CLIN')
    WHEN classification = 'RESTRICTED'
      THEN CHAR_TO_LABEL('CT_OLS_POL', 'R:CLIN')
  END;

UPDATE adverse_events
SET ols_label =
  CASE safety_label
    WHEN 'CONFIDENTIAL' THEN CHAR_TO_LABEL('CT_OLS_POL', 'C:SAFE')
    WHEN 'RESTRICTED' THEN CHAR_TO_LABEL('CT_OLS_POL', 'R:SAFE')
  END;

COMMIT;

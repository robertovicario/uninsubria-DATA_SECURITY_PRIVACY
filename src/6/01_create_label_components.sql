-- Task 6 - OLS label components and data labels
-- Run as a user with the CT_OLS_POL_DBA role enabled.

BEGIN
  SA_COMPONENTS.CREATE_LEVEL(
    policy_name => 'CT_OLS_POL',
    level_num   => 1000,
    short_name  => 'P',
    long_name   => 'PUBLIC'
  );

  SA_COMPONENTS.CREATE_LEVEL(
    policy_name => 'CT_OLS_POL',
    level_num   => 2000,
    short_name  => 'I',
    long_name   => 'INTERNAL'
  );

  SA_COMPONENTS.CREATE_LEVEL(
    policy_name => 'CT_OLS_POL',
    level_num   => 3000,
    short_name  => 'C',
    long_name   => 'CONFIDENTIAL'
  );

  SA_COMPONENTS.CREATE_LEVEL(
    policy_name => 'CT_OLS_POL',
    level_num   => 4000,
    short_name  => 'R',
    long_name   => 'RESTRICTED'
  );
END;
/

BEGIN
  SA_COMPONENTS.CREATE_COMPARTMENT(
    policy_name => 'CT_OLS_POL',
    comp_num    => 10,
    short_name  => 'CLIN',
    long_name   => 'CLINICAL'
  );

  SA_COMPONENTS.CREATE_COMPARTMENT(
    policy_name => 'CT_OLS_POL',
    comp_num    => 20,
    short_name  => 'REG',
    long_name   => 'REGULATORY'
  );

  SA_COMPONENTS.CREATE_COMPARTMENT(
    policy_name => 'CT_OLS_POL',
    comp_num    => 30,
    short_name  => 'FIN',
    long_name   => 'FINANCIAL'
  );

  SA_COMPONENTS.CREATE_COMPARTMENT(
    policy_name => 'CT_OLS_POL',
    comp_num    => 40,
    short_name  => 'SAFE',
    long_name   => 'SAFETY'
  );
END;
/

BEGIN
  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'CT_OLS_POL',
    label_tag   => 1010,
    label_value => 'P:CLIN',
    data_label  => TRUE
  );

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'CT_OLS_POL',
    label_tag   => 2010,
    label_value => 'I:CLIN',
    data_label  => TRUE
  );

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'CT_OLS_POL',
    label_tag   => 3010,
    label_value => 'C:CLIN',
    data_label  => TRUE
  );

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'CT_OLS_POL',
    label_tag   => 4010,
    label_value => 'R:CLIN',
    data_label  => TRUE
  );

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'CT_OLS_POL',
    label_tag   => 3020,
    label_value => 'C:REG',
    data_label  => TRUE
  );

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'CT_OLS_POL',
    label_tag   => 4020,
    label_value => 'R:REG',
    data_label  => TRUE
  );

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'CT_OLS_POL',
    label_tag   => 4030,
    label_value => 'R:FIN',
    data_label  => TRUE
  );

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'CT_OLS_POL',
    label_tag   => 3040,
    label_value => 'C:SAFE',
    data_label  => TRUE
  );

  SA_LABEL_ADMIN.CREATE_LABEL(
    policy_name => 'CT_OLS_POL',
    label_tag   => 4040,
    label_value => 'R:SAFE',
    data_label  => TRUE
  );
END;
/

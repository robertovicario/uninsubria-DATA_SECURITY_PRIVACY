-- Task 6 - OLS user authorizations
-- Run as a user with the CT_OLS_POL_DBA role enabled.

BEGIN
  SA_USER_ADMIN.SET_LEVELS(
    policy_name => 'CT_OLS_POL',
    user_name   => 'CT_PI_ROSSI',
    max_level   => 'R',
    min_level   => 'P',
    def_level   => 'R',
    row_level   => 'R'
  );
  SA_USER_ADMIN.SET_COMPARTMENTS(
    policy_name  => 'CT_OLS_POL',
    user_name    => 'CT_PI_ROSSI',
    read_comps   => 'CLIN,REG,SAFE',
    write_comps  => 'CLIN,REG,SAFE',
    def_comps    => 'CLIN,REG,SAFE',
    row_comps    => 'CLIN'
  );

  SA_USER_ADMIN.SET_LEVELS(
    policy_name => 'CT_OLS_POL',
    user_name   => 'CT_COORD_BIANCHI',
    max_level   => 'C',
    min_level   => 'P',
    def_level   => 'C',
    row_level   => 'C'
  );
  SA_USER_ADMIN.SET_COMPARTMENTS(
    policy_name  => 'CT_OLS_POL',
    user_name    => 'CT_COORD_BIANCHI',
    read_comps   => 'CLIN',
    write_comps  => 'CLIN',
    def_comps    => 'CLIN',
    row_comps    => 'CLIN'
  );

  SA_USER_ADMIN.SET_LEVELS(
    policy_name => 'CT_OLS_POL',
    user_name   => 'CT_CRA_VERDI',
    max_level   => 'C',
    min_level   => 'P',
    def_level   => 'C',
    row_level   => 'C'
  );
  SA_USER_ADMIN.SET_COMPARTMENTS(
    policy_name  => 'CT_OLS_POL',
    user_name    => 'CT_CRA_VERDI',
    read_comps   => 'CLIN,SAFE',
    write_comps  => 'CLIN,SAFE',
    def_comps    => 'CLIN,SAFE',
    row_comps    => 'CLIN'
  );

  SA_USER_ADMIN.SET_LEVELS(
    policy_name => 'CT_OLS_POL',
    user_name   => 'CT_DATA_NERI',
    max_level   => 'R',
    min_level   => 'P',
    def_level   => 'R',
    row_level   => 'R'
  );
  SA_USER_ADMIN.SET_COMPARTMENTS(
    policy_name  => 'CT_OLS_POL',
    user_name    => 'CT_DATA_NERI',
    read_comps   => 'CLIN,SAFE',
    write_comps  => 'CLIN,SAFE',
    def_comps    => 'CLIN,SAFE',
    row_comps    => 'CLIN'
  );

  SA_USER_ADMIN.SET_LEVELS(
    policy_name => 'CT_OLS_POL',
    user_name   => 'CT_REG_BLU',
    max_level   => 'R',
    min_level   => 'P',
    def_level   => 'R',
    row_level   => 'R'
  );
  SA_USER_ADMIN.SET_COMPARTMENTS(
    policy_name  => 'CT_OLS_POL',
    user_name    => 'CT_REG_BLU',
    read_comps   => 'REG,CLIN',
    write_comps  => 'REG',
    def_comps    => 'REG,CLIN',
    row_comps    => 'REG'
  );

  SA_USER_ADMIN.SET_LEVELS(
    policy_name => 'CT_OLS_POL',
    user_name   => 'CT_AUDITOR_GIALLI',
    max_level   => 'R',
    min_level   => 'P',
    def_level   => 'R',
    row_level   => 'R'
  );
  SA_USER_ADMIN.SET_COMPARTMENTS(
    policy_name  => 'CT_OLS_POL',
    user_name    => 'CT_AUDITOR_GIALLI',
    read_comps   => 'CLIN,REG,FIN,SAFE',
    write_comps  => 'CLIN,REG,FIN,SAFE',
    def_comps    => 'CLIN,REG,FIN,SAFE',
    row_comps    => 'SAFE'
  );

  SA_USER_ADMIN.SET_LEVELS(
    policy_name => 'CT_OLS_POL',
    user_name   => 'CT_SPONSOR_LILA',
    max_level   => 'C',
    min_level   => 'P',
    def_level   => 'C',
    row_level   => 'C'
  );
  SA_USER_ADMIN.SET_COMPARTMENTS(
    policy_name  => 'CT_OLS_POL',
    user_name    => 'CT_SPONSOR_LILA',
    read_comps   => 'CLIN,REG',
    write_comps  => 'CLIN',
    def_comps    => 'CLIN,REG',
    row_comps    => 'CLIN'
  );

  SA_USER_ADMIN.SET_USER_PRIVS(
    policy_name => 'CT_OLS_POL',
    user_name   => 'CT_OWNER',
    privileges  => 'FULL'
  );
END;
/

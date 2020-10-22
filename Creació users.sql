
DROP USER IF EXISTS analytic_user;
DROP USER IF EXISTS manager_user;
DROP USER IF EXISTS rrhh_user;

CREATE USER analytic_user;
CREATE USER manager_user;
CREATE USER rrhh_user;

GRANT SELECT, CREATE VIEW, SHOW VIEW ON OLAP.* TO analytic_user;

GRANT ALL ON OLAP.* TO manager_user;
GRANT ALL ON OLTP.* TO manager_user;

GRANT CREATE USER ON *.* TO rrhh_user;



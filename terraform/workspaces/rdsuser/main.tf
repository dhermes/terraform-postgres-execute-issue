# NOTE: Simulate the RDS "master user" feature (which is not a superuser).
#       Based on the following query in a real RDS instance:
#
#       widgets=> SELECT * FROM pg_catalog.pg_roles WHERE rolname = 'rdsuser';
#        rolname | rolsuper | rolinherit | rolcreaterole | rolcreatedb | rolcanlogin | rolreplication | rolconnlimit | rolpassword | rolvaliduntil | rolbypassrls | rolconfig |  oid
#       ---------+----------+------------+---------------+-------------+-------------+----------------+--------------+-------------+---------------+--------------+-----------+-------
#        rdsuser | f        | t          | t             | t           | t           | f              |           -1 | ********    | infinity      | f            |           | 16393
#       (1 row)
resource "postgresql_role" "rdsuser_role" {
  provider = postgresql.repro

  name               = "rdsuser"
  password           = "testpassword_rdsuser" # WARNING!! This is very bad to do
  encrypted_password = true
  connection_limit   = -1

  superuser                 = false
  inherit                   = true
  create_role               = true
  create_database           = true
  login                     = true
  replication               = false
  bypass_row_level_security = false
}

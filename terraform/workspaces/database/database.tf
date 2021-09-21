resource "postgresql_database" "db" {
  provider = postgresql.repro

  name              = "repro"
  owner             = postgresql_role.admin_role.name
  template          = "template0"
  encoding          = "UTF8"
  lc_collate        = "en_US.UTF-8"
  lc_ctype          = "en_US.UTF-8"
  connection_limit  = -1
  allow_connections = true
}

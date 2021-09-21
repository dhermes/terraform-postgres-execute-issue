resource "postgresql_role" "admin_role" {
  provider = postgresql.repro

  name                = "repro_admin"
  password            = "abcd1234" # WARNING!! This is very bad to do
  login               = true
  encrypted_password  = true
  skip_reassign_owned = true
}

resource "postgresql_role" "app_role" {
  provider = postgresql.repro

  name                = "repro_app"
  password            = "1234abcd" # WARNING!! This is very bad to do
  login               = true
  encrypted_password  = true
  skip_reassign_owned = true
}

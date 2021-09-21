provider "postgresql" {
  alias     = "repro"
  host      = "127.0.0.1"
  port      = 16340
  database  = "superuser_db"
  username  = "rdsuser"
  password  = "testpassword_rdsuser"
  sslmode   = "disable"
  superuser = false
}

provider "postgresql" {
  alias     = "repro"
  host      = "127.0.0.1"
  port      = 16340
  database  = "superuser_db"
  username  = "superuser"
  password  = "testpassword_superuser"
  sslmode   = "disable"
  superuser = false
}

resource "postgresql_grant" "app_table_grant" {
  provider = postgresql.repro

  database    = postgresql_database.db.name
  role        = postgresql_role.app_role.name
  schema      = "public"
  object_type = "table"
  privileges  = ["SELECT", "DELETE", "INSERT", "UPDATE"]
}

resource "postgresql_grant" "app_seq_grant" {
  provider = postgresql.repro

  database    = postgresql_database.db.name
  role        = postgresql_role.app_role.name
  schema      = "public"
  object_type = "sequence"
  privileges  = ["SELECT", "UPDATE"]
}

resource "postgresql_grant" "app_function_grant" {
  provider = postgresql.repro

  database    = postgresql_database.db.name
  role        = postgresql_role.app_role.name
  schema      = "public"
  object_type = "function"
  privileges  = ["EXECUTE"]
}

resource "postgresql_default_privileges" "app_table_grant" {
  provider = postgresql.repro

  database    = postgresql_database.db.name
  role        = postgresql_role.app_role.name
  schema      = "public"
  owner       = postgresql_role.admin_role.name
  object_type = "table"
  privileges  = ["SELECT", "DELETE", "INSERT", "UPDATE"]
}

resource "postgresql_default_privileges" "app_seq_grant" {
  provider = postgresql.repro

  database    = postgresql_database.db.name
  role        = postgresql_role.app_role.name
  schema      = "public"
  owner       = postgresql_role.admin_role.name
  object_type = "sequence"
  privileges  = ["SELECT", "UPDATE"]
}

resource "postgresql_default_privileges" "app_function_grant" {
  provider = postgresql.repro

  database    = postgresql_database.db.name
  role        = postgresql_role.app_role.name
  schema      = "public"
  owner       = postgresql_role.admin_role.name
  object_type = "function"
  privileges  = ["EXECUTE"]
}

resource "postgresql_grant" "grant_application_schema_to_admin" {
  provider = postgresql.repro

  role        = postgresql_role.admin_role.name
  database    = postgresql_database.db.name
  schema      = "public"
  object_type = "schema"
  privileges  = ["USAGE", "CREATE"]
}

resource "postgresql_grant" "grant_application_schema_to_app" {
  provider = postgresql.repro

  role        = postgresql_role.app_role.name
  database    = postgresql_database.db.name
  schema      = "public"
  object_type = "schema"
  privileges  = ["USAGE"]
}

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

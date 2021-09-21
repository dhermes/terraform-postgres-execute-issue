# Attempt to Reproduce Terraform PostgreSQL Provider Issue

> Minimal Proof-of-Concept for an issue with `EXECUTE` grants with the
> `cyrilgdn/postgresql` Provider

## Ensure Image Exists

```
$ docker pull postgres:12.8-alpine3.14
```

## Start Up PostgreSQL in Docker

```
$ # Or `make start-container`
$ cd terraform/workspaces/docker/
$ terraform init
$ terraform apply
```

## Create `rdsuser` Role

```
$ # Or `make simulate-rds`
$ cd terraform/workspaces/rdsuser/
$ terraform init
$ terraform apply
```

## Create `repro_admin` and `repro_app` Roles

```
$ # Or `make initialize-database`
$ cd terraform/workspaces/database/
$ terraform init
$ terraform apply
```

## Ensure Connection Works

```
$ # Or `make psql-app`
$ psql "postgres://repro_app:1234abcd@localhost:16340/repro"
...
$ # Or `make psql-admin`
$ psql "postgres://repro_admin:abcd1234@localhost:16340/repro"
...
$ # Or `make psql-superuser`
$ psql "postgres://superuser:testpassword_superuser@localhost:16340/superuser_db"
...
```

## Remove Generated Resources

```
$ make clean
```

## Development

```
$ make  # Or `make help`
Makefile for `erraform-postgres-execute-issue` experiment

Usage:
   make clean                  Forcefully remove all generated artifacts (e.g. Terraform state files)
Terraform-specific Targets:
   make start-container        Start PostgreSQL Docker container.
   make stop-container         Stop PostgreSQL Docker container.
   make simulate-rds           Create a user to simulate the RDS master user.
   make initialize-database    Initialize the database, schema, roles and grants in the PostgreSQL instances
   make teardown-database      Teardown the database, schema, roles and grants in the PostgreSQL instances
Development Database-specific Targets:
   make psql-app               Connects to currently running PostgreSQL DB via `psql` as app user
   make psql-admin             Connects to currently running PostgreSQL DB via `psql` as admin user
   make psql-rdsuser           Connects to currently running PostgreSQL DB via `psql` as rdsuser
   make psql-superuser         Connects to currently running PostgreSQL DB via `psql` as superuser

```

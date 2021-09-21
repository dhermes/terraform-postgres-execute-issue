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

## Create `repro_admin` and `repro_app` Users

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

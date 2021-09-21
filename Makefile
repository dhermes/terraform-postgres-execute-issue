.PHONY: help
help:
	@echo 'Makefile for `erraform-postgres-execute-issue` experiment'
	@echo ''
	@echo 'Usage:'
	@echo '   make clean                  Forcefully remove all generated artifacts (e.g. Terraform state files)'
	@echo 'Terraform-specific Targets:'
	@echo '   make start-container        Start PostgreSQL Docker container.'
	@echo '   make stop-container         Stop PostgreSQL Docker container.'
	@echo '   make initialize-database    Initialize the database, schema, roles and grants in the PostgreSQL instances'
	@echo '   make teardown-database      Teardown the database, schema, roles and grants in the PostgreSQL instances'
	@echo 'Development Database-specific Targets:'
	@echo '   make psql-app               Connects to currently running PostgreSQL DB via `psql` as app user'
	@echo '   make psql-admin             Connects to currently running PostgreSQL DB via `psql` as admin user'
	@echo '   make psql-superuser         Connects to currently running PostgreSQL DB via `psql` as superuser'
	@echo ''

################################################################################
# Meta-variables
################################################################################
PSQL_PRESENT := $(shell command -v psql 2> /dev/null)

################################################################################
# Generic Targets
################################################################################

.PHONY: clean
clean:
	rm -f \
	  terraform/workspaces/database/.terraform.lock.hcl \
	  terraform/workspaces/database/terraform.tfstate \
	  terraform/workspaces/database/terraform.tfstate.backup \
	  terraform/workspaces/docker/.terraform.lock.hcl \
	  terraform/workspaces/docker/terraform.tfstate \
	  terraform/workspaces/docker/terraform.tfstate.backup
	rm -fr \
	  terraform/workspaces/database/.terraform/ \
	  terraform/workspaces/docker/.terraform/
	docker rm --force dev-postgres-repro
	docker network rm dev-network-repro || true

################################################################################
# Terraform-specific Targets
################################################################################

.PHONY: start-container
start-container:
	@cd terraform/workspaces/docker/ && \
	  terraform init && \
	  terraform apply --auto-approve

.PHONY: stop-container
stop-container:
	@cd terraform/workspaces/docker/ && \
	  terraform init && \
	  terraform apply --destroy --auto-approve

.PHONY: initialize-database
initialize-database:
	@cd terraform/workspaces/database/ && \
	  terraform init && \
	  terraform apply --auto-approve

.PHONY: teardown-database
teardown-database:
	@cd terraform/workspaces/database/ && \
	  terraform init && \
	  terraform apply --destroy --auto-approve

################################################################################
# Development Database-specific Targets
################################################################################

.PHONY: psql-app
psql-app: _require-psql
	psql "postgres://repro_app:1234abcd@localhost:16340/repro"

.PHONY: psql-admin
psql-admin: _require-psql
	psql "postgres://repro_admin:abcd1234@localhost:16340/repro"

.PHONY: psql-superuser
psql-superuser: _require-psql
	psql "postgres://superuser:testpassword_superuser@localhost:16340/superuser_db"

################################################################################
# Internal / Doctor Targets
################################################################################

.PHONY: _require-psql
_require-psql:
ifndef PSQL_PRESENT
	$(error 'psql is not installed, it can be installed via "brew install postgresql" or "apt-get install postgresql".')
endif

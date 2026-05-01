# Zylos Platform Infra — common operations.
# Run `make help` for the menu.

.PHONY: help fmt fmt-check validate lint bootstrap dev-init dev-plan dev-apply dev-destroy

ENV ?= dev

help:  ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*## ' $(MAKEFILE_LIST) | awk -F ':.*## ' '{printf "  %-20s %s\n", $$1, $$2}'

fmt:  ## Auto-format all Terraform files
	terraform fmt -recursive terraform/

fmt-check:  ## Verify formatting (fails if any file would change)
	terraform fmt -check -recursive terraform/

validate:  ## Validate every environment's Terraform configuration
	./scripts/lint.sh

lint: fmt-check validate  ## Full lint: format check + validation

bootstrap:  ## One-time: create the S3 state bucket
	./scripts/bootstrap-tfstate.sh

init:  ## terraform init for the chosen ENV (default: dev)
	./scripts/tf.sh $(ENV) init

plan:  ## terraform plan for the chosen ENV
	./scripts/tf.sh $(ENV) plan

apply:  ## terraform apply for the chosen ENV (will prompt for approval)
	./scripts/tf.sh $(ENV) apply

destroy:  ## terraform destroy for the chosen ENV (USE WITH CARE)
	./scripts/tf.sh $(ENV) destroy

dev-init:    ## Shortcut: init dev
	$(MAKE) ENV=dev init
dev-plan:    ## Shortcut: plan dev
	$(MAKE) ENV=dev plan
dev-apply:   ## Shortcut: apply dev
	$(MAKE) ENV=dev apply
dev-destroy: ## Shortcut: destroy dev
	$(MAKE) ENV=dev destroy

TERRAFORM_VERSION := 0.11.7
TERRAFORM_LOCATION := .tf
TERRAFORM_BINARY := $(CURDIR)/.tf/terraform

PLATFORM := $(shell uname | tr '[:upper:]' '[:lower:]')

# Download the correct terraform version
get-terraform:
	@curl -o tf_tmp.zip https://releases.hashicorp.com/terraform/$(TERRAFORM_VERSION)/terraform_$(TERRAFORM_VERSION)_$(PLATFORM)_amd64.zip
	@unzip -o -d .tf tf_tmp.zip
	@rm tf_tmp.zip

# Check if Terraform binary exists, otherwise download it
check-terraform-exists:
	@[ ! -f $(TERRAFORM_BINARY) ] && make -s get-terraform || true

# Default to QA env
ENV := qa

# Check the terraform version and download if it isn't up to date
tf-version: | check-terraform-exists
ifneq ($(shell $(TERRAFORM_BINARY) version | head -n 1 | cut -d " " -f2 | tr -d v), $(TERRAFORM_VERSION))
	@echo "Terraform version is out of date. Downloading correct version..."
	@make -s get-terraform
	@echo "Terraform binary updated"
else
	@echo "Terraform version is up to date..."
endif

# Terraform init to a specific environment (make init ENV=qa)
init: | tf-version
	@cd terraform/$(ENV) && $(TERRAFORM_BINARY) init

# Terraform plan to a specific environment (make plan ENV=qa)
plan: | tf-version
	@cd terraform/$(ENV) && $(TERRAFORM_BINARY) plan

# Apply terraform to a specific environment (make apply ENV=qa)
apply: | tf-version
	@cd terraform/$(ENV) && $(TERRAFORM_BINARY) apply

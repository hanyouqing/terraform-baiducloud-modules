.PHONY: help fmt fmt-check validate validate-prep validate-modules validate-examples lint docs clean list-modules

.DEFAULT_GOAL := help

help: ## Show this help message
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

fmt: ## Format all Terraform and Terragrunt HCL files
	@terraform fmt -recursive
	@if command -v terragrunt >/dev/null 2>&1; then \
		terragrunt hclfmt --working-dir terragrunt; \
	fi

fmt-check: ## Check formatting
	@terraform fmt -check -recursive
	@if command -v terragrunt >/dev/null 2>&1; then \
		terragrunt hclfmt --check --working-dir terragrunt; \
	fi

validate-prep: ## Ensure plugin cache dir exists
	@mkdir -p "$$HOME/.terraform.d/plugin-cache"

validate: validate-modules validate-examples ## Validate modules and examples

validate-modules: validate-prep ## Validate top-level modules
	@set -e; \
	for dir in */; do \
		dir=$${dir%/}; \
		[ -f "$$dir/main.tf" ] || continue; \
		echo "Validating $$dir..."; \
		(cd "$$dir" && terraform init -backend=false -input=false >/dev/null && terraform validate); \
	done

validate-examples: validate-prep ## Validate examples
	@set -e; \
	for dir in $$(find . -type f -name '*.tf' -path '*/examples/*' \
		-not -path '*/.terraform/*' -not -path '*/.terragrunt-cache/*' -not -path '*/.ref-oci/*' 2>/dev/null | \
		sed 's|/[^/]*$$||' | sort -u); do \
		echo "Validating $$dir..."; \
		(cd "$$dir" && terraform init -backend=false -input=false >/dev/null && terraform validate); \
	done

lint: ## Run tflint recursively
	@tflint --config .tflint.hcl --recursive

docs: ## Generate module README docs with terraform-docs
	@for dir in */; do \
		dir=$${dir%/}; \
		[ -f "$$dir/main.tf" ] || continue; \
		terraform-docs markdown table --output-file README.md --output-mode inject "$$dir" || true; \
	done

list-modules: ## List module directories
	@for dir in */; do \
		dir=$${dir%/}; \
		[ -f "$$dir/main.tf" ] || continue; \
		echo "$$dir"; \
	done

clean: ## Remove local terraform/terragrunt caches
	@find . -type d -name .terraform -prune -exec rm -rf {} +
	@find . -type d -name .terragrunt-cache -prune -exec rm -rf {} +

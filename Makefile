init: ## terraform init on every stack
	cd infra/bootstrap && terraform init
	cd infra/platform  && terraform init
	cd infra/argocd    && terraform init

up:
	cd infra/platform && terraform apply -auto-approve -var-file=./envs/dev.tfvars
	cd infra/argocd   && terraform apply -auto-approve -var-file=./envs/dev.tfvars

down:
	cd infra/platform && terraform destroy -auto-approve -var-file=./envs/dev.tfvars
	@echo "Platform destroyed. Verify nothing was orphaned:"
	@az group list --query "[?starts_with(name,'MC_')].name" -o tsv

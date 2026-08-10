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

argocd: ## Install ArgoCD and bootstrap the root Application
	cd infra/argocd && terraform apply -auto-approve -var-file=./envs/dev.tfvars
	az aks get-credentials --resource-group rg-aks-platform-prod --name prod-aks-app --overwrite-existing
	kubectl apply -f gitops/root.yml

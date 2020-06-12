workspace:
	@terraform workspace select $(ENV) || terraform workspace new $(ENV)

remote-state:
	@echo "Builds remote-state in S3 for Terraform in $(ENV)"
	@terraform apply -target module.remote-state -var-file workspace-variables/$(ENV).tfvars

#Can't use variables on backend.tf. So we define a parameterized command
init-remote-stage:
	@echo "initialize terraform with remote state in S3 for stage environment"
	@terraform init  -backend-config="encrypt=true" -backend-config="bucket=terraform-state-cg-kafka-front-cluster-stage" -backend-config="dynamodb_table=terraform-state-lock-cg-kafka-front-cluster-stage" -backend-config="region=eu-west-1" -backend-config="key=terraform.tfstate.d/stage/terraform.tfstate"

refresh:
	@echo "refresh the state for remote-state in S3 $(ENV)"
	@terraform refresh -var-file workspace-variables/$(ENV).tfvars

pull-state:
	@echo "if for some reason you need the state at your local machine"
	@terraform state pull > terraform.tfstate.d/$(ENV)/terraform.tfstate

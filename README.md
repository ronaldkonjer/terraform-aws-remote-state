#backend.tf => comment
terraform {
  backend "s3" {}
}

#If not done yet, create a workspace
terraform workspace new stage

#Select workspace
make workspace ENV=stage
```
workspace:
	@terraform workspace select $(ENV) || terraform workspace new $(ENV)
```

#Initialize the project
make init

```
init:
	@terraform init
```

make remote-state ENV=stage
```
remote-state:
	@echo "Builds remote-state in S3 for Terraform in $(ENV)"
	@terraform apply -target module.remote-state -var-file workspace-variables/$(ENV).tfvars
```

#backend.tf => uncomment
terraform {
  backend "s3" {}
}

#Initialize the remote state in S3
make init-remote-stage
```
init-remote-stage:
	@echo "initialize terraform with remote state in S3 for stage environment"
	@terraform init  -backend-config="encrypt=true" -backend-config="bucket=terraform-state-ront-cluster-stage" -backend-config="dynamodb_table=terraform-state-lock-front-cluster-stage" -backend-config="region=eu-west-1" -backend-config="key=terraform.tfstate.d/stage/terraform.tfstate"
```

make refresh ENV=stage
```
refresh:
	@echo "refresh the state for remote-state in S3 $(ENV)"
	@terraform refresh -var-file workspace-variables/$(ENV).tfvars
```

run your terraform plan and apply commands

# To download the state to your local machine
terraform state pull > terraform.tfstate
``` 
pull-state:
	@echo "if for some reason you need the state at your local machine"
	@terraform state pull > terraform.tfstate.d/$(ENV)/terraform.tfstate

```
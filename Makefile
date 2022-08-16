SHELL := /bin/bash

# Tutorial
# https://makefiletutorial.com/

infrastructure_aws_bigdata_demo_plan:
	cd infrastructure/aws-bigdata-demo; terraform init; terraform plan -var-file="credentials.tfvars" --out="plan.tfplan"
	

infrastructure_aws_bigdata_demo_apply: infrastructure_aws_bigdata_demo_plan
	cd infrastructure/aws-bigdata-demo; terraform apply "plan.tfplan"
	
infrastructure_aws_bigdata_demo: infrastructure_aws_bigdata_demo_plan infrastructure_aws_bigdata_demo_apply
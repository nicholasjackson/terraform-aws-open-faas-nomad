# Simple OpenFaas instance Running on Nomad in AWS
This module will create a Nomad cluster with Consul, VPC, and ALB for Nomad server and the OpenFaaS gateway

### 1. Set Environment variables for AWS

```bash
export AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxxxxxxx
export AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
export AWS_REGION=eu-west-1
```

### 2. Install Nomad and faas-cli

```bash
$ brew install faas-cli
$ brew install nomad
$ brew install terraform
```

### 3. Add the module to your Terraform config
The below configuration will create a single node Nomad cluster with 3 agents.

```hcl
module "open-faas-nomad" {
  source = "nicholasjackson/open-faas-nomad/aws"

  min_agents = "3"
}
```

### 4. Create environment

```bash
$ terraform init  
$ terraform plan  
$ terraform apply
```

### 5. Set Nomad and OpenFaaS environment variables

```bash
$ export NOMAD_ADDR=http://$(terraform output nomad_alb):4646/  
$ export GATEWAY=http://$(terraform output faas_alb):8080/
```

### 6. Run OpenFaaS on the Nomad cluster

```bash
$ nomad run faas.hcl
```

### 7. Deploy a function to OpenFaaS

```bash
$ faas-cli deploy --gateway=$GATEWAY --image=functions/nodeinfo:latest --name=info --handler=node main.js
```

### 8. Test function

```bash
$ faas-cli invoke --name=info
```
  
The OpenFaaS UI is also available at http://$(terraform output faas_alb):8081

```bash
$ open http://$(terraform output faas_alb):8081
```
   
Please see [example/terraform.tf](example/terraform.tf) for usage with all configurable options and 
[openfaas.com](http://openfaas.com) for more details on OpenFaaS.

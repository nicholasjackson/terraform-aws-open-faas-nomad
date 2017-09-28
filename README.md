# Simple OpenFaas instance Running on Nomad in AWS

## Creating a cluster

### 1. Set Environment variables for AWS
```
export AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxxxxxxx
export AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
export AWS_REGION=eu-west-1
```

### 2. Install Nomad and faas-cli
```
$ brew install faas-cli
$ brew install nomad
$ brew install terraform
```

### 3. Add the module to your Terraform config
```hcl
```

### 4. Create environment
```
$ terraform init
$ terraform plan
$ terraform apply
```

### 5. Set Nomad and OpenFaaS environment variables
```
$ export NOMAD_ADDR=http://$(terraform output nomad_alb):4646/
$ export GATEWAY=http://$(terraform output faas_alb):8080/
```

### 6. Run OpenFaaS on the Nomad cluster
```
$ nomad run faas.hcl
```

### 7. Deploy a function to OpenFaaS
```
$ faas-cli deploy --gateway=$GATEWAY --image=functions/nodeinfo:latest --name=info --handler=node main.js
```

### 8. Test function
```
$ faas-cli deploy --gateway=$GATEWAY --image=functions/nodeinfo:latest --name=info --handler=node main.js
```
  
The OpenFaaS UI is also available at http://$(terraform output faas_alb):8081
```
$ open http://$(terraform output faas_alb):8081
``

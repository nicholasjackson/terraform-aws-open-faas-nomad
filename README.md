# Demo of OpenFaas Running on Nomad

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

### 3. Create environment
```
$ terraform init
$ terraform plan
$ terraform apply
```

### 4. Set Nomad and OpenFaaS environment variables
```
$ export NOMAD_ADDR=http://$(terraform output nomad_alb):4646/
$ export GATEWAY=http://$(terraform output faas_alb):8080/
```

### 5. Run OpenFaaS on Nomad
```
$ nomad run faas.hcl
```

### 6. Deploy a function to OpenFaaS
```
$ faas-cli deploy --gateway=$GATEWAY --image=functions/nodeinfo:latest --name=info --handler=node main.js
```

### 7. Test function
```
$ faas-cli deploy --gateway=$GATEWAY --image=functions/nodeinfo:latest --name=info --handler=node main.js
```

The OpenFaaS UI is also available at http://$(terraform output faas_alb):8081

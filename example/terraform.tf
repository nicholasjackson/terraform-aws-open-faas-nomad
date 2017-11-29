module "open-faas-nomad" {
  #source = "../"
  source    = "nicholasjackson/open-faas-nomad/aws"
  namespace = "openfaas"

  ssh_key = "~/.ssh/id_rsa.pub"

  min_servers = "1"
  max_servers = "5"
  min_agents  = "3"
  max_agents  = "5"

  consul_version = "1.0.0"
  nomad_version  = "0.7.0"
}

output "nomad_endpoint" {
  value = "http://${module.open-faas-nomad.nomad_alb}:4646/"
}

output "openfaas_endpoint" {
  value = "http://${module.open-faas-nomad.openfaas_alb}:8080/"
}

output "grafana_endpoint" {
  value = "http://${module.open-faas-nomad.openfaas_alb}:3000/"
}

output "prometheus_endpoint" {
  value = "http://${module.open-faas-nomad.openfaas_alb}:9090/"
}

output "vpc_id" {
  value = "${module.open-faas-nomad.vpc_id}"
}

output "security_group" {
  value = "${module.open-faas-nomad.security_group}"
}

output "route_table_id" {
  value = "${module.open-faas-nomad.route_table_id}"
}

output "subnets" {
  value = "${module.open-faas-nomad.subnets}"
}

module "open-faas-nomad" {
  source = "nicholasjackson/terraform-aws-open-faas-nomad/aws"

  namespace = "mynamespace"

  ssh_key = "~/.ssh/id_rsa.pub"

  min_servers = "1"
  max_servers = "5"
  min_agents  = "3"
  max_agents  = "5"

  consul_version = "0.9.3"
  nomad_version  = "0.6.3"
}

output "nomad_alb" {
  value = "${module.open-faas-nomad.nomad_alb}"
}

output "faas_alb" {
  value = "${module.open-faas-nomad.faas_alb}"
}

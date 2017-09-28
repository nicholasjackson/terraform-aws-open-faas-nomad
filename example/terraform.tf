module "open-faas-nomad" {
  source = "nicholasjackson/open-faas-nomad/aws"

  namespace = "mynamespace"

  min_servers = "1"
  max_servers = "5"
  min_agents  = "3"
  max_agents  = "5"

  consul_version = "0.9.3"
  nomad_version  = "0.6.3"
}

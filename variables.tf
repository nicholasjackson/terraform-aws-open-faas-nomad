variable "namespace" {
  default = "openfaas"
}

variable "min_servers" {
  default     = "1"
  description = "Minimum number of Nomad servers in the cluster autoscale group"
}

variable "max_servers" {
  default     = "5"
  description = "Maximum number of Nomad servers in the cluster autoscale group"
}

variable "min_agents" {
  default     = "1"
  description = "Minimum number of Nomad agents in the cluster autoscale group"
}

variable "max_agents" {
  default     = "5"
  description = "Maximum number of Nomad agents in the cluster autoscale group"
}

variable "consul_version" {
  default     = "0.9.3"
  description = "Version of Consul to install"
}

variable "nomad_version" {
  default     = "0.6.3"
  description = "Version of Nomad to install"
}

output "nomad_alb" {
  value = "${aws_alb.nomad.dns_name}"
}

output "faas_alb" {
  value = "${aws_alb.openfaas.dns_name}"
}

output "grafana_alb" {
  value = "${aws_alb.grafana.dns_name}"
}

output "prometheus_alb" {
  value = "${aws_alb.prometheus.dns_name}"
}

output "vpc_id" {
  value = "${aws_vpc.default.id}"
}

output "security_group" {
  value = "${aws_security_group.allow_nomad.id}"
}

output "route_table_id" {
  value = "${aws_vpc.default.main_route_table_id}"
}

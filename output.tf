output "nomad_alb" {
  value = "${aws_alb.nomad.dns_name}"
}

output "faas_alb" {
  value = "${aws_alb.openfaas.dns_name}"
}

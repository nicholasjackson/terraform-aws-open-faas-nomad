# Create a new load balancer
resource "aws_alb" "nomad" {
  name            = "${var.namespace}-nomad"
  internal        = false
  security_groups = ["${aws_security_group.allow_nomad.id}"]
  subnets         = ["${aws_subnet.default.*.id}"]
}

resource "aws_alb_target_group" "nomad" {
  name     = "${var.namespace}-nomad"
  port     = 4646
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.default.id}"

  health_check {
    path    = "/v1/status/leader"
    matcher = "200,202"
  }
}

resource "aws_alb_listener" "nomad" {
  load_balancer_arn = "${aws_alb.nomad.arn}"
  port              = "4646"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.nomad.arn}"
    type             = "forward"
  }
}

resource "aws_alb" "openfaas" {
  name            = "${var.namespace}-openfaas"
  internal        = false
  security_groups = ["${aws_security_group.allow_nomad.id}"]
  subnets         = ["${aws_subnet.default.*.id}"]
}

resource "aws_alb_target_group" "openfaas" {
  name     = "${var.namespace}-openfaas"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.default.id}"

  health_check {
    path    = "/ui/"
    matcher = "200,202"
  }
}

resource "aws_alb_listener" "openfaas" {
  load_balancer_arn = "${aws_alb.openfaas.arn}"
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.openfaas.arn}"
    type             = "forward"
  }
}

resource "aws_alb_target_group" "prometheus" {
  name     = "${var.namespace}-prometheus"
  port     = 9090
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.default.id}"

  health_check {
    path    = "/graph"
    matcher = "200,202"
  }
}

resource "aws_alb_listener" "prometheus" {
  load_balancer_arn = "${aws_alb.openfaas.arn}"
  port              = "9090"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.prometheus.arn}"
    type             = "forward"
  }
}

resource "aws_alb_target_group" "grafana" {
  name     = "${var.namespace}-grafana"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.default.id}"

  health_check {
    path    = "/login"
    matcher = "200,202"
  }
}

resource "aws_alb_listener" "grafana" {
  load_balancer_arn = "${aws_alb.openfaas.arn}"
  port              = "3000"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.grafana.arn}"
    type             = "forward"
  }
}

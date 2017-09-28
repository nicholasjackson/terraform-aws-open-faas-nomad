# Create a new load balancer
resource "aws_alb" "openfaas" {
  name            = "${var.namespace}-openfaas"
  internal        = false
  security_groups = ["${aws_security_group.allow_nomad.id}"]
  subnets         = ["${aws_subnet.default.*.id}"]
}

resource "aws_alb_target_group" "faas" {
  name     = "${var.namespace}-faas"
  port     = 8081
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.default.id}"

  health_check {
    path = "/ui/"
  }
}

resource "aws_alb_listener" "faas" {
  load_balancer_arn = "${aws_alb.openfaas.arn}"
  port              = "8081"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.faas.arn}"
    type             = "forward"
  }
}

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
    path = "/v1/status/leader"
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

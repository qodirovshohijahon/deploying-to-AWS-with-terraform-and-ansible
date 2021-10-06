#Create an application load balancer
resource "aws_alb" "alb_test" {
  provider = aws.region-master
  name            = "jenkins-lb"
  internal        = true
  load_balancer_type = "application"
  security_groups = [aws_security_group.lb-sg.id]

  subnets = [aws_subnet.subnet_1, aws_subnet.subnet_2.id]

  tags {
    Name = "Jenkins-LB"
  }
}

#Create target group with health check
resource "aws_lb_target_group" "test" {
  provider = aws.region-master
  name = "app-lb-tg"
  port = var.webserver-port
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc_master.id
  health_check_protocol = "HTTP"
  health_check_port = "80"
  health_check_path = "/"
  health_check_interval_seconds = 30
  health_check_timeout_seconds = 5
  healthy_threshold_count = 3
  unhealthy_threshold_count = 3
  matcher = "200-299"
  tags = {
      Name = "jenkins-target-group"
  }
}

#Create a listener for the target group
resource "aws_lb_listener" "jenkins-listener-http" {
  provider = aws.region-master
  load_balancer_arn = aws_alb.application-lb.arn
  port = var.webserver-port
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.app-lb-tg.id
    type = "forward"
  }
}
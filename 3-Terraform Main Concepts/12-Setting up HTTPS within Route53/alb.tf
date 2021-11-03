#Create an application load balancer
resource "aws_alb" "application-lb" {
  provider           = aws.region-master
  name               = "jenkins-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb-sg.id]

  subnets = [aws_subnet.subnet_1, aws_subnet.subnet_2.id]

  tags {
    Name = "Jenkins-LB"
  }
}

#Create target group with health check
resource "aws_lb_target_group" "app-lb-tg" {
  provider                      = aws.region-master
  name                          = "app-lb-tg"
  port                          = var.webserver-port
  protocol                      = "HTTP"
  vpc_id                        = aws_vpc.vpc_master.id
  health_check_protocol         = "HTTP"
  health_check_port             = "80"
  health_check_path             = "/"
  health_check_interval_seconds = 30
  health_check_timeout_seconds  = 5
  healthy_threshold_count       = 3
  unhealthy_threshold_count     = 3
  matcher                       = "200-299"
  tags = {
    Name = "Jenkins-target-group"
  }
}

#Create a load balancer target group attachment for the listener  
resource "aws_lb_target_group_attachment" "jenkins-tg-attachment" {
  provider         = aws.region-master
  target_group_arn = aws_lb_target_group.app-lb.arn
  target_id        = aws_instance.jenkins-master.id
  port             = var.webserver-port
}

#Create new listener on tcp/443 HTTPS
resource "aws_lb_listener" "jenkins-listener" {
  provider          = aws.region-master
  load_balancer_arn = aws_lb.application-lb.arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.jenkins-lb-https.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-lb-tg.arn
  }
}


#HTTPS ALB Setup, modify existing listener on TCP/80 and redirec it to HTTPS/443
#listener

resource "aws_lb_listener" "jenkins-listener-http" {
  provider          = aws.region-master
  load_balancer_arn = aws_lb.application-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

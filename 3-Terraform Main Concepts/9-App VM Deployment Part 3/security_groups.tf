#Create SG for LB, only TCP/80, TCP/443 and outbound access
resource "aws_security_group" "lb-sg" {
  provider    = aws.region-master
  name        = "lb-sg"
  description = "Allow 443 and traffic to Jenkins SG"
  vpc_id      = aws_vpc.vpc_master.id
  ingress {
    description = "Allow 443 from anywhare"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_block  = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow 80 from anywhare for redirection"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_block  = ["0.0.0.0/0"]
  }
  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_block = ["0.0.0.0/0"]
  }
}

#Create SG for allowing TCP/8080 and TCP/22 from your IP in us-east-1

resource "aws_security_group" "jenkins-sg" {
  provider    = aws.region-master
  name        = "jenkins-sg"
  description = "Allow 8080 and 22 from your IP in us-east-1"
  vpc_id      = aws_vpc.vpc_master.id
  ingress {
    description = "Allow 22 from your IP in us-east-1"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_block  = [var.external_ip]
  }
  ingress {
    description        = "Allow anyone on port 8080"
    from_port          = 8080
    to_port            = 8080
    protocol           = "tcp"
    aws_security_group = [aws_security_group.lb-sg.id]
  }
  ingress {
    description = "Allow anyone from us-west-2"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_block  = ["192.168.1.0/24"]
  }
  egress {
    from_port  = 0
    to_port    = 0
    cidr_block = ["0.0.0.0/0"]
  }
}


#Create SG for allowing TCP/22 from your IP in us-west-2

resource "aws_security_group" "jenkins-sg-oregon" {
  provider = aws.region-worker

  name        = "jenkins-sg-oregon"
  description = "Allow 8080 and 22 from your IP in us-east-1"
  vpc_id      = aws_vpc.vpc_master_oregon.id
  ingress {
    description = "Allow 22 from your IP in us-east-1"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_block  = [var.external_ip]
  }
  ingress {
    description = "Allow traffic from us-east-1"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.1.0/24"]
  }
  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_block = ["0.0.0.0/0"]
  }
}
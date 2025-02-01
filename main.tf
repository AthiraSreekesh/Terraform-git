# Creating Security Groups

resource "aws_security_group" "frontend_sg" {
  name_prefix = "${var.project_name}-frontend-sg"
  description = "Allow inbound HTTPS and HTTP access"
  tags = {
    "Name" = "${var.project_name}-frontend-sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "frontend_sg_rule_https" {
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.frontend_sg.id
}

resource "aws_security_group_rule" "frontend_sg_rule_http" {
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.frontend_sg.id
}

resource "aws_security_group" "ssh_access_sg" {
  name_prefix = "${var.project_name}-ssh-access-sg"
  description = "Allow SSH access"
  tags = {
    "Name" = "${var.project_name}-ssh-access-sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "ssh_sg_rule_dev" {
  count             = var.env == "Development" ? 1 : 0
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ssh_access_sg.id
}

resource "aws_security_group_rule" "ssh_sg_rule_prod" {
  count             = var.env == "Production" ? 1 : 0
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["167.103.6.209/32"]
  security_group_id = aws_security_group.ssh_access_sg.id
}

# Creating EC2 instance

resource "aws_instance" "Web_access" {
  count                       = 3
  ami                         = var.web_instance_ami
  instance_type               = var.web_instance_type
  key_name                    = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids      = [aws_security_group.frontend_sg.id, aws_security_group.ssh_access_sg.id]
  user_data                   = file("${var.user_data_file}")
  user_data_replace_on_change = var.user_data_replacement
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name" = "${var.project_name}-${var.env}"
  }
}
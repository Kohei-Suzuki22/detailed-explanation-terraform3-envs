module "servers" {
  # source = "git::https://github.com/Kohei-Suzuki22/detailed-explanation-terraform3-modules.git//servers?ref=v1.2.1"
  source = "../../../modules/servers"

  cluster_name = "staging"
  remote_state_bucket = "detailed-explanation-terraform"
  globals_remote_state_key = "globals/terraform.tfstate"
  databases_remote_state_key = "staging/databases/terraform.tfstate"
  ami = "ami-07c589821f2b353aa"
  server_text = "HeLLo, nEwWoLD"
  server_port = var.server_port
  instance_type = "t2.micro"
  autoscaling_min_size = 2
  autoscaling_max_size = 2
  autoscaling_enable_flg = false
}


resource "aws_security_group_rule" "staging_alb_sg_ingress" {
  security_group_id = module.servers.alb-sg-id
  type = "ingress"

  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
module "servers" {
  source = "git::https://github.com/Kohei-Suzuki22/detailed-explanation-terraform3-modules.git//servers?ref=v1.1.0"

  cluster_name = "prod"
  remote_state_bucket = "detailed-explanation-terraform"
  globals_remote_state_key = "globals/terraform.tfstate"
  databases_remote_state_key = "prod/databases/terraform.tfstate"
  server_port = var.server_port
  instance_type = "t2.micro"
  autoscaling_min_size = 2
  autoscaling_max_size = 2
  autoscaling_enable_flg = false
}
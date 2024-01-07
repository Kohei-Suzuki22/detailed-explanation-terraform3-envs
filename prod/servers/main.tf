module "servers" {
  source = "git::https://github.com/Kohei-Suzuki22/detailed-explanation-terraform3-modules.git//servers?ref=v1.2.1"
  # source = "../../../modules/servers"

  cluster_name = "prod"
  remote_state_bucket = "detailed-explanation-terraform"
  globals_remote_state_key = "globals/terraform.tfstate"
  databases_remote_state_key = "prod/databases/terraform.tfstate"
  ami = "ami-07c589821f2b353aa"
  server_text = "Server text"
  server_port = var.server_port
  instance_type = "t2.micro"
  autoscaling_min_size = 2
  autoscaling_max_size = 2
  autoscaling_enable_flg = false
}
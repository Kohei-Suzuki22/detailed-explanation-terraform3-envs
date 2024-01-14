module "primary_databases" {
  # source = "git::https://github.com/Kohei-Suzuki22/detailed-explanation-terraform3-modules.git//databases?ref=v1.3.0"
  source = "../../../modules/databases"
  providers = {
    aws = aws.tokyo
  }

  cluster_name = "staging"
  remote_state_bucket = "detailed-explanation-terraform"
  globals_remote_state_key = "globals/terraform.tfstate"
  secret_name = "detailed-explanation-terraform/db/cred"
  db_username = var.db_username
  db_password = var.db_password
}

output "arn" {
  value = module.primary_databases.db_instance_arn
}


module "replica_databases" {
  # source = "git::https://github.com/Kohei-Suzuki22/detailed-explanation-terraform3-modules.git//databases?ref=v1.3.0"
  source = "../../../modules/databases"
  providers = {
    aws = aws.oregon
  }

  cluster_name = "staging"
  remote_state_bucket = "detailed-explanation-terraform"
  globals_remote_state_key = "globals/terraform.tfstate"

  secret_name = "detailed-explanation-terraform/db/cred"
  replicate_source_db = module.primary_databases.db_instance_arn
}
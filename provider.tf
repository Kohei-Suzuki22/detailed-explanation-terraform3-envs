terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>5.32"
    }
  }
}



provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      Owner = "team-foo"
      ManagedBy = "terraform"
    }
  }
}


provider "aws" {
  region = "ap-northeast-1"
  alias = "ap-northeast-1"

  default_tags {
    tags = {
      Owner = "team-reagion-1"
      ManagedBy = "terraform"
    }
  }
}
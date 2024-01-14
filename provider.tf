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
  alias = "tokyo"

  default_tags {
    tags = {
      Owner = "team-foo"
      ManagedBy = "terraform"
      Region = "ap-northeast-1"
    }
  }  
}


provider "aws" {
  region = "us-west-2"
  alias = "oregon"

  default_tags {
    tags = {
      Owner = "team-foo"
      ManagedBy = "terraform"
      Region = "us-west-1"
    }
  }  
}
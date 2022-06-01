terraform {
  cloud {
    organization = "final-project-teamB"

    workspaces {
      name = "final-project-teamB"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

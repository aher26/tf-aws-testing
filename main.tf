terraform {
  backend "s3" {
    bucket         = "coba-coba-app"
    key            = "terraform/infrastructure.tfstate"
    region         = "ap-southeast-1"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

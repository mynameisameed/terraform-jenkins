terraform {
  backend "s3" {
    bucket = "bubbylabs-backend"
    key    = "devops-project-1/terraform.tfstate"
    region = "us-east-1"
  }
}
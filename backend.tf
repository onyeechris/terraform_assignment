terraform {
  backend "s3" {
    bucket = "akachristianonyekachukwudevops"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

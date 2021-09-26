terraform {
   backend "s3" {
    bucket  = "aws-remote-tf-bucket"
    key     = "development/terraform_state"
    region  = "us-east-2"
  }
}

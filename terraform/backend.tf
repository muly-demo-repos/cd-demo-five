terraform {
  backend "s3" {
    bucket = "terraform-state-demonstration"
    key    = "development/vikoosh"
    region = "us-east-1"
  }
}
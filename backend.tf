terraform {
  backend "s3" {
    bucket = "mygits3bucket"
    key    = "terraform"
    region = "eu-north-1"
  }
}

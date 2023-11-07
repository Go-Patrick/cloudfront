module "s3_bucket" {
  source = "./modules"
  BUCKET_NAME = var.BUCKET_NAME
}
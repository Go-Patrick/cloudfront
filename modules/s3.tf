variable "region" {
  default = "ap-southeast-1"
}

// Crete bucket
resource "aws_s3_bucket" "react_bucket" {
  bucket = var.BUCKET_NAME
  force_destroy = true

  tags = {
    Name = var.BUCKET_NAME
  }
}

// Bucket config for static host
resource "aws_s3_bucket_website_configuration" "react_web_config" {
  bucket = aws_s3_bucket.react_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_versioning" "react_version" {
  bucket = aws_s3_bucket.react_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

// Create ownership and public access
resource "aws_s3_bucket_ownership_controls" "react_ownership" {
  bucket = aws_s3_bucket.react_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "react_public" {
  bucket = aws_s3_bucket.react_bucket.id

  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "react" {
  bucket = aws_s3_bucket.react_bucket.id

  depends_on = [ aws_s3_bucket_ownership_controls.react_ownership, aws_s3_bucket_public_access_block.react_public ]

  acl = "public-read"
}

// Allow public access into hosting web
resource "aws_s3_bucket_policy" "react" {
  bucket = aws_s3_bucket.react_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "AllowGetObjects"
    Statement = [
      {
        Sid       = "AllowPublic"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.react_bucket.arn}/**"
      }
    ]
  })
}
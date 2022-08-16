########
# Landing
########
resource "aws_s3_bucket" "landing_bucket" {
  bucket        = local.landing_s3
  force_destroy = true
  tags          = local.tags
}

resource "aws_s3_bucket_acl" "lnd_acl" {
  bucket = aws_s3_bucket.landing_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "ldn_versioning" {
  bucket = aws_s3_bucket.landing_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

########
# Transformed
########
resource "aws_s3_bucket" "transformed_bucket" {
  bucket        = local.transformed_s3
  force_destroy = true
  tags          = local.tags
}

resource "aws_s3_bucket_acl" "transformed_acl" {
  bucket = aws_s3_bucket.transformed_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "transformed_versioning" {
  bucket = aws_s3_bucket.transformed_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

########
# Marts
########
resource "aws_s3_bucket" "marts_bucket" {
  bucket        = local.marts_s3
  force_destroy = true
  tags          = local.tags
}

resource "aws_s3_bucket_acl" "marts_acl" {
  bucket = aws_s3_bucket.marts_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "marts_versioning" {
  bucket = aws_s3_bucket.marts_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
//Terraform block to define required providers and versions
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.2.0"
    }
  }
}

//AWS provider configuration with region set 
provider "aws" {
  region = "ap-south-1"
}

//Generate random ID for unique S3 bucket name
resource "random_id" "rand_id" {
  byte_length = 8
}

//Bucket creation 
resource "aws_s3_bucket" "mywebapp-bucket" {
  bucket = "mywebapp-bucket-${random_id.rand_id.hex}"
}

// Allow public access by disabling blocking settings(Required for public static website hosting)
resource "aws_s3_bucket_public_access_block" "webapp" {
  bucket = aws_s3_bucket.mywebapp-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

// Attach bucket policy to allow public read access for all files inside the bucket
resource "aws_s3_bucket_policy" "mywebapp" {
  bucket = aws_s3_bucket.mywebapp-bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = ["s3:GetObject"],
        Resource  = ["arn:aws:s3:::${aws_s3_bucket.mywebapp-bucket.id}/*"]
      }
    ]
  })
}

//Enable static website hosting on the S3 bucket
resource "aws_s3_bucket_website_configuration" "mywebapp" {
  bucket = aws_s3_bucket.mywebapp-bucket.id

  index_document {
    suffix = "index.html"
  }
}

//Upload index.html to S3 bucket with proper content type
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.mywebapp-bucket.bucket
  source       = "./index.html"
  key          = "index.html"
  content_type = "text/html"
}

// Upload styles.css to S3 bucket with proper content type
resource "aws_s3_object" "styles_css" {
  bucket       = aws_s3_bucket.mywebapp-bucket.bucket
  source       = "./styles.css"
  key          = "styles.css"
  content_type = "text/css"
}


// Output the generated bucket name
output "bucket_name" {
  value = aws_s3_bucket.mywebapp-bucket.bucket
}

// Output the website endpoint to easily access the site
output "random" {
  value = aws_s3_bucket_website_configuration.mywebapp.website_endpoint
}

  
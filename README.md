# terraform-static-website-s3
Deploy a static website on AWS S3 using Terraform with public access, automatic bucket name generation, and clean IaC practices.

# Terraform Static Website on AWS S3

This project demonstrates how to use **Terraform** to deploy a fully functional **static website** on **Amazon S3**. The infrastructure is defined as code (IaC), making it reusable, scalable, and production-ready.

## 🚀 Features

- Creates an S3 bucket with a unique name using `random_id`
- Uploads static files (`index.html`, `styles.css`) to the bucket
- Configures public access via bucket policy
- Enables S3 static website hosting
- Outputs the live website URL after deployment

## 🌐 Live Demo
> Hosted on S3:  
> http://mywebapp-bucket-8100b96688afc4dd.s3-website.ap-south-1.amazonaws.com

## 🔧 Technologies Used

- Terraform v1.x
- AWS S3
- Infrastructure as Code (IaC)

## 📂 Project Structure

├── main.tf # Terraform configuration file
├── index.html # Static HTML homepage
├── styles.css # Styling for the homepage
└── README.md # Project documentation


## ✅ How to Use

1. Clone the repository:
git clone https://github.com/your-username/terraform-static-website-s3.git
cd terraform-static-website-s3

2. Initialize Terraform:
terraform init

3. Apply the configuration:
terraform apply

Visit the output website URL in your browser.
http://mywebapp-bucket-8100b96688afc4dd.s3-website.ap-south-1.amazonaws.com/

🛡️ Note
This configuration is designed for public hosting of non-sensitive static content only.

📬 Connect
If you found this useful or have questions, feel free to connect with me on LinkedIn.




















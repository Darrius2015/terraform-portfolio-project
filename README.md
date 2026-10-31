## Deploying a Static Next.js Website on AWS Using Terraform

## Project Overview

This project demonstrates how I used Terraform to provision AWS infrastructure and deploy a static Next.js website using Amazon S3 and Amazon CloudFront.

The project was completed as part of my Cloud Engineer Academy training to develop practical experience with Infrastructure as Code (IaC), cloud architecture, security and infrastructure lifecycle management.

I successfully deployed the website, accessed it through a CloudFront URL and subsequently destroyed the infrastructure using Terraform.

## 1. The Problem

Deploying cloud infrastructure manually through the AWS Management Console can become repetitive and difficult to maintain.

When infrastructure needs to be recreated, manually configuring each resource introduces opportunities for inconsistencies and human error.

The objective of this project was to explore how Infrastructure as Code could make deploying a static website more repeatable and manageable.

## 2. What I Built

I deployed a static Next.js website using the following technologies:

* Terraform: Defined and provisioned the AWS infrastructure using code.
* Amazon S3: Stored the website’s static files.
* Amazon CloudFront: Delivered the website to users over HTTPS.
* CloudFront Origin Access Control (OAC): Allowed CloudFront to securely retrieve files from the private S3 bucket.
* AWS CLI: Uploaded the generated website files to Amazon S3.
* Next.js: Generated the static website files.

Architecture

                  Website Visitor
                         |
                         | HTTPS
                         v
                  Amazon CloudFront
                         |
                         | Origin Access Control
                         v
                   Private S3 Bucket
                         |
                         v
                 Static Next.js Files
          Terraform manages AWS infrastructure

The website files were stored in a private S3 bucket rather than being made publicly accessible.

CloudFront acted as the public entry point, retrieving the files from S3 using Origin Access Control.

## 3. Technical Decisions

Why Terraform?

I used Terraform because it allows infrastructure to be defined in configuration files rather than created manually.

This approach makes it easier to understand the infrastructure, reproduce deployments and manage changes.

Why Amazon S3?

Amazon S3 is suitable for storing static website assets such as HTML, CSS and JavaScript files.

Because the application was exported as a static Next.js website, it did not require an application server to deliver its pages.

Why Amazon CloudFront?

CloudFront provides a content delivery network (CDN) that can distribute website content through geographically distributed edge locations.

It also allowed visitors to access the website using HTTPS.

Why Keep the S3 Bucket Private?

Rather than enabling public access to the S3 bucket, I configured CloudFront Origin Access Control.

The bucket policy permitted CloudFront to retrieve website objects while S3 Block Public Access settings remained enabled.

This helped me understand how AWS services can communicate securely without exposing the underlying storage directly to the public.

## 4. Challenges and Troubleshooting

One challenge occurred when I initially attempted to access the website through its CloudFront domain.

The browser returned a DNS-related error.

After allowing time for the distribution and DNS availability, I retried the URL and successfully accessed the deployed Next.js website.

This reinforced the importance of verifying deployments and understanding that cloud services may take time to become accessible.

## 5. Results

The project was successfully completed.

* Terraform provisioned five AWS resources.
* The Next.js application was exported into static files.
* The static files were uploaded to Amazon S3 using the AWS CLI.
* CloudFront successfully served the website over HTTPS.
* The website was verified in a browser.
* Terraform successfully destroyed all five managed resources after testing.

The project demonstrated the complete infrastructure lifecycle: define, provision, deploy, verify and destroy.

Project Structure

terraform-portfolio-project/
├── nextjs-blog/
│   ├── pages/
│   ├── public/
│   ├── styles/
│   ├── next.config.js
│   └── package.json
├── terraform/
│   ├── main.tf
│   ├── s3.tf
│   ├── cloudfront.tf
│   ├── outputs.tf
│   └── .terraform.lock.hcl
├── .gitignore
└── README.md

Generated build files, Terraform state files and local dependency directories are excluded from version control.

How to Deploy

Prerequisites

* An AWS account
* AWS CLI installed and configured with appropriate permissions
* Terraform installed
* Node.js and npm installed

## 1. Build the Next.js Website

From the project root:

cd nextjs-blog
npm install
npm run build

The static export configuration generates the website files in the out/ directory.

## 2. Initialise Terraform

cd ../terraform
terraform init

## 3. Review the Infrastructure

terraform fmt
terraform validate
terraform plan

## 4. Deploy the Infrastructure

terraform apply

Review the proposed changes and confirm the deployment.

## 5. Upload the Website Files

From the Terraform directory:

aws s3 sync ../nextjs-blog/out/ s3://YOUR_BUCKET_NAME/ --region eu-west-2

Replace YOUR_BUCKET_NAME with the S3 bucket name created by Terraform.

## 6. Retrieve the CloudFront Domain

terraform output cloudfront_url

Open the resulting domain in a browser using HTTPS.

## 7. Destroy the Infrastructure

Once testing is complete, first remove the uploaded website objects:

aws s3 rm s3://YOUR_BUCKET_NAME/ --recursive --region eu-west-2

Then, from the Terraform directory, run:

terraform destroy

Review the destruction plan and confirm.

Note: Deploying AWS infrastructure can incur charges. Resources should be destroyed when they are no longer required.

Key Lessons Learned

This project helped me develop a better understanding of:

1. How Terraform provisions and manages AWS resources.
2. How static websites can be hosted without traditional application servers.
3. How Amazon S3 and CloudFront work together.
4. How Origin Access Control protects access to private S3 content.
5. How to troubleshoot and verify cloud deployments.
6. Why cleaning up cloud infrastructure is an important part of engineering practice.

Future Improvements

Potential future enhancements include:

* Replacing the starter Next.js page with a personalised portfolio.
* Adding a custom domain and AWS Certificate Manager certificate.
* Automating website deployments through a CI/CD pipeline.
* Adding monitoring and logging.

Project Status

Completed — Infrastructure successfully deployed, tested and destroyed.

This is a learning project completed through Cloud Engineer Academy.

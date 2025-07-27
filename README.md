# Terraform Project: Scalable Web App Infrastructure on AWS

This project provisions a fully scalable and highly available infrastructure on AWS to host a web application using Terraform and modules.

---

##  Modules Used

| Module         | Purpose                                   |
|----------------|-------------------------------------------|
| `vpc`          | Creates VPC, public subnets, IGW, routes  |
| `security-groups` | Manages ALB and EC2 security groups      |
| `alb`          | Creates Application Load Balancer + TG    |
| `ec2`          | Creates Launch Template + Auto Scaling Group |
| `s3` (optional) | Stores Terraform backend state            |

---

##  Terraform Configuration

### Requirements

- Terraform ≥ 1.3.0
- AWS CLI configured (`aws configure`)
- An AWS account with necessary IAM permissions


##  How to Use

1. **Clone the repository**

```bash

git clone https://github.com/oTwilight/terraform-scalable-web-project.git

cd terraform-scalable-web


terraform init

terraform validate
terraform plan

terraform apply

After apply, you'll see the ALB DNS output:
alb_dns_name = your-alb-123456.eu-central-1.elb.amazonaws.com

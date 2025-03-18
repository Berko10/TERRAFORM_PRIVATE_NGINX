# TERRAFORM_PRIVATE_NGINX

Project Description
The goal of this project was to deploy a Dockerized NGINX instance in a private EC2 instance and make it accessible from the public via a NAT instance. This was achieved by setting up a custom AWS architecture using Terraform.

Key Components
AWS Infrastructure:

VPC: Created a Virtual Private Cloud with public and private subnets.
Route Tables: Configured both public and private route tables to manage routing within the VPC.
Internet Gateway (IGW): Ensured that the public subnet instances can access the internet.
NAT Instance: Configured a NAT instance in the public subnet, enabling private subnet instances to access the internet while maintaining security.
Dockerized NGINX:

The NGINX instance was containerized using Docker, and the container was deployed to an EC2 instance in the private subnet.
NGINX was configured to respond with the message: "yo this is nginx".
Public Access:

Using the NAT instance, all traffic between the private EC2 instance and the internet is routed through the public-facing NAT instance, providing secure access to the private instance.
By accessing the public IP of the NAT instance, users can reach the NGINX application hosted on the private instance.
Terraform Automation:

Used Terraform for Infrastructure-as-Code (IaC) to automate the provisioning of the AWS resources, including the VPC, subnets, route tables, EC2 instances, security groups, and the deployment of the Dockerized NGINX.
Architecture Diagram
Insert your diagram here to show the architecture flow, including NAT, VPC, public/private subnets, and routing.

![alt text](image-1.png)

![alt text](image.png)

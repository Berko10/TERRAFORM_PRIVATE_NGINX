variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "ami" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0e1bed4f06a3b463d"
}

variable "instance_state"{
  description = "INSTANCE STATE FOR EC2"
  type        = string
  default     = "t2.micro"
}

#ami-080e1f13689e07408

variable "environment" {
  description = "Environment for resources (e.g. dev, prod)"
  type        = string
  default     = "dev"
}

variable "az" {
  description = "Availability Zone"
  type        = string
  default     = "us-east-1a" # Change to your desired AZ, or use a different one as needed
}

variable "public_key" {
  description = "The public SSH key to be used for EC2 instances"
  type        = string
  default     = "Nginx&bastion"
}

variable "private_key" {
  description = "The public SSH key to be used for EC2 instances"
  type        = string
  default     = "-----BEGIN RSA PRIVATE KEY-----/nMIIEpQIBAAKCAQEAxz3ii0lClVGk0h4T+oP12tI+n/UAqtXBqBsX0efZrLFMeFYV/nDa1mclsuKmtHjksyZ6EuXkK/vlpKnPnsTgBkOoOZS7c2pwV14cPp7xLTLYBvkbY4/n03M050huQmGLtlNdZ8t6oCkf8RTreMu4w4CtLHs/Pvt/c/uW+oK4jDYKKpbk4AuB/nX92lcYT7uAx0yEMcSySuELE72fEBrRMcqC/s3StPsttUkk1xQ/z0ZFmMcm8Uhump/nnNpAGKBUGwKRgnGFMqrXNiByLFWrLY9ShEV1l9CKMIUluWUHohqCHavdjKR1DI5o/nuc8EaNs4GiKyPKwKe9MF3MdKpjL0449DQs1lZwIDAQABAoIBAAUr2QZud1jyzolZ/nmIEnDamJTXDPZh4JAEbBtUOQdfjifS6eZVt+haswLKmTMT9DOmKwL0jpCJsDMu6S/nGg0IO5G9OqxZbAS3wpCCij7XST3kGIE6rozmb5gVLC9y4rJvxXvdLyibCKY0Ocxf/n1ULVwyjlZgXXdz5maEvGOs4A1RC34Cj4XzSzQj+ENwPU5JRYXRSA58I+pKRlxpyy/noGPjyj8MknEHK0TUQ1JPuKGV3N4mk8hueEuCXnb9wZKgYhwfbvoAth5QM5jnwEIx/njamEuKDNssO9tll3H4i/d3og2yFTDtWZcDwC/as8WCcjW/gGE19xK/uGfddZSJDh/neBSclJkCgYEA7sfYu0xFknFXnnUviT+/dQIrBTHIY+tau+kwXQ5WkVT3yGZPjEKu/nrLkvfpiAP1whJaSO4qnSiXMcDogwOX3F+/2zeNMkQynmKek9lUIekNT9EOere7lv/nvNNL6qY7AbKt+JGAECQaYs3HebYxgIG1hct1tSs0LxULloN4a+tnkHMCgYEA1Zwb/nRO/bDerjFoTyOqkH4PJKIzRVOGVrOmgLhUemKstZ+4uDddZjTDTcXkWt45W18DzE/nUZANSS3WDwj4db2z8vFJ0wUs9YCnA8IqVH/zGYHpXHkWwNlb7t82GgLA4r9Ly7Hy/nh1KMfvTsZ6FE2yKmixUeCps6tY1fXgy1Ba7jnj0CgYEAljvjHyUD+PmbGTW97OrQ/n+Tud+ayy2jswYV58cXAeA16kb8//aM5jvITfXxVwS20Z5ec9h1s1/gkQtAv325RI/nxx1+mBywihmImQIJHyn0tUds2gAJItUvemyvLTndklnrn6NcIcu1VkkGoouBZcs2/nfLHgo1ZFhQIGwnKBh9Ua2gUCgYEAph7kGiWKrvUnq8CyfKotpWPoAh7V06kTzfVS/nWFFTSd6hWP2zu7WBvacyZeI8jExGlNE9P80OeAW8fi7UwwRH6Lx7VC+nOjnWKRcc/nQmDLFuAwMqk857diRo+yjGHtzalFceEuosyw1J73JtSFLwJwkKNYnJkB/GU4cHTj/nZssO22UCgYEA4N4Qek63qX9E0ATLnvgC6qXzRgZijH0lddZL1cH+/07NRk59TCgL/notPa1EWug0Jf7yZB7SxHJDMWCIns4gHY1OQh4+GFLuvKMsZoJRKcDz5zL7jp8MjO/neprDXK5A1j4U08VwNK84lO2XSR8FfY3rYhYxRByFECiT0BoYBG2roQQ=/n-----END RSA PRIVATE KEY-----"
}

variable "ssh_cidr" {
  description = "CIDR block for SSH access"
  type        = string
  default     = "192.168.0.0/16" # Change this to your IP
}
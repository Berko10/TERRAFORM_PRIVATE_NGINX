# main.tf

provider "aws" {
  region = var.region
}

# Data Source - Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Data Source for existing Key Pair
data "aws_key_pair" "existing_key" {
  key_name = "Nginx&bastion"  # שם המפתח הקיים
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true  # הפעלת DNS Support
  enable_dns_hostnames = true  # הפעלת DNS Hostnames
  tags = {
    Name        = "Main VPC"
    Environment = var.environment
    Role        = "VPC"
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
  ipv6_cidr_block         = null  # לא להקצות IPv6 ל-Subnet הזה
  tags = {
    Name        = "Public Subnet"
    Environment = var.environment
    Role        = "Subnet"
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  ipv6_cidr_block         = null  # לא להקצות IPv6 ל-Subnet הזה
  tags = {
    Name        = "Private Subnet"
    Environment = var.environment
    Role        = "Subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "Internet Gateway"
    Environment = var.environment
    Role        = "Gateway"
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "Public Route Table"
    Environment = var.environment
    Role        = "RouteTable"
  }
}

# Route to Internet via Internet Gateway
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# Association of Route Table to Public Subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

# nat Security Group
resource "aws_security_group" "nat_sg" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "nat Security Group"
    Environment = var.environment
    Role        = "SecurityGroup"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Private EC2 Security Group
resource "aws_security_group" "private_ec2_sg" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "Private EC2 Security Group"
    Environment = var.environment
    Role        = "SecurityGroup"
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.nat_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# nat Host (NAT Instance)
resource "aws_instance" "nat" {
  ami                = var.ami
  instance_type      = var.instance_state
  subnet_id          = aws_subnet.public.id
  security_groups    = [aws_security_group.nat_sg.id]
  associate_public_ip_address = true
  key_name      = data.aws_key_pair.existing_key.key_name
  source_dest_check = false
  tags = {
    Name        = "nat Instance (NAT)"
    Environment = var.environment
    Role        = "nat"
  }
  user_data = templatefile("${path.module}/nat_user_data.sh", {
    nginx_private_ip = aws_instance.nginx.private_ip
  })
}
#
#sudo service iptables save
#sudo iptables-save | sudo tee /etc/iptables/rules.v4

# Route Table for Private Subnet (via NAT)
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "Private Route Table"
    Environment = var.environment
    Role        = "RouteTable"
  }
}

# Route to NAT instance
resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_instance.nat.primary_network_interface_id
}

# Association of Route Table to Private Subnet
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}

# Nginx EC2 Instance (Private)
resource "aws_instance" "nginx" {
  ami                = var.ami
  instance_type      = var.instance_state
  subnet_id          = aws_subnet.private.id
  security_groups    = [aws_security_group.private_ec2_sg.id]
  key_name      = data.aws_key_pair.existing_key.key_name
  tags = {
    Name        = "Nginx Instance"
    Environment = var.environment
    Role        = "Private EC2"
  }
  user_data = file("./nginx_user_data.sh")
}
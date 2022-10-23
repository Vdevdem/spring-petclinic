provider "aws" {
  region = "eu-west-2"
}

resource "aws_vpc" "default" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.default.id
}

resource "aws_subnet" "tf_subnet" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true

  depends_on = [aws_internet_gateway.gw]
}
data "aws_availability_zones" "available" {
}

resource "aws_network_interface" "multi-ip" {
  subnet_id   = aws_vpc.default.id
  private_ips = ["10.0.0.10", "10.0.0.11", "10.0.0.12"]
}

resource "aws_eip" "ProdNIC" {
  vpc                       = true
  network_interface         = aws_network_interface.multi-ip.id
  associate_with_private_ip = "10.0.0.10"
}

resource "aws_eip" "JenkinsNIC" {
  vpc                       = true
  network_interface         = aws_network_interface.multi-ip.id
  associate_with_private_ip = "10.0.0.11"
}

resource "aws_eip" "DTRNIC" {
  vpc                       = true
  network_interface         = aws_network_interface.multi-ip.id
  associate_with_private_ip = "10.0.0.12"
}

resource "aws_instance" "Prod" {
  # eu-west-2
  ami           = "ami-0caef02b518350c8b"
  instance_type = "t2.micro"
}

resource "aws_instance" "Jenkins" {
  # eu-west-2
  ami           = "ami-0caef02b518350c8b"
  instance_type = "t2.micro"
}

resource "aws_instance" "DTR" {
  # eu-west-2
  ami           = "ami-0caef02b518350c8b"
  instance_type = "t2.micro"
}

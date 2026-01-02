resource "aws_instance" "demo" {
  ami           = "ami-0f5ee92e2d63afc18" # us-east-1 Amazon Linux
  instance_type = "t2.micro"

  tags = {
    Name = "app-terraform-demo"
  }
}
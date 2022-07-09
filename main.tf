variable "example_instance_type" {
    default = "t3.micro"
}

resource "aws_instance" example {
    ami = "ami-0c3fd0f5d33134a76"
    instance_type = var.example_instance_type

    tags = {
      "Name" = "example"
    }

    key_name = "sitti.key"
    user_data = <<EOF
        #!/bin/bash
        yum install -y httpd
        systemctl start httpd.service
    EOF
 }

data "aws_ami" "recent_amazon_linux_2" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name    = "name"
        values  = ["amzn2-ami-hvm-2.0.20190618-x86_64-gp2"]
    }
    
}

 output "example_instance_id" {
    value = aws_instance.example.id
 }
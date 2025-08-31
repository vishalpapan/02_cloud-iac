provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "tf-demo-vpc" {
    cidr_block = var.cidr
}

resource "aws_subnet" "tf-demo-subnet" {
    vpc_id = aws_vpc.tf-demo-vpc.id
    cidr_block = var.subnet-cidr
    availability_zone = var.subnet-az
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "tf-demo-igw" {
    vpc_id = aws_vpc.tf-demo-vpc.id

}

resource "aws_route_table" "tf-demo-rt" {
    vpc_id = aws_vpc.tf-demo-vpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.tf-demo-igw.id
    }
}

resource "aws_route_table_association" "RT" {
    subnet_id = aws_subnet.tf-demo-subnet.id
    route_table_id = aws_route_table.tf-demo-rt.id
  
}
resource "aws_security_group" "tf-demo-sg" {
    vpc_id = aws_vpc.tf-demo-vpc.id
    name = "tf-aws-demo-sg"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["27.7.139.132/32"]

    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["27.7.139.132/32"]

        }   
    egress {
        from_port = 0
        to_port = 0
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        name = "tf-aws-demo-sg"
    }
}
    /*ec2 details*/
    resource "aws_key_pair" "tf-demo-keypair" {
        key_name = "tf-demo-keypair-vishal"
        public_key = file("~/.ssh/vishal-keypair.pub")
    }
    resource "aws_instance" "tf-demo-ec2" {
        ami = var.ec2-ami
        instance_type = var.instance_type
        subnet_id = aws_subnet.tf-demo-subnet.id
        vpc_security_group_ids = [aws_security_group.tf-demo-sg.id]
        key_name = aws_key_pair.tf-demo-keypair.key_name
        tags = {
            name = "tf-aws-demo-ec2"
        }

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("~/.ssh/vishal-keypair")
      host = self.public_ip
    }

    provisioner "file" {
    source      = "app.py"  # Replace with the path to your local file
    destination = "/home/ubuntu/app.py"  # Replace with the path on the remote instance
  }

    provisioner "remote-exec" {
        inline = [ 
            "echo 'Hello from the remote instance' > /tmp/startup.log",
            "sudo apt update -y",
            "sudo apt-get install -y python3-pip",
            "cd /home/ubuntu",
            "sudo pip3 install flask",
            "sudo python3 app.py &"

         ]
        }
     }

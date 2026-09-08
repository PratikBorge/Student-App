resource "aws_instance" "jenkinsmaster" {
    ami = var.aws_ami
    instance_type = var.aws_instance_type
    key_name = var.key_name
    subnet_id = var.public_subnet_id  
    vpc_security_group_ids = var.vpc_security_group_ids 
    tags = {
        Name = "jenkins"
    }
    root_block_device {
      volume_size = var.volume_size
    }
    user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install -y fontconfig openjdk-17-jre wget
    mkdir -p /etc/apt/keyrings
    wget -O /etc/apt/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
    > /etc/apt/sources.list.d/jenkins.list
    sudo apt-get update -y
    sudo apt-get install -y jenkins
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
    EOF
}
resource "aws_instance" "jenkinsnode" {
    ami = var.aws_ami
    instance_type = var.aws_instance_type
    key_name = var.key_name
    subnet_id = var.public_subnet_id  
    vpc_security_group_ids = var.vpc_security_group_ids
    tags = {
        Name = "jenkinsnode"
    }
    root_block_device {
      volume_size = var.volume_size
    }
    user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install openjdk-11-jre-headless -y
    sudo apt-get update
    sudo apt install docker.io -y
    EOF
}

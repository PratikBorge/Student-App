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
    sudo -i
    apt-get update -y
    apt-get install -y fontconfig openjdk-21-jre curl
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key \
    -o /etc/apt/keyrings/jenkins-keyring.asc
    echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
    > /etc/apt/sources.list.d/jenkins.list
    apt-get update -y
    apt-get install -y jenkins
    systemctl enable jenkins
    systemctl start jenkins
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
    sudo apt-get install -y fontconfig openjdk-21-jre curl
    sudo apt-get update
    sudo apt install docker.io -y
    EOF
}

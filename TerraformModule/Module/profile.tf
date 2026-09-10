terraform {
    required_version = ">= 1.6.0"
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }

    backend "s3" {
        bucket = "terraform-three-tier-architecture"
        key    = "terraform.tfstate"
        region = "ap-southeast-1"
        profile = "configs"
        use_lockfile = true 
        encrypt = true
    }
}

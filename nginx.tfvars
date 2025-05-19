#######################################
# Project Variable Assignments
########################################
project = "nginx-aws-terraform"
env     = "Dev"
region  = "us-east-1"

########################################
# Networking Module Variable Assignments
########################################
cidr_vpc = "10.0.0.0/16"

subnets = {
  "subnet-pub-1a" = {
    cidr_block              = "10.0.10.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = true
    route_table             = "route-table-pub"
  }
}

security_groups = {
  "security-group-pub-ng-ub" = {
    description = "Security Group for Instance ng-ub"
    rules = {
      "security-group-pub-ng-ub-rule-1" = {
        cidr_ipv4                    = "0.0.0.0/0"
        referenced_security_group_id = null
        from_port                    = "2222"
        to_port                      = "2222"
        ip_protocol                  = "tcp"
        ingress                      = true
      }
      "security-group-pub-ng-ub-rule-2" = {
        cidr_ipv4                    = "0.0.0.0/0"
        referenced_security_group_id = null
        from_port                    = "80"
        to_port                      = "80"
        ip_protocol                  = "tcp"
        ingress                      = true
      }
      "security-group-pub-ng-ub-rule-3" = {
        cidr_ipv4                    = "0.0.0.0/0"
        referenced_security_group_id = null
        from_port                    = "443"
        to_port                      = "443"
        ip_protocol                  = "tcp"
        ingress                      = true
      }
      "security-group-pub-ng-ub-rule-4" = {
        cidr_ipv4                    = "0.0.0.0/0"
        referenced_security_group_id = null
        from_port                    = "0"
        to_port                      = "0"
        ip_protocol                  = "-1"
        ingress                      = false
      }
    }
  }
  "security-group-pub-ng-al" = {
    description = "Security Group for Instance ng-al"
    rules = {
      "security-group-pub-ng-al-rule-1" = {
        cidr_ipv4                    = "0.0.0.0/0"
        referenced_security_group_id = null
        from_port                    = "2222"
        to_port                      = "2222"
        ip_protocol                  = "tcp"
        ingress                      = true
      }
      "security-group-pub-ng-al-rule-2" = {
        cidr_ipv4                    = "0.0.0.0/0"
        referenced_security_group_id = null
        from_port                    = "80"
        to_port                      = "80"
        ip_protocol                  = "tcp"
        ingress                      = true
      }
      "security-group-pub-ng-al-rule-3" = {
        cidr_ipv4                    = "0.0.0.0/0"
        referenced_security_group_id = null
        from_port                    = "443"
        to_port                      = "443"
        ip_protocol                  = "tcp"
        ingress                      = true
      }
      "security-group-pub-ng-al-rule-4" = {
        cidr_ipv4                    = "0.0.0.0/0"
        referenced_security_group_id = null
        from_port                    = "0"
        to_port                      = "0"
        ip_protocol                  = "-1"
        ingress                      = false
      }
    }
  }
}

network_acls = {
  "network-acl-pub" = {
    subnet_ids = ["subnet-pub-1a"]
    rules = {
      "network-acl-pub-rule-100" = {
        rule_number = "100"
        egress      = false
        protocol    = "tcp"
        rule_action = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 2222
        to_port     = 2222
      }
      "network-acl-pub-rule-101" = {
        rule_number = "101"
        egress      = true
        protocol    = "tcp"
        rule_action = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 2222
        to_port     = 2222
      }
      "network-acl-pub-rule-110" = {
        rule_number = "110"
        egress      = false
        protocol    = "tcp"
        rule_action = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 80
        to_port     = 80
      }
      "network-acl-pub-rule-111" = {
        rule_number = "111"
        egress      = true
        protocol    = "tcp"
        rule_action = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 80
        to_port     = 80
      }
      "network-acl-pub-rule-120" = {
        rule_number = "120"
        egress      = false
        protocol    = "tcp"
        rule_action = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 443
        to_port     = 443
      }
      "network-acl-pub-rule-121" = {
        rule_number = "121"
        egress      = true
        protocol    = "tcp"
        rule_action = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 443
        to_port     = 443
      }
      "network-acl-pub-rule-130" = {
        rule_number = "130"
        egress      = true
        protocol    = "tcp"
        rule_action = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 1024
        to_port     = 65535
      }
      "network-acl-pub-rule-131" = {
        rule_number = "131"
        egress      = false
        protocol    = "tcp"
        rule_action = "allow"
        cidr_block  = "0.0.0.0/0"
        from_port   = 1024
        to_port     = 65535
      }
    }
  }
}

nat_gateway_subnets = [
]

route_tables = {
  "route-table-pub" = {
    routes = {
      "route-pub-igw" = {
        destination_cidr_block = "0.0.0.0/0"
        gateway_id             = true
        nat_gateway_id         = null
      }
    }
  }
}

########################################
# nginx Module Variable Assignments
########################################
key_pairs = {
  "key-pair-01" = {
    key_name   = "aws-test-env-ed25519"
    public_key = "~/.ssh/aws-test-env-ed25519.pub"
  }
}

instances = {
  "ng-ub" = {
    ami                         = "ubuntu_22"
    instance_type               = "t2.micro"
    volume_size                 = 50
    associate_public_ip_address = true
    vpc_security_group_ids = [
      "security-group-pub-ng-ub"
    ]
    subnet_id     = "subnet-pub-1a"
    key_name      = "key-pair-01"
    http_tokens   = "required"
    ssh_ip        = "0.0.0.0/0"
    ssh_port      = "2222"
    domain_name   = "ng-ub2.example.com"
    certbot_email = "admin@example.com"
  }
  "ng-al" = {
    ami                         = "amazon_linux_2023"
    instance_type               = "t2.micro"
    volume_size                 = 50
    associate_public_ip_address = true
    vpc_security_group_ids = [
      "security-group-pub-ng-al"
    ]
    subnet_id     = "subnet-pub-1a"
    key_name      = "key-pair-01"
    http_tokens   = "required"
    ssh_ip        = "0.0.0.0/0"
    ssh_port      = "2222"
    domain_name   = "ng-al2.example.com"
    certbot_email = "admin@example.com"
  }
}

########################################
# Route53 Module Variable Assignments
########################################
zone_id = "XXXXXXXXXXXXXXXXXXXXX"

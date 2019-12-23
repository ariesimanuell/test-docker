variable "aws_access_key" {
  default = "AKIARYVWZUH5SVPSIO5Q"
}

variable "aws_secret_key" {
  default = "kPK0mZ5SMiX4bmWVUh6C1jeZM8Qyw0HcF8qn0sXc"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "ips" {
  default = {
    "1" = "172.28.0.5" #nginx
    "2" = "172.28.0.6" #elastic
  }
}

variable "vpcs" {
  default     = "172.28.0.0/16"
  description = "vpc test aries"
}

variable "Subnet-Publics" {
  default     = "172.28.0.0/24"
  description = "subnet test aries"
}

variable "key_name" {
  default = "testaries2"
}

variable "generate_ssh_key" {
  type    = bool
  default = true
}
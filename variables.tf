#variable "AWS_SECRET_KEY" {}

variable "location" {
  type            =  string
  description     = "The AWS Region to deploy resources"
  
  #validation {
   # error_message = "Unsupported Aws Region specified?"
  #}
}

variable "Security_Group" {
  type = list
  default = ["sg-24076", "sg-988776", "sg-776666"]
}


variable "AMIS" {
  type = map
  default = {
     us-east-1 = "ami-0f40c8f97004632f9"
     us-east-2 = "ami-05692172625678b4e"
     us-west-2 = "ami-0352d5a37fb4f603f"
     us-west-1 = "ami-0f40c8f97004632f9"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "levelup_key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "levelup_key.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

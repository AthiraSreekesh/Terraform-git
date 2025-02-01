variable "region" {
  description = "region name"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "env" {
  description = "environment name"
  type        = string
}

variable "owner" {
  description = "owner name"
  type        = string
}

variable "web_instance_type" {
  description = "web instance type"
  type        = string
}

variable "web_instance_ami" {
  description = "web instance ami"
  type        = string
}

variable "user_data_replacement" {
  description = "boolian to set user data replacement status"
  type        = bool
}

variable "user_data_file" {
  description = "name of the userdata file"
  type        = string
}
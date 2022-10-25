variable "vpc_cidr" {
  description = "IP address"
  default     = "10.0.0.0/16"
  type        = string
}

variable "sub_cidr" {
  description = "IP address"
  default     = "10.0.1.0/24"
  type        = string
}
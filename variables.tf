variable "tags" {
  type        = map(string)
  description = "Tags which are going to be attached to all resources"
  default     = {}
}

variable "prefix" {
  type        = string
  description = "Prefix to all resources in the module"
  default = "cmeg-stage"
}

variable "int_subnets" {
  type        = map(string)
  default     = {}
  description = "CIDR blocks for subnets"
}

variable "lb_subnets" {
  type        = map(string)
  default     = {}
  description = "CIDR blocks for subnets"
}

variable "vpn_subnets" {
  type        = map(string)
  default     = {}
  description = "CIDR blocks for subnets"
}

variable "eks_subnets" {
  type        = map(string)
  default     = {}
  description = "CIDR blocks for subnets"
}

variable "dbs_subnets" {
  type        = map(string)
  default     = {}
  description = "CIDR blocks for subnets"
}

variable "pub_subnets" {
  type        = map(string)
  default     = {}
  description = "CIDR blocks for subnets"
}


##############################################################
variable "internal_subnet_tags" {
  type        = map(string)
  description = "Tags which are going to be attached to internal subnets"
  default     = {}
}

variable "db_subnet_tags" {
  type        = map(string)
  description = "Tags which are going to be attached to db subnets"
  default     = {}
}

variable "vpn_subnet_tags" {
  type        = map(string)
  description = "Tags which are going to be attached to vpn subnets"
  default     = {}
}

variable "lb_subnet_tags" {
  type        = map(string)
  description = "Tags which are going to be attached to lb subnets"
  default     = {}
}

variable "eks_subnet_tags" {
  type        = map(string)
  description = "Tags which are going to be attached to to eks subnets"
  default     = {}
}

variable "public_subnet_tags" {
  type        = map(string)
  description = "Tags which are going to be attached to all public subnets"
  default     = {}
}

variable "vpc_tags" {
  type        = map(string)
  description = "Tags which are going to be attached to VPC resource only"
  default     = {}
}

########################################
variable "enable_dns_hostnames" {
  type        = bool
  default     = false
  description = "Enable/disable DNS Hostnames in the VPC"
}

variable "enable_dns_support" {
  type        = bool
  default     = true
  description = "Enable/disable DNS Support in the VPC"
}


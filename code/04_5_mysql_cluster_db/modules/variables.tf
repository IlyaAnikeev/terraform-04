variable "HA" {
  description = "false - single node, true - high availability hosts."
  type    = bool
  default = true
}

variable "no_change" {
  description = "no change variable"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of MySQL cluster"
  type        = string
  default     = "managed"
}

variable "environment" {
  description = "Environment type: PRODUCTION or PRESTABLE"
  type        = string
  default     = "PRESTABLE"
  validation {
    condition     = contains(["PRODUCTION", "PRESTABLE"], var.environment)
    error_message = "Release channel should be PRODUCTION (stable feature set) or PRESTABLE (early bird feature access)."
  }
}

variable "mysql_version" {
  description = "MySQL version"
  type        = string
  default     = "8.0"
  validation {
    condition     = contains(["5.7", "8.0"], var.mysql_version)
    error_message = "Allowed MySQL versions are 5.7, 8.0."
  }
}

variable "disk_size" {
  description = "Disk size for hosts"
  type        = number
  default     = 10
}

variable "disk_type" {
  description = "Disk type for hosts"
  type        = string
  default     = "network-ssd"
}

variable "resource_preset_id" {
  description = "Preset for hosts"
  type        = string
  default     = "s2.micro"
}

variable "no_high_availability" {
  description = "A list of MySQL no high availability hosts."

  type = list(object({
    name                    = optional(string, null)
    zone                    = string
    subnet_id               = optional(string, null)
    assign_public_ip        = optional(bool, false)
    replication_source_name = optional(string, null)
    priority                = optional(number, null)
    backup_priority         = optional(number, null)
  }))
  default = [
    {
    name                    = "MASTER"
    zone                    = "ru-central1-a"
    assign_public_ip        = true
    }
  ]
}

variable "yes_high_availability" {
  description = "A list of MySQL yes high availability hosts."

  type = list(object({
    name                    = optional(string, null)
    zone                    = string
    subnet_id               = optional(string, null)
    assign_public_ip        = optional(bool, false)
    replication_source_name = optional(string, null)
    priority                = optional(number, null)
    backup_priority         = optional(number, null)
  }))
  default = [
    {
    name                    = "MASTER"
    zone                    = "ru-central1-a"
    assign_public_ip        = true
    },
    {
    name                    = "REPLICA"
    zone                    = "ru-central1-b"
    replication_source_name = "MASTER"
    assign_public_ip        = true
    }
  ]
}

variable "network_name" {
  type    = string
  default = "managed_net"
}

variable "subnet_a_name" {
  type    = string
  default = "managed_subnet-a"
}

variable "subnet_a_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "subnet_a_cidr" {
  type    = list(string)
  default = ["10.5.0.0/24"]
}

variable "subnet_b_name" {
  type    = string
  default = "managed_subnet-b"
}

variable "subnet_b_zone" {
  type    = string
  default = "ru-central1-b"
}

variable "subnet_b_cidr" {
  type    = list(string)
  default = ["10.6.0.0/24"]
}

variable "managed_sg_name" {
  type    = string
  default = "managed-sg"
}

variable "sg_ingress_description" {
  type    = string
  default = "MySQL"
}

variable "sg_ingress_port" {
  type    = number
  default = 3306
}

variable "sg_ingress_protocol" {
  type    = string
  default = "TCP"
}

variable "sg_ingress_cidr" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "db_name" {
  type = string
  default = "test"
}

variable "user_name" {
  type = string
  default = "app"
}

variable "user_password" {
  type = any
  default = "app1app1"
}
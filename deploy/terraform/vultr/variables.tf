# variables.tf

variable "vultr_api_key" {
  description = ""
  type        = string
  sensitive   = true
}

variable "region" {
  description = "The Vultr region to deploy the instance in"
  type        = string
  default     = "fr"
}

variable "os_id" {
  description = "The ID of the operating system to install (e.g., a recent Ubuntu LTS ID)."
  type        = number
  default     = 2284
}

variable "instance_label" {
  description = "A label for your Vultr instance."
  type        = string
  default     = "cheapest-terraform-instance"
}

variable "plan_id" {
  description = "The ID of the Vultr plan. 'vc2-1c-1gb' is typically the cheapest standard instance with IPv4."
  type        = string
  default     = "vc2-1c-1gb" # 1 vCPU, 1GB RAM - Check Vultr pricing for the absolute cheapest available plan ID
}
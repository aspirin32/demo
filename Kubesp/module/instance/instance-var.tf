variable "instance_family_image" {
  description = "Instance image"
  type        = string
  default     = "lamp"
}
#define subnet
variable "subnet_mtfk" {
  type = string
}
#zone name for instances
variable "zone_name" {
  type = string
}

#name of nodes
variable "module_name" {
  type = string
}
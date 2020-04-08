variable "context" {
  type = map(string)
  default = {
    project_name          = null
    environment           = null
    resource_group_name   = null
    resource_location     = null
  }
}

variable "has_default_subnet" {
  type = bool
  description = "(Optional) Whether to create a default subnet. It default to 'true'."
  default = true
}
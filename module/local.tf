locals {
  project_name          = "virtual-bed"
  environment           = terraform.workspace
  project_env           = "${local.project_name}-${local.environment}"
  context = {
    project_name          = local.project_name
    environment           = local.environment
    resource_group_name   = var.resource_group_name
    resource_location     = var.resource_location    
  }
}
variable "checklist" {
  type        = list(string)
  description = "Override BES Console provisioning checklist"
  default     = []
}

variable "cluster_name" {
  type        = string
  description = "Intended BES cluster name (documentation only)"
  default     = "demo-bes"
}

variable "project" {
  type        = string
  description = "Project name"
  default     = "baiducloud-modules"
}

variable "environment" {
  type        = string
  description = "Environment name"
  default     = "development"
}

variable "tags" {
  type        = map(string)
  description = "Intended tags for Console-created BES resources"
  default     = {}
}

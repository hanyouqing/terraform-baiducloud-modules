variable "checklist" {
  type        = list(string)
  description = "Override Kafka Console provisioning checklist"
  default     = []
}

variable "cluster_name" {
  type        = string
  description = "Intended Kafka cluster name (documentation / naming convention only)"
  default     = "demo-kafka"
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
  description = "Intended tags for Console-created Kafka resources"
  default     = {}
}

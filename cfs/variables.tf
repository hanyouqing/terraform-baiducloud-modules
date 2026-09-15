variable "file_systems" {
  type = map(object({
    name     = string
    protocol = optional(string, "nfs")
    type     = optional(string, "cap")
    zone     = optional(string, null)
  }))
  description = "Map of CFS file systems"
  default     = {}

  validation {
    condition = alltrue([
      for f in var.file_systems : contains(["nfs", "smb"], f.protocol)
    ])
    error_message = "protocol must be nfs or smb."
  }
}

variable "mount_targets" {
  type = map(object({
    fs_key    = string
    vpc_id    = string
    subnet_id = string
  }))
  description = "Map of CFS mount targets referencing file_systems keys"
  default     = {}
}

variable "project" {
  type        = string
  description = "Project name for tagging"
  default     = "baiducloud-modules"
}

variable "environment" {
  type        = string
  description = "Environment name for tagging"
  default     = "development"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags to apply to all resources"
  default     = {}
}

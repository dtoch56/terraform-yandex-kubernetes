variable "cloud_id" {
  description = "Cloud that the Folder belongs to"
  type        = string
}

variable "folder_name" {
  description = "Name of the Folder"
  type        = string
}

variable "folder_description" {
  description = "A description of the Folder"
  type        = string
  default     = ""
}

variable "folder_labels" {
  description = "A set of key/value label pairs to assign to the Folder"
  type        = map(string)
  default = {
    managed-by = "terraform"
  }
}

variable "admin_roles" {
  description = "Admin user roles in the Folder"
  type        = list(string)
  default = [
    "admin",
    "storage.admin"
  ]
}

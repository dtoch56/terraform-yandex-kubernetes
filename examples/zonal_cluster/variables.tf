variable "folder_id" {
  description = "Folder that the Kubernetes cluster belongs to"
  type        = string
}

variable "network_id" {
  description = "Network that the Kubernetes cluster belongs to"
  type        = string
}

variable "master_locations" {
  description = ""
  type = list(object({
    subnet_id = string
    zone      = string
  }))
}

variable "project" {
  description = "Project ID"
}

variable "region" {
  description = "Region"
  default     = "europe-north1"
}

variable "zone" {
  description = "Region"
  default     = "europe-north1-c"
}

variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}

variable "machine_type" {
  default = "g1-small"
}

variable "disk_size_gb" {
  default = "20"
}

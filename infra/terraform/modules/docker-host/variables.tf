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

variable "private_key_path" {
  description = "Path to the private key used for ssh access"
  default     = "~/.ssh/appuser"
}

variable "disk_image" {
  description = "Disk image for reddit app"
}

variable "instance_count" {
  description = "Number of instances"
  default     = 1
}

variable "machine_type" {
  description = "Type of a virtual machine"
  default = "custom-1-3840" # 1 CPU, 3.75 GB RAM
}

variable "disk_size" {
  description = "Disk size"
  default = 100
}

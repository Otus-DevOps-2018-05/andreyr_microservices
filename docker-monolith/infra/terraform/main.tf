provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "docker-host" {
  source          = "modules/docker-host"
  public_key_path = "${var.public_key_path}"
  disk_image      = "${var.disk_image}"
  project         = "${var.project}"
}

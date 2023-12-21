terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}

module "managed" {
  source = "./modules"
  name   = "example"
}



# module "maneged" {
#   source = "git::https://github.com/terraform-yc-modules/terraform-yc-mysql.git"
# }

# module "VPC" {
#   source = "git::https://github.com/terraform-yc-modules/terraform-yc-vpc.git"
# }

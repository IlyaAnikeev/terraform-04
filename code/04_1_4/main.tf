terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"

  backend "s3" {
  endpoint = "storage.yandexcloud.net"
  bucket   = "terraform-05"
  region   = "ru-central1"
  key      = "terraform.tfstate"

  skip_region_validation      = true
  skip_credentials_validation = true

    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1g6mu0kpg153l24a7o9/etnu1q2d590vfcfc61e9"
    dynamodb_table    = "terraform-05-lock"
}
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}

module "vpc_prod" {
  source       = "./vpc"
  env_name     = var.env_name_prod
  subnets = [
    { zone = var.zone_a, cidr = var.cidr_a },
    { zone = var.zone_b, cidr = var.cidr_b },
    { zone = var.zone_c, cidr = var.cidr_c },
  ]
}

module "vpc_dev" {
  source       = "./vpc"
  env_name     = var.env_name_dev
  subnets = [
    { zone = var.zone_a, cidr = var.cidr_a },
  ]
}

module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = var.env_name_vm
  network_id      = module.vpc_dev.network_id
  subnet_zones    = [var.test_vm_subnet_zones]
  subnet_ids      = [module.vpc_dev.subnet_id]
  instance_name   = var.test_vm_instance_name
  instance_count  = var.test_vm_instance_count
  image_family    = var.test_vm_image_family
  public_ip       = var.test_vm_public_ip
  
  metadata = {
      user-data          = data.template_file.cloudinit.rendered
      serial-port-enable = var.test_vm_serial_port
  }

}

data "template_file" "cloudinit" {
 template = file("./cloud-init.yml")
 vars = {
  ssh_authorized_keys = file(var.ssh_authorized_keys[0])
 }
}



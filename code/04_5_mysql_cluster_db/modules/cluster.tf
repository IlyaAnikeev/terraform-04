terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

resource "yandex_mdb_mysql_cluster" "managed" {
  name                      = var.name
  environment               = var.environment
  network_id                = yandex_vpc_network.managed_net.id
  version                   = var.mysql_version
  security_group_ids        = [yandex_vpc_security_group.managed-sg.id]

  resources {
    disk_size          = var.disk_size
    disk_type_id       = var.disk_type
    resource_preset_id = var.resource_preset_id
    }

  dynamic "host" {
    for_each = var.HA == var.no_change ? var.yes_high_availability : var.no_high_availability
    content {
      name                    = host.value.name
      zone                    = host.value.zone
      subnet_id               = host.value.subnet_id
      assign_public_ip        = host.value.assign_public_ip
      priority                = host.value.priority
      replication_source_name = host.value.replication_source_name
    }
  }
}
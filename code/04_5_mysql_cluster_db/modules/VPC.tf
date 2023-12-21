resource "yandex_vpc_network" "managed_net" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "managed_subnet-a" {
  name             = var.subnet_a_name
  zone             = var.subnet_a_zone
  network_id       = yandex_vpc_network.managed_net.id
  v4_cidr_blocks   = var.subnet_a_cidr
}

resource "yandex_vpc_subnet" "managed_subnet-b" {
  name             = var.subnet_b_name
  zone             = var.subnet_b_zone
  network_id       = yandex_vpc_network.managed_net.id
  v4_cidr_blocks   = var.subnet_b_cidr
}

resource "yandex_vpc_security_group" "managed-sg" {
  name       = var.managed_sg_name
  network_id = yandex_vpc_network.managed_net.id

  ingress {
    description    = var.sg_ingress_description
    port           = var.sg_ingress_port
    protocol       = var.sg_ingress_protocol
    v4_cidr_blocks = var.sg_ingress_cidr
  }
}
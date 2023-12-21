output "cluster_id" {
  description = "MySQL cluster ID"
  value       = yandex_mdb_mysql_cluster.managed.id
}

output "cluster_name" {
  description = "MySQL cluster name"
  value       = yandex_mdb_mysql_cluster.managed.name
}

output "cluster_host_names_list" {
  description = "MySQL cluster host name"
  value       = [yandex_mdb_mysql_cluster.managed.host[*].name]
}

output "cluster_fqdns_list" {
  description = "MySQL cluster nodes FQDN list"
  value       = [yandex_mdb_mysql_cluster.managed.host[*].fqdn]
}

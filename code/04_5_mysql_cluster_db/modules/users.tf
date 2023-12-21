resource "yandex_mdb_mysql_user" "app" {
  cluster_id = yandex_mdb_mysql_cluster.managed.id
  name       = var.user_name
  password   = var.user_password
  permission {
    database_name = yandex_mdb_mysql_database.database.name
    roles         = ["ALL"]
  }
}

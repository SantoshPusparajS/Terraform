resource "azurerm_mysql_server" "mysql_server" {
  name                = "santoshpusparaj-mysql-database"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  administrator_login          = var.db_username
  administrator_login_password = var.db_password

  threat_detection_policy {
    enabled              = var.threat_detection_policy.enabled
    retention_days       = var.threat_detection_policy.retention_days
    email_account_admins = var.threat_detection_policy.email_account_admins
    email_addresses      = var.threat_detection_policy.email_addresses
  }

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "8.0"

  auto_grow_enabled                 = var.auto_grow_enabled_value
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = false
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

resource "azurerm_mysql_database" "webapp1" {
  name                = "santosh-database-210996"
  resource_group_name = azurerm_resource_group.rg1.name
  server_name         = azurerm_mysql_server.mysql_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

terraform {
  backend "azurerm" {
    resource_group_name = "terraform"
    storage_account_name = "aksstorage133"
    container_name = "mysqldb"
    key = "terraform.storage"
    access_key = "/A9PC0WvT1MuEjSyXUinlAsNh2Pbd/4EilmLy0D5LkREyLsejjLR/vtGVD1kRjggERK4HMtlu4CT+AStJVLMQw=="
  }
}

module "mysql" {
  source = "../module"

  mysql_server_name          = "prasanna125-mysql-server"
  location                   = "CentralUS"
  resource_group_name        = "prasannarg"
  sku_name                   = "GP_Gen5_2"
  storage_mb                 = 5120
  backup_retention_days      = 7
  geo_redundant_backup_enabled = false
  administrator_login        = "mysqladmin"
  administrator_login_password = "P@ssw0rd1234"
  mysql_version              = "5.7"
  mysql_database_name        = "my-database"
  charset                    = "utf8"
  collation                  = "utf8_general_ci"
}
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.2"
    }
  }
}
provider "azurerm" {
    features {
      
    }

    subscription_id = "f7dc3993-a2d6-49b6-9487-8c666d279526"
    client_id = "35f80453-c405-4f14-9952-321d16ea4365"
    tenant_id = "9c20cfa0-82a9-46e8-953a-5c5642eb19c4"
    client_secret = "Est8Q~aaVBEWtSS-DpzAvAtRJbRu-n1fYwjX3aS4"  
}

resource "azurerm_mysql_server" "example" {
  name                = var.mysql_server_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  ssl_enforcement_enabled = true

  storage_mb            = var.storage_mb
  backup_retention_days = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled


  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  version = var.mysql_version
}

resource "azurerm_mysql_database" "example" {
  name                = var.mysql_database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.example.name
  charset             = var.charset
  collation           = var.collation
}
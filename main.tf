// Tags
locals {
  tags = {
    class      = var.tag_class
    instructor = var.tag_instructor
    semester   = var.tag_semester
  }
}

// Random Suffix Generator
resource "random_integer" "deployment_id_suffix" {
  min = 100
  max = 999
}

// Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.class_name}-${var.student_name}-${var.environment}-${var.location}-${random_integer.deployment_id_suffix.result}"
  location = var.location

  tags = local.tags
}

// Storage Account
resource "azurerm_storage_account" "storage" {
  name                = "sto${var.class_name}${var.student_name}${var.environment}${random_integer.deployment_id_suffix.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = true

  tags = local.tags

  network_rules {
    default_action             = "Deny"
    ip_rules                   = ["100.0.0.1"]
    virtual_network_subnet_ids = [azurerm_subnet.subnet.id]
  }
}

// Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.class_name}-${var.student_name}-${var.environment}-${var.location}-${random_integer.deployment_id_suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  address_space = ["10.0.0.0/16"]

  tags = local.tags
}

// Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "snet-${var.class_name}-${var.student_name}-${var.environment}-${var.location}-${random_integer.deployment_id_suffix.result}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes = ["10.0.1.0/24"]

  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.Sql"
  ]
}

// SQL Server
resource "azurerm_mssql_server" "sql" {
  name                = "sql-${var.class_name}-${var.student_name}-${var.environment}-${var.location}-${random_integer.deployment_id_suffix.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  version             = "12.0"

  administrator_login          = "sampleuser"
  administrator_login_password = "Hg2fhj4rf%%r2"

  minimum_tls_version           = "1.2"
  public_network_access_enabled = true

  tags = local.tags
}

// SQL Database 
resource "azurerm_mssql_database" "db" {
  name      = "sqldb-${var.class_name}-${var.student_name}-${var.environment}-${random_integer.deployment_id_suffix.result}"
  server_id = azurerm_mssql_server.sql.id

  sku_name    = "basic"
  max_size_gb = 2

  tags = local.tags
}

// SQL VNet Rule 
resource "azurerm_mssql_virtual_network_rule" "sql_vnet_rule" {
  name      = "sql-vnet-rule"
  server_id = azurerm_mssql_server.sql.id
  subnet_id = azurerm_subnet.subnet.id
}

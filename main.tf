
terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = ">= 2.80.0"
        }
    }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {

    features {}
}
# Create a resource group
module "rg" {
    source = "./modules/rg"
    name = var.name
    location = var.location
}

# Create an Azure IoT Hub
module "iot_hub" {
  source = "./modules/iot_hub"
  resourcegroup = module.rg.resource_group_name
  location = module.rg.location_id
}






/*
resource "azurerm_resource_group" "IOT" {
  name     = "IOT-resources"
  location = "West Europe"
}

resource "azurerm_storage_account" "IOT" {
  name                     = "iotstoragetestcase"
  resource_group_name      = azurerm_resource_group.IOT.name
  location                 = azurerm_resource_group.IOT.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "IOT" {
  name                  = "iotcontainer"
  storage_account_name  = azurerm_storage_account.IOT.name
  container_access_type = "private"
}

resource "azurerm_eventhub_namespace" "IOT" {
  name                = "IOT-namespace"
  resource_group_name = azurerm_resource_group.IOT.name
  location            = azurerm_resource_group.IOT.location
  sku                 = "Basic"
}

resource "azurerm_eventhub" "IOT" {
  name                = "IOT-eventhub"
  resource_group_name = azurerm_resource_group.IOT.name
  namespace_name      = azurerm_eventhub_namespace.IOT.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_authorization_rule" "IOT" {
  resource_group_name = azurerm_resource_group.IOT.name
  namespace_name      = azurerm_eventhub_namespace.IOT.name
  eventhub_name       = azurerm_eventhub.IOT.name
  name                = "acctest"
  send                = true
}

resource "azurerm_iothub" "IOT" {
  name                = "IOT-IoTHub-testcase"
  resource_group_name = azurerm_resource_group.IOT.name
  location            = azurerm_resource_group.IOT.location

  sku {
    name     = "S1"
    capacity = 1
  }

  endpoint {
    type                       = "AzureIotHub.StorageContainer"
    connection_string          = azurerm_storage_account.IOT.primary_blob_connection_string
    name                       = "export"
    batch_frequency_in_seconds = 60
    max_chunk_size_in_bytes    = 10485760
    container_name             = azurerm_storage_container.IOT.name
    encoding                   = "Avro"
    file_name_format           = "{iothub}/{partition}_{YYYY}_{MM}_{DD}_{HH}_{mm}"
  }

  endpoint {
    type              = "AzureIotHub.EventHub"
    connection_string = azurerm_eventhub_authorization_rule.IOT.primary_connection_string
    name              = "export2"
  }

  route {
    name           = "export"
    source         = "DeviceMessages"
    condition      = "true"
    endpoint_names = ["export"]
    enabled        = true
  }

  route {
    name           = "export2"
    source         = "DeviceMessages"
    condition      = "true"
    endpoint_names = ["export2"]
    enabled        = true
  }

  enrichment {
    key            = "tenant"
    value          = "$twin.tags.Tenant"
    endpoint_names = ["export", "export2"]
  }

  tags = {
    purpose = "testing"
  }
}
data "azurerm_iothub_shared_access_policy" "iot_policy" {
  name                = "iot-policy"
  resource_group_name = azurerm_resource_group.IOT.name
  iothub_name         = azurerm_iothub.IOT.name

  #registry_read  = true
  #registry_write = true
}

resource "azurerm_iothub_dps" "IOT" {
  name                = "iottestdps"
  resource_group_name = azurerm_resource_group.IOT.name
  location            = azurerm_resource_group.IOT.location
  #allocation_policy   = "Hashed"

  sku {
    name     = "S1"
    capacity = 1
  }


    linked_hub {
        connection_string = data.azurerm_iothub_shared_access_policy.iot_policy.primary_connection_string
        location = azurerm_iothub.IOT.location
    }
    
} 


*/



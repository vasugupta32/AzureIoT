resource "azurerm_iothub" "qwert-IoT-Hub" {
    name                = "qwert-IoT-Hub"
    resource_group_name = var.resourcegroup
    location            = var.location

    sku {
        name     = "S1"
        capacity = 1
    }
}

data "azurerm_iothub_shared_access_policy" "qwert-iothubowner" {
    name                = "qwert-iothubowner"
    resource_group_name = var.resourcegroup
    iothub_name         = azurerm_iothub.qwert-IoT-Hub.name
}

# Create a Device Provisioning Service
resource "azurerm_iothub_dps" "qwert-dps" {
    name                = "qwert-dps"
    resource_group_name = var.resourcegroup
    location            = var.location

    sku {
        name     = "S1"
        capacity = 1
    }

    linked_hub {
        connection_string = data.azurerm_iothub_shared_access_policy.qwert-iothubowner.primary_connection_string
        location = var.location
        #location = azurerm_iothub.qwert-IoT-Hub.location
    }
}
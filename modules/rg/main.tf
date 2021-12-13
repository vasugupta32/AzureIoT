# Create a resource group
resource "azurerm_resource_group" "qwert_IoT_RG" {
  name     = var.name
  location = var.location
}
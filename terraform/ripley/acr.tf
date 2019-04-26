// Creación del Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                     = "RipleyContainerRegistry"
  resource_group_name      = "ripleyRG"
  location                 = "${var.location}"
  sku                      = "Premium"
  admin_enabled            = false
  georeplication_locations = ["East US"]
}
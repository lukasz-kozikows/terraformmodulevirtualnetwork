

resource "azurerm_network_security_group" "secgr" {
  name                = "example-security-group"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_network" "lkvn" {
  name                = "example-network"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/24"]
  subnet {
    name           = "subnet2"
    address_prefix = "10.0.0.0/25"
    security_group = azurerm_network_security_group.secg.id
  }

}
resource "azurerm_network_security_group" "secg" {
  name                = "lkoz-secgr-tf-test"
  location            = var.location
  resource_group_name = var.resource_group_name
  
}

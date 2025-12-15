# -------------------------
# Resource Group (Root)
# -------------------------
resource "azurerm_resource_group" "rg" {
  name     = "myTFResourceGroup"
  location = "East US 2"
}

# -------------------------
# Network Module
# -------------------------
module "network" {
  source = "./modules/network"

  environment = var.environment

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  vnet_name          = "myTFVNet2"
  vnet_address_space = ["10.0.0.0/16"]
  subnet_name        = "myTFSubnet"
  subnet_prefix      = ["10.0.1.0/24"]
  nsg_name           = "myTFNSG"
}

# -------------------------
# VM Module
# -------------------------
module "vm" {
  source = "./modules/vm"

  environment = var.environment

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  vm_name        = "myTFVM"
  nic_name       = "myTFNic"
  vm_size        = "Standard_D2_v3"
  admin_username = "azureuser"
  admin_password = var.admin_password

  subnet_id    = module.network.subnet_id
  public_ip_id = module.network.public_ip_id
}

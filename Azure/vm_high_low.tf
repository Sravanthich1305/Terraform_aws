provider "azurerm" {
  features = {}
}

# Define the existing VNet and subnet
data "azurerm_virtual_network" "existing_vnet" {
  name                = "existing-vnet"
  resource_group_name = "your-resource-group-name"
}

data "azurerm_subnet" "existing_subnet" {
  name                 = "subnet1"
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  resource_group_name  = "your-resource-group-name"
}

# Define the low-performance VM
resource "azurerm_virtual_machine" "low_perf_vm" {
  name                  = "low-perf-vm"
  resource_group_name   = "your-resource-group-name"
  location              = data.azurerm_virtual_network.existing_vnet.location
  size                  = "Standard_B1s"  # Low-performance VM size
  network_interface_ids = [azurerm_network_interface.low_perf_nic.id]

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_profile {
    computer_name  = "lowperfvm"
    admin_username = "adminuser"
    admin_password = "Admin123!#"
  }

  os_profile_windows_config {
    enable_automatic_upgrades = false
  }
}

# Define the high-performance VM
resource "azurerm_virtual_machine" "high_perf_vm" {
  name                  = "high-perf-vm"
  resource_group_name   = "your-resource-group-name"
  location              = data.azurerm_virtual_network.existing_vnet.location
  size                  = "Standard_DS2_v2"  # High-performance VM size
  network_interface_ids = [azurerm_network_interface.high_perf_nic.id]

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_profile {
    computer_name  = "highperfvm"
    admin_username = "adminuser"
    admin_password = "Admin123!#"
  }

  os_profile_windows_config {
    enable_automatic_upgrades = false
  }
}

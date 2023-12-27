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
resource "azurerm_network_interface" "low_perf_nic" {
  name                = "low-perf-nic"
  resource_group_name = "your-resource-group-name"

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.existing_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "low_perf_vm" {
  name                  = "low-perf-vm"
  resource_group_name   = "your-resource-group-name"
  location              = data.azurerm_virtual_network.existing_vnet.location
  network_interface_ids = [azurerm_network_interface.low_perf_nic.id]

  vm_size              = "Standard_B1s"  # Low-performance VM size
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "low-perf-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
}

# Define the high-performance VM
resource "azurerm_network_interface" "high_perf_nic" {
  name                = "high-perf-nic"
  resource_group_name = "your-resource-group-name"

  ip_configuration {
    name                          = "ipconfig2"
    subnet_id                     = data.azurerm_subnet.existing_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "high_perf_vm" {
  name                  = "high-perf-vm"
  resource_group_name   = "your-resource-group-name"
  location              = data.azurerm_virtual_network.existing_vnet.location
  network_interface_ids = [azurerm_network_interface.high_perf_nic.id]

  vm_size              = "Standard_DS2_v2"  # High-performance VM size
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "high-perf-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }
}

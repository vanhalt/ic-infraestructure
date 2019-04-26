# Configure the provider
provider "azurerm" {
    version = "=1.20.0"
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
    name     = "${var.prefix}TFRG"
    location = "${var.location}"
    tags     = "${var.tags}"
}

# Create virtual network
resource "azurerm_virtual_network" "vnet" {
    name                = "${var.prefix}TFVnet"
    address_space       = ["10.0.0.0/16"]
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    tags                = "${var.tags}"
}

# Create subnet
resource "azurerm_subnet" "subnet" {
    name                 = "${var.prefix}TFSubnet"
    resource_group_name  = "${azurerm_resource_group.rg.name}"
    virtual_network_name = "${azurerm_virtual_network.vnet.name}"
    address_prefix       = "10.0.1.0/24"
}

# Create public IP
resource "azurerm_public_ip" "publicip" {
    name                         = "${var.prefix}TFPublicIP"
    location                     = "${var.location}"
    resource_group_name          = "${azurerm_resource_group.rg.name}"
    public_ip_address_allocation = "dynamic"
    tags                         = "${var.tags}"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "nsg" {
    name                = "${var.prefix}TFNSG"
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    tags                = "${var.tags}"

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "HTTP"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "HTTPS"
        priority                   = 1003
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

# Create network interface
resource "azurerm_network_interface" "nic" {
    name                      = "${var.prefix}NIC"
    location                  = "${var.location}"
    resource_group_name       = "${azurerm_resource_group.rg.name}"
    network_security_group_id = "${azurerm_network_security_group.nsg.id}"
    tags                      = "${var.tags}"

    ip_configuration {
        name                          = "${var.prefix}NICConfg"
        subnet_id                     = "${azurerm_subnet.subnet.id}"
        private_ip_address_allocation = "dynamic"
        public_ip_address_id          = "${azurerm_public_ip.publicip.id}"
    }
}

# Create a Linux virtual machine
resource "azurerm_virtual_machine" "vm" {
    name                  = "${var.prefix}TFVM"
    location              = "${var.location}"
    resource_group_name   = "${azurerm_resource_group.rg.name}"
    network_interface_ids = ["${azurerm_network_interface.nic.id}"]
    vm_size               = "Standard_DS1_v2"
    tags                  = "${var.tags}"

    storage_os_disk {
        name              = "${var.prefix}OsDisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "${lookup(var.sku, var.location)}"
        version   = "latest"
    }

    os_profile {
        computer_name  = "${var.prefix}TFVM"
        admin_username = "${var.username}"
        admin_password = "vanhaltTheMaster1234"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    # Provisionar para instalar Drone CI: Instala docker
    provisioner "file" {
        source      = "bin/install_docker.sh"
        destination = "/tmp/install_docker.sh"

        connection {
            type     = "ssh"
            user     = "${var.username}"
            password = "vanhaltTheMaster1234"
        }
    }

    provisioner "remote-exec" {
        inline = [
        "chmod +x /tmp/install_docker.sh",
        "sudo /tmp/install_docker.sh ${var.username}"
        ]

        connection {
            type     = "ssh"
            user     = "${var.username}"
            password = "vanhaltTheMaster1234"
        }
    }

    provisioner "file" { # copia script para correr docker CI
        source      = "bin/run_droneci.sh"
        destination = "/home/${var.username}/run_droneci.sh"

        connection {
            type     = "ssh"
            user     = "${var.username}"
            password = "vanhaltTheMaster1234"
        }
    }
}

output "ip" {
    value = "${azurerm_public_ip.publicip.ip_address}"
}

output "os_sku" {
    value = "${lookup(var.sku, var.location)}"
}


rg = {
  rg1 = {
    name     = "dev-rg1"
    location = "southafricanorth"
  }
}

vnet = {
  vnet1 = {
    name                = "dev-vnet1"
    address_space       = ["10.0.0.0/16"]
    location            = "southafricanorth"
    resource_group_name = "dev-rg1"
  }
}


subnets = {
  frontend = {
    name                 = "frontend-subnet"
    resource_group_name  = "dev-rg1"
    virtual_network_name = "dev-vnet1"
    address_prefixes     = ["10.0.1.0/24"]
  }

  backend = {
    name                 = "backend-subnet"
    resource_group_name  = "dev-rg1"
    virtual_network_name = "dev-vnet1"
    address_prefixes     = ["10.0.2.0/24"]
  }
}

nsgs = {
  nsg1 = {
    name                = "dev-nsg1"
    location            = "southafricanorth"
    resource_group_name = "dev-rg1"
  }
}

nsg_rules = {
  rule1 = {
    name                        = "Allow-HTTP"
    priority                    = 100
    destination_port_range      = "80"
    resource_group_name         = "dev-rg1"
    network_security_group_name = "dev-nsg1"
  }

  rule2 = {
    name                        = "Allow-SSH"
    priority                    = 110
    destination_port_range      = "22"
    resource_group_name         = "dev-rg1"
    network_security_group_name = "dev-nsg1"
  }
}

nsg_associations = {
  frontend_nsg_assoc = {
    subnet_key = "frontend"
    nsg_key    = "nsg1"
  }

  backend_nsg_assoc = {
    subnet_key = "backend"
    nsg_key    = "nsg1"
  }
}

public_ip = {
  pip1 = {
    name                = "dev-pip1"
    location            = "southafricanorth"
    resource_group_name = "dev-rg1"
    allocation_method   = "Static"
  }
}

nic = {
  nic1 = {
    name                = "dev-nic1"
    location            = "southafricanorth"
    resource_group_name = "dev-rg1"
    ip_config_name      = "internal"
    subnet_key          = "frontend"
    public_ip_key       = "pip1"
  }

  nic2 = {
    name                = "dev-nic2"
    location            = "southafricanorth"
    resource_group_name = "dev-rg1"
    ip_config_name      = "internal"
    subnet_key          = "backend"
    
  }
}

vm = {
  vm1 = {
    location            = "southafricanorth"
    resource_group_name = "dev-rg1"
    size                = "Standard_B2ats_v2"
    admin_username      = "azureuser"
    nic_key             = "nic1"
  }

  vm2 = {
    location            = "southafricanorth"
    resource_group_name = "dev-rg1"
    size                = "Standard_B2ats_v2"
    admin_username      = "azureuser"
    nic_key             = "nic2"
  }

}

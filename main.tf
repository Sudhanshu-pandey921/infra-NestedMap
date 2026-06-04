data "azurerm_key_vault" "kv" {
  name = "kv-pandey"
  resource_group_name = "secret-rg"
}

data "azurerm_key_vault_secret" "vm_name" {
  name         = "vm-name"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "vm_password" {
  name         = "vm-password"
  key_vault_id = data.azurerm_key_vault.kv.id
}






module "rg" {
  source = "./modules/resource-group"
  rg = var.rg
}

module "vnet" {
  source = "./modules/vnet"
  vnet   = var.vnet

  depends_on = [module.rg]
}

module "subnet" {
  source = "./modules/subnet"
  subnets = var.subnets

  depends_on = [module.vnet]
}

module "nsg" {
  source = "./modules/nsg"
  nsgs    = var.nsgs
  nsg_rules = var.nsg_rules

  depends_on = [module.rg]
}

module "nsg_rule" {
  source = "./modules/nsg-association"
  nsg_associations = {
    for key, assoc in var.nsg_associations : key => {
      subnet_id                     = module.subnet.subnet_id[assoc.subnet_key]
      network_security_group_id     = module.nsg.nsg_id[assoc.nsg_key]
    }
  }

  depends_on = [module.nsg, module.subnet]
}

module "pip" {
  source = "./modules/public-ip"
  public_ip = var.public_ip

  depends_on = [module.rg]
}

module "vm" {
  source = "./modules/vm"
  
  nic = {
    for key, nic_config in var.nic : key => {
      name                = nic_config.name
      location            = nic_config.location
      resource_group_name = nic_config.resource_group_name
      ip_configuration = {
        name                          = nic_config.ip_config_name
        subnet_id                     = module.subnet.subnet_id[nic_config.subnet_key]
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = try(module.pip.public_ip_id[nic_config.public_ip_key], null)
      }
    }
  }
  
  vm             = var.vm
  vm_name_secret = data.azurerm_key_vault_secret.vm_name.value
  vm_password    = data.azurerm_key_vault_secret.vm_password.value

  depends_on = [module.subnet, module.nsg, module.pip]
}

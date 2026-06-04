# infra-NestedMap

Azure Terraform project to deploy a simple nested infrastructure with a frontend VM exposed to the internet via a public IP and a backend VM without public IP.

## Project structure

- `main.tf` - Root module wiring together Azure resources and child modules.
- `provider.tf` - AzureRM provider configuration.
- `variables.tf` - Root variable definitions.
- `modules/` - Reusable module implementations:
  - `resource-group/` - Azure Resource Group creation.
  - `vnet/` - Virtual Network creation.
  - `subnet/` - Subnet creation.
  - `nsg/` - Network Security Group creation.
  - `nsg-association/` - NSG association to subnets.
  - `public-ip/` - Public IP address creation.
  - `vm/` - Linux VM and network interface creation.
- `environments/` - Environment-specific `terraform.tfvars` files.
  - `dev/terraform.tfvars`
  - `prod/terraform.tfvars`

## Folder structure

The folder structure is documented separately in `FOLDER_STRUCTURE.md`.

## What it deploys

- A resource group.
- A virtual network with two subnets: `frontend` and `backend`.
- One public IP resource.
- One NIC attached to the frontend subnet with a public IP.
- One NIC attached to the backend subnet without a public IP.
- Two Linux VMs, each attached to its NIC.

## Public IP behavior

This project is designed so that only the frontend VM gets a public IP. The backend VM is deployed on a private subnet without `public_ip_key` configured.

## Prerequisites

- Terraform installed.
- Azure CLI or service principal access to the target subscription.
- `azurerm` provider version `4.1.0` is configured in `provider.tf`.
- The configured Azure subscription must allow the requested VM SKU in the chosen region.
- The Key Vault referenced in `main.tf` must exist and contain the secrets `vm-name` and `vm-password`.

## Deploying

From the project root (`d:\JUNE-PRO\infra-NestedMap`):

1. Initialize Terraform:

```powershell
terraform init
```

2. Choose the environment file and plan:

```powershell
terraform plan -var-file=terraform.tfvars
```

For dev environment:

```powershell
terraform plan -var-file=environments/dev/terraform.tfvars
```

For prod environment:

```powershell
terraform plan -var-file=environments/prod/terraform.tfvars
```

3. Apply:

```powershell
terraform apply -var-file=environments/dev/terraform.tfvars -auto-approve
```

## Modifying public IP assignments

If you want to change which NIC receives a public IP:

- Update `nic.public_ip_key` only on the NIC that should get the public IP.
- Remove `public_ip_key` from any NIC that should remain private.

Example:

```hcl
nic = {
  frontend_nic = {
    name = "dev-nic-frontend"
    ...
    public_ip_key = "pip1"
  }

  backend_nic = {
    name = "dev-nic-backend"
    ...
    # no public_ip_key => no public IP assigned
  }
}
```

## Notes

- The backend VM is intentionally isolated from the public internet.
- If Azure SKU capacity errors occur, change the VM `size` in the environment tfvars file.
- Keep `subscription_id` and secrets secure when sharing this repo.

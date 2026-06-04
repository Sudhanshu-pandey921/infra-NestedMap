# Folder Structure

```
infra-NestedMap/
├── environments/
│   ├── dev/
│   │   └── terraform.tfvars
│   └── prod/
│       └── terraform.tfvars
├── modules/
│   ├── nsg/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── nsg-association/
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── public-ip/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── resource-group/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── subnet/
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── vm/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── vnet/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── main.tf
├── provider.tf
├── README.md
└── variables.tf
```

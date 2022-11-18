###################################
## Disk Encryption Set Variables ##
###################################
variable "des_name" {
  type        = string
  description = "The name of the Disk Encryption Set used for providing CMK disk encryption."
}

variable "des_key_name" {
  type        = string
  description = "The name of the key used by the Disk Encryption Resources."
}

###########################
## Environment Variables ##
###########################
variable "backup_policy_name" {
  description = "backup policy name"
  type        = string
}

variable "location" {
  description = "The location to deploy the resources to"
  type        = string
}

variable "vnet_name" {
  description = "Virtual Network Name"
  type        = string
}

variable "vnet_rg_name" {
  description = "Virtual Network Resource Group Name"
  type        = string
}

#########################
## Key Vault Variables ##
#########################
variable "key_vault_name" {
  type        = string
  description = "The name of the key vault."
}

##############################
## Resource Group Variables ##
##############################
variable "rg_name" {
  description = "The name for the resource group that contains the deployment"
  type        = string
}

####################
## Tags Variables ##
####################
variable "azure_tags" {
  description = "The associated tags to attach to the newly created image"
  type        = map(any)
}

##################
## VM Variables ##
##################
variable "admin_name_secret_name" {
  type        = string
  description = "VM admin name key vault secret's name."
}

variable "admin_name_secret_value" {
  type        = string
  description = "VM admin name key vault secret's value, the actual admin name."
}

variable "admin_password_secret_name" {
  type        = string
  description = "VM admin password key vault secret's name."
}

variable "admin_password_secret_value" {
  type        = string
  description = "VM admin password key vault secret's value, the actual admin password."
}

variable "asg_name" {
  type        = string
  description = "Application Security Group Name"
}

variable "availability_set_name" {
  description = "Availability Set Name"
  type        = string
}

variable "image_name" {
  description = "The name of the image."
  type        = string
}

variable "image_version" {
  description = "The name of the image version."
  type        = string
}

variable "image_rg_name" {
  description = "The Resource Group that will store the images"
  type        = string
}

variable "pip_name" {
  description = "Public IP Name"
  type        = string
}

variable "nic_name" {
  description = "Network Interface Name"
  type        = string
}

variable "nsg_name" {
  description = "NSG Name"
  type        = string
}

variable "subnet_name" {
  description = "Subnet Ip Name"
  type        = string
}

variable "subnet_range" {
  description = "Subnet Ip Range"
  type        = string
}

variable "vm_name" {
  description = "The name of the VM to deploy"
  type        = string
}

variable "hostname_FQDN" {
  description = "The Fully Qualified Domain Name for the VM public DNS label"
  type        = string
}

###########################
## VM Shutdown Variables ##
###########################
variable "shutdown_time" {
  description = "The time when the VM will be turned off"
  type        = string
}

variable "shutdown_timezone" {
  description = "Timezone for VM shutdown schedule"
  type        = string
}

#######################################################
## Automation Account Variables ##
#######################################################
variable "automation_account_name" {
  description = "The name of the automation account to assign the node"
  type        = string
}

variable "automation_account_rg_name" {
  description = "The name of the resource group the automation account is located"
  type        = string
}

variable "dsc_node_configuration_name" {
  description = "The DSC Node Configuration name to be used by the DSC Extension"
  type        = string
}

variable "kvName" {
    type        = string
    default     = "pgsicp-infra-keyv"
    description = "Keyvault name."
}

variable "tenantId" {
    type        = string
    default     = "f4a1e29e-05f7-4745-a47b-8910478562d0"#"7a60a629-e61f-430c-9c63-266653b2b899"
    description = "Tenant ID."
}

variable "subId" {
    type        = string
    default     = "42ced274-51ca-411e-8973-78df7811f3ad"#"14917acd-9b7a-4b09-a207-501849e81de7"
    description = "Subscription ID."
}

variable "rgName" {
    type        = string
    default     = "pgsicp-rg"
    description = "Resource Group name."
}

variable "env" {
    type = map(string)
    default = {
        pp  = "pp"
        prd = "prd"
  }
    description = "Specifies the env of the resource, can be used in the naming."
}

variable "location" {
    description = "The Azure Region where the resource will be created."
    default     = "northeurope"
}

variable "tags" {
    type = map(string)
    default = {
        terraformProject         = "https://github.com/colac/pgsicp-infra-kv"
        state                    = "live"
  }
    description = "Tags that will be applied to the resources."
}

variable "kv_access_hflacerda" {
    description = "ObjectID for user Hflacerda"
    default     = "305166f8-996c-46e9-8f45-3903d742be4a"
}

variable "kv_certificate_permissions_sys_admin" {
    type = list(string)
    default = ["Get","List","Update","Create","Import","Delete","Recover","Backup","Restore","Purge"]
}

variable "kv_key_permissions_sys_admin" {
    type = list(string)
    default = ["Get","List","Update","Create","Import","Delete","Recover","Backup","Restore","Purge"]
}

variable "kv_secret_permissions_sys_admin" {
    type = list(string)
    default = ["Get","List","Delete","Recover","Backup","Restore","Purge","Set"]
}
variable "kv_certificate_permissions_appreg" {
    type = list(string)
    default = ["Get","List","Update","Create"]
}

variable "kv_key_permissions_appreg" {
    type = list(string)
    default = ["Get","List","Update","Create"]
}

variable "kv_secret_permissions_appreg" {
    type = list(string)
    default = ["Get","List","Set"]
}
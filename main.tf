# Azure Key Vault

resource "azurerm_key_vault" "infrakv" {
    name                            = "${var.kvName}-${var.env[terraform.workspace]}"
    location                        = var.location
    resource_group_name             = var.rgName
    tenant_id                       = var.tenantId
    enabled_for_deployment          = false
    enabled_for_disk_encryption     = true
    enabled_for_template_deployment = true
    purge_protection_enabled        = false
    sku_name                        = "standard"
    soft_delete_retention_days      = 15

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
    # ip_rules = concat(
    #   ["${chomp(data.http.localipaddr.body)}/32"],
    #   ["192.0.192.100/32"],["192.0.192.200/32"],split(",",var.actionsips)
    # )
  }

  # Tags to apply
    tags = var.tags
}

# Add keys and secrets permission to user
resource "azurerm_key_vault_access_policy" "hflacerda" {
    key_vault_id = azurerm_key_vault.infrakv.id
    tenant_id    = var.tenantId
    object_id    = var.kv_access_hflacerda
    certificate_permissions = var.kv_certificate_permissions_sys_admin
    key_permissions = var.kv_key_permissions_sys_admin
    secret_permissions = var.kv_secret_permissions_sys_admin
    storage_permissions = []
}

# Ended up not using this block, Github actions over 2k IPs, and Azure keyvault only supports setting 1k in the networks ACL rules.
# # Parses your public IP address
# data "http" "localipaddr" {
#     url = "http://ipv4.icanhazip.com"
# }

# data "http" "githubactionsipsaddr" {
#     url = "https://api.github.com/meta"
# }
# locals {
#     # get json 
#     json_body = jsondecode(data.http.githubactionsipsaddr.body)
#     actions_ips = [for ips in local.json_body : actions]
# } 
# output "githubactionsips" {
#     value = local.actions_ips
# }
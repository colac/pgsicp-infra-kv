# Create AppReg
resource "azuread_application" "kvappreg" {
    display_name            = "appReg-${var.kvName}-${var.env[terraform.workspace]}"
    prevent_duplicate_names = true
}
# Create secret in AppReg
resource "azuread_application_password" "kvappregsecret" {
    application_object_id = azuread_application.kvappreg.object_id
}

# Save AppID in kv
resource "azurerm_key_vault_secret" "kvclientid" {
    name         = "appReg-${var.kvName}-${var.env[terraform.workspace]}-clientID"
    value        = azuread_application.kvappreg.application_id
    key_vault_id = azurerm_key_vault.infrakv.id
    # Tags to apply
    tags = var.tags
}
# Save secret in kv
resource "azurerm_key_vault_secret" "kvclientsecret" {
    name         = "appReg-${var.kvName}-${var.env[terraform.workspace]}-clientSecret"
    value        = azuread_application_password.kvappregsecret.value
    key_vault_id = azurerm_key_vault.infrakv.id
    # Tags to apply
    tags = var.tags
}

# Display secret generated, only for testing purposes. This value is kept in the KV
output "sensitive_example_hash" {
  value = nonsensitive(azuread_application_password.kvappregsecret.value)
}
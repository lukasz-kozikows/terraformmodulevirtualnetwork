
resource "azurerm_storage_account" "example" {
  name                     = local.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  

  #tags = {
  #  environment = "staging"
  # }
}
resource "azurerm_storage_container" "sc" {

  count = length(var.data_conteiners)

  name                  = var.data_conteiners[count.index].name
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = var.data_conteiners[count.index].access_type
  depends_on = [azurerm_storage_account.example]


}

resource "azurerm_storage_blob" "sb_plain_text" {

  for_each = local.plain_text_files

  name                   = "${each.value.name}.${each.value.file_extension}"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = var.data_conteiners[index(var.data_conteiners.*.access_type, "blob")].name
  type                   = "Block"
  source_content         = each.value.content
  depends_on = [azurerm_storage_container.sc]
}

resource "azurerm_storage_blob" "sb_private" {

  for_each = local.secure_text_files

  name                   = "${each.value.name}.${each.value.file_extension}"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = var.data_conteiners[index(var.data_conteiners.*.access_type, "private")].name
  type                   = "Block"
  source_content         = each.value.content
  depends_on = [azurerm_storage_container.sc]
}
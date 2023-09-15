module "naming" {
  source = "Azure/naming/azurerm"
  prefix = [var.project_prefix, "app"]
  suffix = [var.environment]

}



locals {
  storage_account_name = module.naming.storage_account.name
  plain_text_files     = { for file_in, file_out in var.data : file_in => file_out if file_out.file_extension == "txt" }
  secure_text_files    = { for file_in, file_out in var.data : file_in => file_out if file_out.file_extension != "txt" }
}
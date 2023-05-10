resource "azurerm_monitor_action_group" "actiongroup01" {
  name                = "actiongroup01"
  resource_group_name = var.rg_name
  short_name          = "actiongroup1"

  email_receiver {
    name          = var.email_receiver_name1
    email_address = var.email_receiver_email1
  }

  email_receiver {
    name          = var.email_receiver_name2
    email_address = var.email_receiver_email2
  }
}
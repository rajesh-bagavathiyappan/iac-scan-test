# output "subscription_name" {
#   description = "The display name of this subscription"
#   value       = data.azurerm_subscription.this.display_name
# }

# output "subscription_id" {
#   description = "The id of this subscription"
#   value       = var.subscription_id
# }

# output "tenant_id" {
#   description = "The tenant id of this subscription"
#   value       = data.azurerm_subscription.this.tenant_id
# }

output "resource_names" {
  value = local.resource_names
}
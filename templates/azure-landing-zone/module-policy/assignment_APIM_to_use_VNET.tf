resource "azurerm_policy_assignment" "APIM_to_use_VNET" {
  count                = contains(var.policylist, "APIM_to_use_VNET") ? 1 : 0
  name                 = "API Management services should use a virtual network"
  scope                = var.policyscope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ef619a2c-cc4d-4d03-b2ba-8c94a834d85b"
  description          = "Azure Virtual Network deployment provides enhanced security, isolation and allows you to place your API Management service in a non-internet routable network that you control access to. These networks can then be connected to your on-premises networks using various VPN technologies, which enables access to your backend services within the network and/or on-premises. The developer portal and API gateway, can be configured to be accessible either from the Internet or only within the virtual network."
  display_name         = "API Management services should use a virtual network"
}
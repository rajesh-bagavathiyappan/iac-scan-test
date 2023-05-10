resource "azurerm_policy_assignment" "APIM_SKU_support_VNET" {
  count                = contains(var.policylist, "APIM_SKU_support_VNET") ? 1 : 0
  name                 = "APIM service should use a SKU that supports VNETs"
  scope                = var.policyscope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/73ef9241-5d81-4cd4-b483-8443d1730fe5"
  description          = "With supported SKUs of API Management, deploying service into a virtual network unlocks advanced API Management networking and security features which provides you greater control over your network security configuration. Learn more at: https://aka.ms/apimvnet."
  display_name         = "APIM service should use a SKU that supports VNETs"
}

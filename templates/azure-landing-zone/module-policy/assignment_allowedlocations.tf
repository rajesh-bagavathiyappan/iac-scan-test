resource "azurerm_policy_assignment" "allowedlocations" {
  count                = contains(var.policylist, "allowedlocations") ? 1 : 0
  name                 = "allowedlocations"
  scope                = var.policyscope
  not_scopes           = []
  policy_definition_id = azurerm_policy_definition.allowedlocations[0].id
  description          = "Allowed locations in give scope"
  display_name         = "Allowed locations in give scope"

  metadata = <<METADATA
    {
    "category": "Demo"
    }
METADATA

  parameters = <<PARAMETERS
{
  "allowedLocations": {
    "value": [ "East US 2", 
               "East US", 
               "West US 2", 
               "West US" ]
  }
}
PARAMETERS

}

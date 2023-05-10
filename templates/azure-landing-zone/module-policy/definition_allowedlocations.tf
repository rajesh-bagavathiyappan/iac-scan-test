resource "azurerm_policy_definition" "allowedlocations" {
  count        = contains(var.policylist, "allowedlocations") ? 1 : 0
  name         = "allowedlocations"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Allowed Locations"

  metadata = <<METADATA
    {
    "category": "Demo"
    }

METADATA


  policy_rule = <<POLICY_RULE
    {
    "if": {
      "not": {
        "field": "location",
        "in": "[parameters('allowedLocations')]"
      }
    },
    "then": {
      "effect": "audit"
    }
  }
POLICY_RULE


  parameters = <<PARAMETERS
    {
    "allowedLocations": {
      "type": "Array",
      "metadata": {
        "description": "The list of allowed locations for resources.",
        "displayName": "Allowed locations",
        "strongType": "location"
      }
    }
  }
PARAMETERS

}

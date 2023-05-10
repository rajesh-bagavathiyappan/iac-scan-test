resource "azurerm_policy_definition" "namingconvention" {
  count        = contains(var.policylist, "namingconvention") ? 1 : 0
  name         = "Storage_namingconvention"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Storage Naming Convention"

  metadata = <<METADATA
    {
    "category": "Demo"
    }
  METADATA

  policy_rule = <<POLICY_RULE
    {
    "if": {
		"allOf":[
			{
				"not":{
					"field":"name",
					"match":"[parameters('namePattern')]"
				}
			},
			{
				"field": "type",
				"equals": "Microsoft.Storage/storageAccounts"
			}
		]
    },
    "then": { 
      "effect": "deny"
    }
  }
POLICY_RULE

  parameters = <<PARAMETERS
    {
		"namePattern":{
			"type": "String",
			"metadata":{
				"displayName": "namePattern",
				"description": "? for letter, # for numbers"
			}
		}
  }
PARAMETERS
}
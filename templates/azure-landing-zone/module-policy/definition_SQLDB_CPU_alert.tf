resource "azurerm_policy_definition" "sqlserverdbcpupercent" {
  count        = contains(var.policylist, "sqlserverdbcpupercent") ? 1 : 0
  name         = "sqlserverdbcpupercent"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Deploy alert to sqlServerDB for cpuPercent"
  description  = "Deploys a metric alert to sqlServerDB for cpuPercent"
  metadata     = <<METADATA
    {
    "category": "Demo"
    }
METADATA
  policy_rule  = <<POLICY_RULE
  {
    "if": {
      "allOf": [
        {
          "field": "type",
          "equals": "Microsoft.sql/servers/databases"
        }
      ]
    },
    "then": {
      "effect": "deployIfNotExists",
      "details": {
        "roleDefinitionIds": [
          "/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
          ],
        "type":"Microsoft.Insights/metricAlerts",
        "existenceCondition": {
            "allOf": [
                {
                    "field":"Microsoft.Insights/metricAlerts/criteria.Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria.allOf[*].metricNamespace",
                    "equals":"Microsoft.sql/servers/databases"
                },
                {
                    "field":"Microsoft.Insights/metricAlerts/criteria.Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria.allOf[*].metricName",
                    "equals":"cpu_percent"
                },
                {
                    "field":"Microsoft.Insights/metricalerts/scopes[*]",
                    "equals":"[concat(subscription().id, '/resourceGroups/', resourceGroup().name, '/providers/Microsoft.sql/servers/databases/', field('fullName'))]"
                }
            ]
        },
        "deployment": {
            "properties": {
                "mode": "incremental",
                "template": {
                    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
                    "contentVersion": "1.0.0.0",
                    "parameters": {
                        "resourceName": {
                            "type": "string",
                            "metadata": {
                                "displayName": "resourceName",
                                "description": "Name of the resource"
                            }
                        },
                        "resourceId": {
                            "type": "string",
                            "metadata": {
                                "displayName": "resourceId",
                                "description": "Resource ID of the resource emitting the metric that will be used for the comparison"
                            }
                        },
                        "resourceLocation": {
                            "type": "string",
                            "metadata": {
                                "displayName": "resourceLocation",
                                "description": "Location of the resource"
                            }
                        },
                        "actionGroupName": {
                            "type": "string",
                            "metadata": {
                                "displayName": "actionGroupName",
                                "description": "Name of the Action Group"
                            }
                        },
                        "actionGroupRG": {
                            "type": "string",
                            "metadata": {
                                "displayName": "actionGroupRG",
                                "description": "Resource Group containing the Action Group"
                            }
                        },
                        "actionGroupId": {
                            "type": "string",
                            "metadata": {
                                "displayName": "actionGroupId",
                                "description": "The ID of the action group that is triggered when the alert is activated or deactivated"
                            },
                            "defaultValue": "[resourceId(parameters('actionGroupRG'), 'Microsoft.Insights/ActionGroups', parameters('actionGroupName'))]"
                        }
                     },
                    "variables": {},
                    "resources": [
                        {
                            "type": "Microsoft.Insights/metricAlerts",
                            "apiVersion": "2018-03-01",
                            "name": "[concat(parameters('resourceName'), '-sqlServerDB_cpuPercent')]",
                            "location": "global",
                            "properties": {
                                "description": "cpu_percent",
                                "severity": 3,
                                "enabled": true,
                                "scopes": ["[parameters('resourceId')]"],
                                "evaluationFrequency": "PT15M",
                                "windowSize": "PT1H",
                                "criteria": {
                                    "allOf": [
                                        {
                                            "alertSensitivity": "Medium",
                                            "failingPeriods": {
                                                "numberOfEvaluationPeriods": 2,
                                                "minFailingPeriodsToAlert": 1
                                            },  
                                            "name": "Metric1",
                                            "metricNamespace": "Microsoft.sql/servers/databases",
                                            "metricName": "cpu_percent",
                                            "operator": "GreaterThan",
                                            "timeAggregation": "Average",
                                            "criterionType": "DynamicThresholdCriterion"
                                        }
                                    ],
                                    "odata.type": "Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria"
                                },
                                "autoMitigate": true,
                                "targetResourceType": "Microsoft.sql/servers/databases",
                                "targetResourceRegion": "[parameters('resourceLocation')]",
                                "actions": [
                                    {
                                        "actionGroupId": "[parameters('actionGroupId')]",
                                        "webHookProperties": {}
                                    }
                                ]
                            }
                        }
                    ]
                },
                "parameters": {
                    "resourceName": {
                        "value": "${var.SQL_resourceName}"
                    },
                    "resourceId": {
                        "value": "${var.SQL_resourceId}"
                    },
                    "resourceLocation": {
                        "value": "${var.location}"
                    },
                    "actionGroupName": {
                        "value": "${var.azure_monitor_action_group_name}"
                    },
                    "actionGroupRG": {
                        "value": "${var.azure_monitor_action_group_rg_name}"
                    }
                }
            }
        }
      }
    }
  }
POLICY_RULE
}
############################################
# OpenAI Cognitive Account
############################################
resource "azurerm_cognitive_account" "fsdu_openai" {
  name                = var.openainame
  resource_group_name = var.resourcegroupname
  location            = var.location
  kind                = "OpenAI"
  sku_name            = "S0"

  custom_subdomain_name = var.openainame

  identity {
    type = "SystemAssigned"
  }
}

############################################
# Model Deployment inside OpenAI
############################################
resource "azapi_resource" "fsdu_openai_model_deployment" {
  type      = "Microsoft.CognitiveServices/accounts/deployments@2024-10-01"
  name      = var.modeldeploymentname
  parent_id = azurerm_cognitive_account.fsdu_openai.id

  body = {
    sku = {
      name     = "Standard"
      capacity = 1
    }
    properties = {
      model = {
        format  = "OpenAI"
        name    = var.model_name
        version = var.model_version
      }
    }
  }
}

############################################
# Azure AI Foundry Workspace
############################################
# TEMPORARILY DISABLED - Requires additional resource configuration
# resource "azapi_resource" "fsdu_ai_foundry" {
#   type      = "Microsoft.MachineLearningServices/workspaces@2024-04-01"
#   name      = var.aifoundryname
#   location  = var.location
#   parent_id = var.resource_group_id
#
#   schema_validation_enabled = false
#   ignore_missing_property   = true
#
#   identity {
#     type = "SystemAssigned"
#   }
#
#   body = {
#     properties = {
#       description         = "AI Foundry Workspace for OpenAI Model"
#       storageAccount      = var.storage_account_id
#       applicationInsights = var.app_insights_id
#     }
#   }
#
#   depends_on = [
#     azurerm_cognitive_account.fsdu_openai
#   ]
# }


data "azurerm_client_config" "current" {}

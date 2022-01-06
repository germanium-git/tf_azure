# --Create resource group
resource "azurerm_resource_group" "rg" {
    name            = "rg-${local.project_distinguisher}"
    location        = var.location

    tags = {
        environment = local.environment
    }
}

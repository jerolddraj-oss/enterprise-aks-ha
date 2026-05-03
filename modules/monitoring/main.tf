resource "azurerm_log_analytics_workspace" "law" {
  name                = "aks-law"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_monitor_diagnostic_setting" "aks_diag" {
  name                       = "aks-diagnostics"
  target_resource_id         = var.aks_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  enabled_log {
    category = "kube-apiserver"
  }

  metric {
    category = "AllMetrics"
  }
}

resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "aks-cpu-alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.aks_id]
  description         = "High CPU usage"

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "node_cpu_usage_percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  frequency   = "PT1M"
  window_size = "PT5M"
}

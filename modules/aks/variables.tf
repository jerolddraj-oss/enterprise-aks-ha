variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
}

variable "cluster_name" {
  description = "AKS Cluster Name"
  type        = string
  default     = "aks-cluster"
}

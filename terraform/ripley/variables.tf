variable "agent_count" {
    default = 3
}

variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
    default = "ripley"
}

variable cluster_name {
    default = "RipleyCluster"
}

variable resource_group_name {
    default = "ripleyRG"
}

variable location {
    default = "Central US"
}

variable log_analytics_workspace_name {
    default = "ripleyLogAnalytics"
}

# refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
variable log_analytics_workspace_location {
    default = "eastus"
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
variable log_analytics_workspace_sku {
    default = "PerGB2018"
}

# Service Principal
# {
#   "appId": "56f38577-ee98-43f1-a441-1102e72a6b1c",
#   "displayName": "RipleyServicePrincipal",
#   "name": "http://RipleyServicePrincipal",
#   "password": "f5ead235-f592-464b-9597-68aac35effbc",
#   "tenant": "dbe6faae-d61d-441e-8cd7-616c5947bbc0"
# }

variable service_principal_client_id {
    default = "56f38577-ee98-43f1-a441-1102e72a6b1c"
}

variable service_principal_client_secret {
    default = "f5ead235-f592-464b-9597-68aac35effbc"
}

variable service_principal_display_name {
    default = "http://RipleyServicePrincipal"
}

variable service_principal_display_tenant {
    default = "dbe6faae-d61d-441e-8cd7-616c5947bbc0"
}
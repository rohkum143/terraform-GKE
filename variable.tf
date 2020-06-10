variable "credentials" {
   //type = "string"
  default = "account.json"  
}
variable "gcp_project" {}
variable "region" {}
variable "zone" {
type        = list(string)
description = "The zones to host the cluster in."
}
variable "vpc_name" {}
variable "iam_roles" {
type = "map"
}
variable "cluster_name" {
  
}
variable "vpc_peerings" {
  
}
variable "cloud_nat_ips" {
type = "map"
}
variable "subnet_cidr" {

  
}
variable "pod_range" {
  
}
# variable "gke_version" {
  
# }
variable "service_range" {
  
}
variable "network_name" {
  
}

# variable "master_range" {
  
# }

variable "machine_type" {
  
}
# variable "service_account" {
  
# }

# variable "default_pool_name" {
  
# }
variable "default_pool_node_number" {
  
}
variable "default_pool_min_node" {
  
}
variable "default_pool_max_node" {
  
}


variable "default_node_pool_name" {
  
}
variable "gke_version" {
  
}

variable "disk_size_gb" {
  
}
variable "initial_node_count" {
  
}
variable "pod_range_name" {
  
}

variable "service_range-name" {
  
}



















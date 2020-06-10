module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
#   version                    = "4.1.0"
  project_id                 = var.gcp_project
  region                     = var.region
  zones                      = var.zone
  name                       = var.cluster_name
  network                    = "${module.gcp-network.network_name}"
  subnetwork                 = var.cluster_name	
  ip_range_pods              = "${var.pod_range_name}"
  ip_range_services          = "${var.service_range-name}"
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  network_policy             = true
  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = var.machine_type
      min_count          = var.default_pool_min_node
      max_count          = var.default_pool_max_node
      local_ssd_count    = 0
      disk_size_gb       = var.disk_size_gb
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = "${google_service_account.sa.email}"
      preemptible        = false
      initial_node_count = 1
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}
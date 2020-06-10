module "gcp-network" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 2.0"
  project_id   = var.gcp_project
  network_name = "${var.vpc_name}-network"

  subnets = [
    {
      subnet_name           = "${var.cluster_name}"
      subnet_ip             = var.subnet_cidr
      subnet_region         = var.region
      subnet_private_access = "true"
    },
  ]

  secondary_ranges = {
    "${var.cluster_name}" = [
      {
        range_name    = "${var.pod_range_name}"
        ip_cidr_range = var.pod_range
      },
      {
        range_name    = "${var.service_range-name}"
        ip_cidr_range = var.service_range
      },
    ]
  }
}

data "google_compute_subnetwork" "subnetwork" {
  name       = "${var.cluster_name}"
  project    = var.gcp_project
  region     = var.region
  depends_on = [module.gcp-network]
}

resource "google_compute_firewall" "project-firewall-allow-ssh" {
  name    = "${var.vpc_name}-allow-something"
  network = "${module.gcp-network.network_name}"
  allow {
    protocol = "tcp"
    ports    = ["22"] #22, 80...
  }
source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-db" {
  name    = "allow-from-${var.cluster_name}-cluster-to-other-project-db"
  network = "${module.gcp-network.network_name}"
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }
  source_ranges = ["${var.subnet_cidr}", "${var.pod_range}"]
  target_tags = ["network-tag-name"]
}

resource "google_compute_address" "project-nat-ips" {
  count   = "${length(var.cloud_nat_ips)}"
  name    = "${element(values(var.cloud_nat_ips), count.index)}"
  project = "${var.gcp_project}"
  region  = "${var.region}"
}



resource "google_compute_router" "project-router" {
  name = "${var.vpc_name}-nat-router"
  network = "${module.gcp-network.network_name}"
}

resource "google_compute_router_nat" "project-nat" {
  name = "${var.vpc_name}-nat-gw"
  router = "${google_compute_router.project-router.name}"
  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips = "${google_compute_address.project-nat-ips.*.self_link}"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  depends_on = ["google_compute_address.project-nat-ips"]
}


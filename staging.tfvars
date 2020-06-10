subnet_cidr = "10.0.0.0/17"
subnet_name = "staging"
cluster_name = "staging"
network_name = "example-network"
pod_range = "192.168.0.0/18"
default_pool_node_number = 1
default_pool_min_node = 1
default_pool_max_node = 10
default_node_pool_name = "staging"
machine_type = "n1-standard-2"
vpc_peerings = ["test","test2"]
cloud_nat_ips = {
    test-ip = "first"
}
service_range = "192.168.64.0/18"
gke_version = "1.14.10-gke.36"
disk_size_gb = "100"
initial_node_count = "2 "
service_range-name = "service-range-name"
pod_range_name = "pod-range-name"
	
resource "oci_containerengine_cluster" "cluster" {
    compartment_id = var.compartment_id
    kubernetes_version = var.cluster_kubernetes_version
    name = var.cluster_name
    vcn_id = oci_core_vcn.oke_vcn.id

    cluster_pod_network_options {
        cni_type = "OCI_VCN_IP_NATIVE"
    }
    endpoint_config {
        is_public_ip_enabled = true
        subnet_id = oci_core_subnet.kmi_lb.id
    }

    options {
        kubernetes_network_config {
            pods_cidr = oci_core_subnet.pod.cidr_block
        }
        service_lb_subnet_ids = [oci_core_subnet.worker_lb.id]
    }
    type = "ENHANCED_CLUSTER"
}


resource "oci_containerengine_node_pool" "node_pool" {

    cluster_id = oci_containerengine_cluster.cluster.id
    compartment_id = var.compartment_id
    name = "pool"
    node_shape = "VM.Standard.E3.Flex"

    kubernetes_version = var.cluster_kubernetes_version
    node_config_details {
        placement_configs {
            availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
            fault_domains = [for fd in data.oci_identity_fault_domains.fds.fault_domains : fd.name]
            subnet_id = oci_core_subnet.worker.id
        }
        size = var.node_pool_size

        node_pool_pod_network_option_details {
            cni_type = "OCI_VCN_IP_NATIVE"
            pod_subnet_ids = [oci_core_subnet.pod.id]

        }
    }
    node_eviction_node_pool_settings {
        eviction_grace_duration = 60
    }

    node_shape_config {
        memory_in_gbs = "16"
        ocpus = "1"
    }
    node_source_details {
        image_id = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaa24qxuqkpjds52wpq6jqcbxmf6p4dl56rlpqlz72cn7ycjxrocza"
        source_type = "IMAGE"

        boot_volume_size_in_gbs = "250"
    }
    ssh_public_key = var.ssh_public_key
}
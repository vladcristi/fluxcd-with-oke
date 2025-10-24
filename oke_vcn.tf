resource "oci_core_vcn" "oke_vcn" {
  cidr_block     = var.vcn_cidr
  dns_label      = var.vcn_name
  compartment_id = var.compartment_id
  display_name   = "${var.vcn_name}-vcn"
}

resource "oci_core_nat_gateway" "vcn_ngs" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.oke_vcn.id
  count          = var.enable_private_endpoint ? 0:1

  display_name = "VCN ngw"
}

resource "oci_core_internet_gateway" "vcn_igs" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.oke_vcn.id
  count          = var.enable_private_endpoint ? 0:1

  display_name = "VCN igw"
  enabled      = true
}

resource "oci_core_default_route_table" "default_private" {
  manage_default_resource_id = oci_core_vcn.oke_vcn.default_route_table_id
  display_name   = "Default - private"
  count          = var.enable_private_endpoint ? 1:0
}

resource "oci_core_default_route_table" "private" {
  count          = var.enable_private_endpoint ? 0:1
  manage_default_resource_id = oci_core_vcn.oke_vcn.default_route_table_id
  display_name   = "Default - private"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.vcn_ngs[0].id
  }
}

resource "oci_core_route_table" "public" {
  count          = var.enable_private_endpoint ? 0:1
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.oke_vcn.id

  display_name = "public"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.vcn_igs[0].id
  }
}
variable "oci_config_file_profile" {
  type    = string
  default = "DEFAULT"
}

variable "tenancy_ocid" {
  description = "tenancy OCID"
  type        = string
  nullable    = false
}

variable "compartment_id" {
  description = "compartment OCID"
  type        = string
  nullable    = false
}

variable "vcn_name" {
  description = "VCN name"
  nullable    = false
  default     = "okevcn"
}

variable "kube_client_cidr" {
  description = "CIDR of Kubernetes API clients"
  type        = string
  nullable    = false
  default     = "10.0.0.0/8"
}

variable "kubernetes_api_port" {
  description = "Port used for Kubernetes API"
  type        = string
  default     = "6443"
}

# IP network addressing
variable "vcn_cidr" {
  default = "172.31.0.0/19"
}

# Subnet for KMIs where kube-apiserver and other control
# plane applications run, max 9 nodes
variable "kmi_cidr" {
  description = "Kubernetes control plane subnet CIDR"
  default     = "172.31.4.0/22"
}

# Subnet for KMI load balancer
variable "kmilb_cidr" {
  description = "Kubernetes control plane LB subnet CIDR"
  default     = "172.31.2.0/23"
}

# Subnet CIDR configured for VCN public IP for NAT in Network
variable "public_ip_cidr" {
  description = "Public IP CIDR configured in the Service Enclave"
  type        = string
  nullable    = false
  default     = "10.0.0.0/8"
}

# Subnet for worker nodes, max 128 nodes
variable "worker_cidr" {
  description = "Kubernetes worker subnet CIDR"
  default     = "172.31.8.0/21"
}

# Subnet for worker load balancer (for use by CCM)
variable "workerlb_cidr" {
  description = "Kubernetes worker LB subnet CIDR"
  default     = "172.31.0.0/23"
}

# Subnet for pod communication
variable "pod_cidr" {
  description = "Kubernetes pod communication subnet CIDR"
  default     = "172.31.16.0/20"
}

# Flag to Enable private endpoint
variable "enable_private_endpoint" {
  description = "Flag to create private control plane endpoint/service-lb"
  type = bool
  default = false
  nullable = false
}


#### Cluster variables

variable "cluster_kubernetes_version" {
  description = "Cluster Kubernetes version"
  type = string
  default = "v1.34.1"
}

variable "cluster_name" {
  description = "Cluster Name"
  type = string
  default = "oke"
}

variable "node_pool_size" {
  description = "Nodepool Size"
  type = string
  default = "1"
}

variable "ssh_public_key" {
  description = "SSH Public Key"
  type = string
  default = ""
}

resource "yandex_vpc_security_group" "k8s-main" {
  count = var.default_security_groups ? 1 : 0

  name        = "k8s-main"
  description = "Base security group for Kubernetes cluster"
  folder_id   = var.folder_id
  network_id  = var.network_id

  egress {
    protocol       = "ANY"
    description    = "For outgoing traffic that allows cluster hosts to connect to external resources"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

  ingress {
    protocol    = "ANY"
    description = "To transfer traffic between pods and services"
    v4_cidr_blocks = [
      var.cluster_ipv4_range,
      var.service_ipv4_range
    ]
    from_port = 0
    to_port   = 65535
  }

  ingress {
    protocol          = "ANY"
    description       = "To transfer service traffic between the master and nodes"
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  }

  ingress {
    protocol          = "TCP"
    description       = "For a network load balancer"
    predefined_target = "loadbalancer_healthchecks"
    from_port         = 7890
    to_port           = 7891
  }

  ingress {
    protocol       = "ICMP"
    description    = "ICMP-packets to debug form internal networks"
    v4_cidr_blocks = var.local_subnet_ranges
  }
}

# K8s Master Security Groups
resource "yandex_vpc_security_group" "k8s-master-whitelist" {
  count = var.default_security_groups ? 1 : 0

  name        = "k8s-master-whitelist"
  description = "Whitelist for Kubernetes API"
  folder_id   = var.folder_id
  network_id  = var.network_id

  ingress {
    protocol       = "TCP"
    description    = "To access the Kubernetes API and manage clusters"
    v4_cidr_blocks = var.vpn_ips
    port           = 6443
  }

  ingress {
    protocol       = "TCP"
    description    = "To access the Kubernetes API and manage clusters"
    v4_cidr_blocks = var.vpn_ips
    port           = 443
  }
}

# SSH
resource "yandex_vpc_security_group" "k8s-nodes-ssh-access" {
  count = var.default_security_groups ? 1 : 0

  name        = "k8s-nodes-ssh-access"
  description = "Kubernetes nodes SSH access"
  folder_id   = var.folder_id
  network_id  = var.network_id

  ingress {
    protocol       = "TCP"
    description    = "To connect to nodes over SSH"
    v4_cidr_blocks = var.vpn_ips
    port           = 22
  }
}
locals {
  folder_id   = "xxxxxxxxxxxxxxxxxxxx"
  network_id  = "yyyyyyyyyyyyyyyyyyyy"
}

resource "yandex_vpc_security_group" "k8s-test" {
  name        = "k8s-test"
  description = "Test security group for Kubernetes cluster"
  folder_id   = local.folder_id
  network_id  = local.network_id
}

module "kubernetes" {
  source = "../.."

  name             = "test-sg-cluster"
  description      = "k8s Cluster with custom security groups"
  folder_id        = local.folder_id
  network_id       = local.network_id
  master_locations = [{
    subnet_id = "zzzzzzzzzzzzzzzzzzzz"
    zone      = "ru-central1-a"
  }]

  master_security_group_ids = [
    yandex_vpc_security_group.k8s-test.id
  ]
  default_security_groups = true
}

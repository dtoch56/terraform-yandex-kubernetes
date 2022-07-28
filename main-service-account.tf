# Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster.
# Selected service account should have edit role on the folder where the Kubernetes cluster will be located
# and on the folder where selected network resides.
locals {
  service_account_name = var.service_account_id == null ? var.service_account_name : null
  service_account_id = try(
    yandex_iam_service_account.service_account[0].id,
    var.service_account_id
  )
}

resource "yandex_iam_service_account" "service_account" {
  count = local.service_account_name == null ? 0 : 1

  folder_id = var.folder_id
  name      = var.service_account_name
}

resource "yandex_resourcemanager_folder_iam_member" "service_account" {
  count = local.service_account_name == null ? 0 : 1

  folder_id = var.folder_id

  role   = "editor"
  member = "serviceAccount:${local.service_account_id}"
}


# Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry
# or to push node logs and metrics.
locals {
  node_service_account_name   = var.node_service_account_id == null ? var.node_service_account_name : null
  node_service_account_exists = local.node_service_account_name == null || var.service_account_name == var.node_service_account_name
  node_service_account_id = try(
    yandex_iam_service_account.node_service_account[0].id,
    local.node_service_account_exists ? coalesce(var.node_service_account_id, local.service_account_id) : null
  )
}

resource "yandex_iam_service_account" "node_service_account" {
  count = local.node_service_account_exists ? 0 : 1

  folder_id = var.folder_id
  name      = local.node_service_account_name
}

resource "yandex_resourcemanager_folder_iam_member" "node_service_account" {
  count = (local.node_service_account_name == null) || (var.service_account_name == var.node_service_account_name) ? 0 : 1

  folder_id = var.folder_id

  role   = "container-registry.images.puller"
  member = "serviceAccount:${local.node_service_account_id}"
}

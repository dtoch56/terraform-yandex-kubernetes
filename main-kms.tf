resource "yandex_kms_symmetric_key" "k8s" {
  count = var.kms_provider_key_id == null ? 1 : 0

  folder_id         = var.folder_id
  name              = "${var.name}-key"
  description       = "${var.name} cluster symmetric key"
  default_algorithm = var.kms_algorithm
  rotation_period   = var.kms_rotation_period
}

locals {
  kms_key_id = var.kms_provider_key_id == null ? yandex_kms_symmetric_key.k8s[0].id : var.kms_provider_key_id
}

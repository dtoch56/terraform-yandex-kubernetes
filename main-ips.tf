resource "yandex_vpc_address" "addr" {
  for_each = var.ingress_ips

  name        = each.key
  description = each.value.description
  folder_id   = var.folder_id
  labels = {
    "environment" = "dev"
    "maintainer"  = "dtoch"
    "managed-by"  = "terraform"
  }
  external_ipv4_address {
    zone_id                  = each.value.zone
    ddos_protection_provider = each.value.ddos_protection ? "qrator" : null
    outgoing_smtp_capability = null
  }
}

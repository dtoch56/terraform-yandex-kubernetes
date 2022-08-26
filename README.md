# Yandex.Cloud Kubernetes module

Creates a Kubernetes Cluster in Yandex.Cloud.

## Basic example

To create a Kubernetes cluster named `my-k8s` in Yandex.Cloud with folder id `xxx000xxx000xxx000xx`:

```hcl
module "kubernetes" {
  source       = "dtoch56/kubernetes/yandex"
  folder_id    = "xxx000xxx000xxx000xx"
  name         = "my-k8s-cluster"
}
```

## Requirements

| Name                                            | Version |
|-------------------------------------------------|---------|
| [terraform](https://www.terraform.io/downloads) | >= 1.2  |

## Providers

| Name                                                                                    | Version |
|-----------------------------------------------------------------------------------------|---------|
| [yandex-cloud](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs) | >= 0.75 |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                    | Type     |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [yandex_kubernetes_cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_cluster)                                       | resource |
| [yandex_iam_service_account](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/iam_service_account)                                     | resource |
| [yandex_resourcemanager_folder_iam_member](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/resourcemanager_folder_iam_member)         | resource |
| [yandex_iam_service_account_static_access_key](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/iam_service_account_static_access_key) | resource |

## Inputs

| Name                          | Description                                                                                                                                               | Type     | Required | Default |
|-------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|----------|:--------:|---------|
| cloud_id                      | Cloud that the Folder belongs to                                                                                                                          | `string` |   yes    |         |
| name                          | Name of a specific Kubernetes cluster.                                                                                                                    | `string` |    no    |         |
| description                   | A description of the Kubernetes cluster.                                                                                                                  | `string` |    no    |         |
| folder_id                     | The ID of the folder that the Kubernetes cluster belongs to.                                                                                              | `string` |    no    |         |
| labels                        | A set of key/value label pairs to assign to the Kubernetes cluster.                                                                                       | `string` |    no    |         |
| network_id                    | The ID of the cluster network.                                                                                                                            | `string` |    no    |         |
| cluster_ipv4_range            | CIDR block. IP range for allocating pod addresses.                                                                                                        | `string` |    no    |         |
| cluster_ipv6_range            | Identical to cluster_ipv4_range but for IPv6 protocol.                                                                                                    | `string` |    no    |         |
| node_ipv4_cidr_mask_size      | Size of the masks that are assigned to each node in the cluster. Effectively limits maximum number of pods for each node.                                 | `string` |    no    |         |
| service_ipv4_range            | CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from.                                                           | `string` |    no    |         |
| service_account_id            | ID of existing service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster.                                        | `string` |    no    |         |
| service_account_name          | Name of service account to create to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster.                                     | `string` |    no    |         |
| node_service_account_id       | ID of service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics.             | `string` |    no    |         |
| node_service_account_name     | Name of service account to create to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. | `string` |    no    |         |
| release_channel               | Cluster release channel.                                                                                                                                  | `string` |    no    |         |
| network_policy_provider       | Network policy provider for the cluster. Possible values: CALICO.                                                                                         | `string` |    no    |         |
| kms_provider_key_id           | KMS key ID.                                                                                                                                               | `string` |    no    |         |
| master_version                | Version of Kubernetes that will be used for master.                                                                                                       | `string` |    no    |         |
| master_public_ip              | Boolean flag. When true, Kubernetes master will have visible ipv4 address.                                                                                | `string` |    no    |         |
| master_security_group_ids     | List of security group IDs to which the Kubernetes cluster belongs.                                                                                       | `string` |    no    |         |
| master_region                 | Name of region where cluster will be created. Required for regional cluster, not used for zonal cluster.                                                  | `string` |    no    |         |
| master_locations              | List of locations where cluster will be created. If list contains only one location, will be created zonal cluster, if more than one -- regional.         | `string` |    no    |         |
| master_auto_upgrade           | Boolean flag that specifies if master can be upgraded automatically.                                                                                      | `string` |    no    |         |
| master_maintenance_windows    | List of structures that specifies maintenance windows, when auto update for master is allowed.                                                            | `string` |    no    |         |
| node_groups                   | Parameters of Kubernetes node groups.                                                                                                                     | `string` |    no    |         |
| node_groups_default_ssh_keys  | Map containing SSH keys to install on all Kubernetes node servers by default.                                                                             | `string` |    no    |         |
| node_groups_default_locations | Default locations of Kubernetes node groups. If ommited, master_locations will be used.                                                                   | `string` |    no    |         |
| node_groups_locations         | Locations of Kubernetes node groups. Use it to override default locations of certain node groups.                                                         | `string` |    no    |         |

## Outputs

| Name                    | Description                                                                                                                                  |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| external_v4_endpoint    | An IPv4 external network address that is assigned to the master.                                                                             | 
| internal_v4_endpoint    | An IPv4 internal network address that is assigned to the master.                                                                             | 
| cluster_ca_certificate  | PEM-encoded public certificate that is the root of trust for the Kubernetes cluster.                                                         | 
| cluster_id              | ID of a new Kubernetes cluster.                                                                                                              | 
| node_groups             | Attributes of yandex_node_group resources created in cluster                                                                                 | 
| service_account_id      | ID of service account used for provisioning Compute Cloud and VPC resources for Kubernetes cluster                                           | 
| node_service_account_id | ID of service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics | 




## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = v1.4.0 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | 0.86.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.86.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_instance_1"></a> [instance\_1](#module\_instance\_1) | ./module/instance | n/a |
| <a name="module_instance_2"></a> [instance\_2](#module\_instance\_2) | ./module/instance | n/a |

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_network.network](https://registry.terraform.io/providers/yandex-cloud/yandex/0.86.0/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.subnet_1](https://registry.terraform.io/providers/yandex-cloud/yandex/0.86.0/docs/resources/vpc_subnet) | resource |
| [yandex_vpc_subnet.subnet_2](https://registry.terraform.io/providers/yandex-cloud/yandex/0.86.0/docs/resources/vpc_subnet) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_ip_address_vm_1"></a> [external\_ip\_address\_vm\_1](#output\_external\_ip\_address\_vm\_1) | внешний адрес виртуалки 1 |
| <a name="output_external_ip_address_vm_2"></a> [external\_ip\_address\_vm\_2](#output\_external\_ip\_address\_vm\_2) | внешний адрес виртуалки 1 |
| <a name="output_internal_ip_address_vm_1"></a> [internal\_ip\_address\_vm\_1](#output\_internal\_ip\_address\_vm\_1) | внутренний адрес виртуалки 1 |
| <a name="output_internal_ip_address_vm_2"></a> [internal\_ip\_address\_vm\_2](#output\_internal\_ip\_address\_vm\_2) | внутренний адрес виртуалки 2 |

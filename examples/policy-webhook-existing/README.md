# Policy Webhook Basic

Configuration in this directory creates a workflow targetting an alert policy by id with a single webhook destination configured with the default values.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3 |
| <a name="requirement_newrelic"></a> [newrelic](#requirement\_newrelic) | >=3.14 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_newrelic"></a> [newrelic](#provider\_newrelic) | >=3.14 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main"></a> [main](#module\_main) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [newrelic_alert_policy.example](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/alert_policy) | resource |
| [newrelic_notification_destination.example_destination](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/notification_destination) | resource |
| [newrelic_notification_destination.example_destination](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/data-sources/notification_destination) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The New Relic account ID of the account you wish to create the condition | `string` | `"3761382"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether to enable the alert condition | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_data_source"></a> [data\_source](#output\_data\_source) | n/a |
| <a name="output_webhook_destinations"></a> [webhook\_destinations](#output\_webhook\_destinations) | n/a |
| <a name="output_workflow_enabled"></a> [workflow\_enabled](#output\_workflow\_enabled) | n/a |
| <a name="output_workflow_id"></a> [workflow\_id](#output\_workflow\_id) | n/a |
| <a name="output_workflow_muting"></a> [workflow\_muting](#output\_workflow\_muting) | n/a |
| <a name="output_workflow_name"></a> [workflow\_name](#output\_workflow\_name) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

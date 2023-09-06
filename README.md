# Terraform New Relic NRQL Workflow Module

This module handles opinion New Relic NRQL Workflow creation and configuration.

## Compatability

This module is meant for use with Terraform 1.0+ and tested using Terraform 1.3+.
If you find incompatibilities using Terraform `>=1.0`, please open an issue.

## Usage

There are multiple examples included in the [examples](https://github.com/usfoods/terraform-newrelic-workflow/tree/master/examples) folder but simple usage is as follows:

```hcl
provider "newrelic" {
  account_id = var.account_id
}

resource "newrelic_alert_policy" "main" {
  name                = "Basic Policy"
  incident_preference = "PER_CONDITION_AND_TARGET"
}

// This is the bare minimum configuration required
module "main" {
  source = "usfoods/workflow/newrelic"

  account_id = var.account_id
  name       = "Basic Critical NRQL Alert Condition"
  enabled    = var.enabled
  policy_ids = [newrelic_alert_policy.example.id]

  email_addresses = ["tom.jones@company.org"]
}
```

Then perform the following commands on the root folder:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_newrelic"></a> [newrelic](#requirement\_newrelic) | >= 3.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_newrelic"></a> [newrelic](#provider\_newrelic) | >= 3.13 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_email_destinations"></a> [email\_destinations](#module\_email\_destinations) | ./modules/email-destination | n/a |
| <a name="module_webhook_destinations"></a> [webhook\_destinations](#module\_webhook\_destinations) | ./modules/api-destination | n/a |

## Resources

| Name | Type |
|------|------|
| [newrelic_workflow.this](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/workflow) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Determines the New Relic account where resources will be created | `string` | n/a | yes |
| <a name="input_email_addresses"></a> [email\_addresses](#input\_email\_addresses) | List of email adresses to receive alert notifications | `list(string)` | `null` | no |
| <a name="input_email_destinations"></a> [email\_destinations](#input\_email\_destinations) | List of email destinations to receive alert notifications | <pre>list(object({<br>    email_addresses = list(string)<br>    email_subject   = optional(string, "")<br>    email_details   = optional(string, "")<br>  }))</pre> | `[]` | no |
| <a name="input_email_details"></a> [email\_details](#input\_email\_details) | Free text that represents the email custom details | `string` | `null` | no |
| <a name="input_email_subject"></a> [email\_subject](#input\_email\_subject) | Free text that represents the email subject title | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether workflow is enabled | `bool` | `false` | no |
| <a name="input_enrichments"></a> [enrichments](#input\_enrichments) | The workflow's notification enrichments | <pre>list(object({<br>    name  = string<br>    query = string<br>  }))</pre> | `[]` | no |
| <a name="input_issues_filter"></a> [issues\_filter](#input\_issues\_filter) | Filters used to identify issues handled by this workflow. | <pre>list(object({<br>    attribute = string<br>    operator  = string<br>    values    = list(any)<br>  }))</pre> | `[]` | no |
| <a name="input_muting"></a> [muting](#input\_muting) | How to handle muted issues | `string` | `"DONT_NOTIFY_FULLY_OR_PARTIALLY_MUTED_ISSUES"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the workflow | `string` | n/a | yes |
| <a name="input_notification_triggers"></a> [notification\_triggers](#input\_notification\_triggers) | Issue events to notify on | `list(string)` | `null` | no |
| <a name="input_policy_ids"></a> [policy\_ids](#input\_policy\_ids) | List of policy ids to be include in the workflow issues filter | `list(string)` | `[]` | no |
| <a name="input_webhook_destinations"></a> [webhook\_destinations](#input\_webhook\_destinations) | List of webhook destinations to receive alert notifications | <pre>list(object({<br>    webhook_id     = optional(string)<br>    webhook_url    = optional(string)<br>    webook_headers = map(string)<br>    webook_payload = string<br>  }))</pre> | `[]` | no |
| <a name="input_webhook_headers"></a> [webhook\_headers](#input\_webhook\_headers) | A map of key/value pairs that represents the webhook headers | `string` | `null` | no |
| <a name="input_webhook_id"></a> [webhook\_id](#input\_webhook\_id) | Id of the webhook to receive notification | `string` | `null` | no |
| <a name="input_webhook_payload"></a> [webhook\_payload](#input\_webhook\_payload) | A map of key/value pairs that represents the webhook payload | `string` | `null` | no |
| <a name="input_webhook_url"></a> [webhook\_url](#input\_webhook\_url) | Url of webhook to receive notification | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_email_destinations"></a> [email\_destinations](#output\_email\_destinations) | The list of email destinations defined for the workflow |
| <a name="output_webhook_destinations"></a> [webhook\_destinations](#output\_webhook\_destinations) | The list of webhook destinations defined for the workflow |
| <a name="output_workflow_enabled"></a> [workflow\_enabled](#output\_workflow\_enabled) | Whether the workflow is enabled |
| <a name="output_workflow_id"></a> [workflow\_id](#output\_workflow\_id) | The Id of the workflow |
| <a name="output_workflow_muting"></a> [workflow\_muting](#output\_workflow\_muting) | How the workflow handles muted issues |
| <a name="output_workflow_name"></a> [workflow\_name](#output\_workflow\_name) | The name of the workflow |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

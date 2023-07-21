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

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

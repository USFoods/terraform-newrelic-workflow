provider "newrelic" {
  account_id = var.account_id
}

resource "newrelic_alert_policy" "example" {
  account_id          = var.account_id
  name                = "Example Policy"
  incident_preference = "PER_POLICY"
}

# This is the bare minimum configuration required for a workflow
# with a webhook destination targetting a policy
module "main" {
  source = "../.."

  account_id = var.account_id
  name       = "Example Workflow Webhook Destination"
  enabled    = var.enabled
  policy_ids = [newrelic_alert_policy.example.id]

  webhook_destinations = [{
    webhook_url     = "https://api.monitoring.com",
    webhook_headers = <<-EOT
    {
      "x-api-key": "secure_string_for_security"
    }
    EOT
    },
    {
      webhook_url = "https://api.internal.com"
  }]
}

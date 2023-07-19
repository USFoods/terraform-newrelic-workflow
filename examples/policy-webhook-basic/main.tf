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
    name = "Example Workflow Webhook Destination"
    type = "WEBHOOK"
    enabled = var.enabled
    policy_ids = [newrelic_alert_policy.example.id]

    webhook_url = "https://api.monitoring.com"
}

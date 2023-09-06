provider "newrelic" {
  account_id = var.account_id
}

resource "newrelic_alert_policy" "example" {
  account_id          = var.account_id
  name                = "Example Policy"
  incident_preference = "PER_POLICY"
}

resource "newrelic_notification_destination" "example_destination" {
  account_id = var.account_id
  name       = "Example Webhook Destination"
  type       = "WEBHOOK"

  property {
    key   = "url"
    value = "https://api.newrelic.com"
  }
}

data "newrelic_notification_destination" "example_destination" {
  name = newrelic_notification_destination.example_destination.name
}

# This is the bare minimum configuration required for a workflow
# with a webhook destination targetting a policy
module "main" {
  source = "../.."

  account_id = var.account_id
  name       = "Example Workflow Webhook Destination"
  enabled    = var.enabled
  policy_ids = [newrelic_alert_policy.example.id]

  webhook_id = data.newrelic_notification_destination.example_destination.id
  #webhook_url = "https://api.newrelic.com"
}

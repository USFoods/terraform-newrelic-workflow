provider "newrelic" {
  account_id = var.account_id
}

resource "newrelic_alert_policy" "example" {
  account_id          = var.account_id
  name                = "Example Policy"
  incident_preference = "PER_POLICY"
}

# This is the bare minimum configuration required for a workflow
# with an email destination targetting a policy
module "main" {
  source = "../.."

  account_id = var.account_id
  name       = "Example Workflow Email Destination"
  type       = "EMAIL"
  enabled    = var.enabled
  policy_ids = [newrelic_alert_policy.example.id]

  email_addresses = [ "robert.example@fake.com" ]
}
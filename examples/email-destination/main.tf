provider "newrelic" {
  account_id = var.account_id
}

resource newrelic_alert_policy "example" {
    account_id = var.account_id
    name       = "Example Policy"
    incident_preference = "PER_POLICY"
}

# This is the bare minimum configuration required
module "main" {
  source = "../.."

  account_id = var.account_id
  name       = "Example Workflow Email Destination"
  type       = "EMAIL"
  enabled    = var.enabled
  policy_ids = [ newrelic_alert_policy.example.id ]
  email_addresses = ["devin.miller@usfoods.com"]

  email_destinations = [
    {
      email_addresses = ["devin.miller@usfoods.com"]
    }
  ]
}
provider "newrelic" {
  account_id = var.account_id
}

resource "newrelic_alert_policy" "example" {
  account_id          = var.account_id
  name                = "Example Policy"
  incident_preference = "PER_POLICY"
}

# This is the bare minimum configuration required for a workflow
# with multiple email destinations targetting a policy
module "main" {
  source = "../.."

  account_id = var.account_id
  name       = "Example Workflow Email Destination"
  type       = "EMAIL"
  enabled    = var.enabled
  policy_ids = [newrelic_alert_policy.example.id]

  # This is only required if the email subject or body needs to be
  # different between destinations, otherwise multiple email addresses
  # can be specified in the 'email_addresses' variable 
  email_destinations = [
    {
      email_subject   = "Example Email Subject One"
      email_addresses = ["robert.example@fake.com"]
    },
    {
      email_subject   = "Example Email Subject Two"
      email_addresses = ["jane.example@fake.com"]
    }
  ]
}
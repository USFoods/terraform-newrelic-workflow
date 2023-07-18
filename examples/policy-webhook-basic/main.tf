provider "newrelic" {
  account_id = var.account_id
}

resource "newrelic_alert_policy" "example" {
  account_id          = var.account_id
  name                = "Example Policy"
  incident_preference = "PER_POLICY"
}

module "main" {
  source = "../.."

    account_id = var.account_id
    name = "Example Workflow Webhook Destination"
    type = "WEBHOOK"
    enabled = var.enabled
    policy_ids = [newrelic_alert_policy.example.id]

}

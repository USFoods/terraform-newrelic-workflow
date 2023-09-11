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
  name       = "Example Workflow Multiple Destinations"
  enabled    = var.enabled
  policy_ids = [newrelic_alert_policy.example.id]

  webhook_destinations = [
    {
      webhook_url     = "https://api.monitoring.com"
      webhook_headers = <<-EOT
      {
        "x-api-key": "secure_string_for_security"
      }
      EOT
      webhook_payload = <<-EOT
      {
        "id": {{ json issueId }},
        "issueUrl": {{ json issuePageUrl }},
        "title": {{ json annotations.title.[0] }},
        "priority": {{ json priority }},
        "state": {{ json state }},
        "trigger": {{ json triggerEvent }},
        "alertPolicyNames": {{ json accumulations.policyName }},
        "alertConditionNames": {{ json accumulations.conditionName }},
        "workflowName": {{ json workflowName }},
        "supportGroup": Site Reliability Engineering
      }
      EOT
    }
  ]

  email_destinations = [
    {
      email_addresses = ["robert.example@fake.com"]
      email_subject   = "Alert Notification for {{ issueTitle }}"
      email_details   = "View Details at {{ issueUrl }}"
    }
  ]
}

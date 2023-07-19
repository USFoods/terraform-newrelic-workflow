terraform {
  required_version = ">=1.3"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = ">=3.14"
    }
  }
}

locals {
  payload = <<-EOF
	id: {{ json issueId }},
	issueUrl: {{ json issuePageUrl }},
	title: {{ json annotations.title.[0] }},
	priority: {{ json priority }},
	impactedEntities: {{json entitiesData.names}},
	totalIncidents: {{json totalIncidents}},
	state: {{ json state }},
	trigger: {{ json triggerEvent }},
	isCorrelated: {{ json isCorrelated }},
	createdAt: {{ createdAt }},
	updatedAt: {{ updatedAt }},
	sources: {{ json accumulations.source }},
	alertPolicyNames: {{ json accumulations.policyName }},
	alertConditionNames: {{ json accumulations.conditionName }},
	workflowName: {{ json workflowName }}"
EOF

  # Merge properties into a map to support the dynamic property block
  properties = merge(
    var.webhook_headers != null ? {
      "headers" = var.webhook_headers
    } : {},
    {
      "payload" = coalesce(var.webhook_payload, local.payload)
    }
  )
}

resource "newrelic_notification_destination" "this" {
  account_id = var.account_id
  name       = "${var.name} Webhook Destination"
  type       = "WEBHOOK"

  property {
    key   = "url"
    value = var.webhook_url
  }
}

resource "newrelic_notification_channel" "this" {
  account_id     = var.account_id
  name           = var.name
  type           = "WEBHOOK"
  destination_id = newrelic_notification_destination.this.id
  product        = "IINT"

  # At least one property block is always required
  property {
    key = ""
    value = ""
  }

  dynamic "property" {
    for_each = local.properties

    content {
      key   = property.key
      value = property.value
    }
  }
}

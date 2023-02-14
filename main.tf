resource "newrelic_notification_destination" "email_notification_destination" {
  account_id = coalesce(var.parent_id, var.account_id)
  name       = "${var.name} Destination"
  type       = "EMAIL"

  property {
    key   = "email"
    value = join(",", var.email_addresses)
  }
}

resource "newrelic_notification_channel" "email_notification_channel" {
  account_id     = coalesce(var.parent_id, var.account_id)
  name           = var.name
  type           = "EMAIL"
  destination_id = newrelic_notification_destination.email_notification_destination.id
  product        = "IINT"

  // At least one property block is required, even if empty
  property {
    key   = ""
    value = ""
  }

  dynamic "property" {
    for_each = var.email_properties
    content {
      key   = property.key
      value = property.value
    }
  }
}

resource "newrelic_workflow" "email_notification_workflow" {
  account_id = coalesce(var.parent_id, var.account_id)

  name                  = var.name
  enabled               = var.enabled
  muting_rules_handling = var.muting

  issues_filter {
    name = var.name
    type = "FILTER"

    predicate {
      attribute = "labels.policyIds"
      operator  = "EXACTLY_MATCHES"
      values    = var.policy_ids
    }
  }

  enrichments {
    dynamic "nrql" {
        for_each = var.enrichments

        content {
        
            name = enrichments.key
            configuration {
                query = enrichments.value
            }
        }
    }
  }

  destination {
    channel_id            = newrelic_notification_channel.email_notification_channel.id
    notification_triggers = var.notification_triggers
  }
}

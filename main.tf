locals {
  # If policy_ids is set, then we need to add a filter for it
  policies_filter = try(length(var.policy_ids) > 0, false) ? [
    {
      attribute = "labels.policyIds"
      operator  = "EXACTLY_MATCHES"
      values    = var.policy_ids
    }
  ] : []

  issues_filter = concat(
    var.issues_filter,
    local.policies_filter
  )

  # Using seperate input variables for simple scenarios, but
  # combine to create a single email destination
  single_email_destination = var.email_addresses != null ? [
    {
      email_addresses = var.email_addresses
      email_subject   = var.email_subject
      email_details   = var.email_details
    }
  ] : []

  email_destinations = concat(
    var.email_destinations,
    local.single_email_destination
  )

  # Using seperate unput variables for simple scenarios, but
  # combine to create a single webhook destination
  single_webhook_destination = (var.webhook_url != null || var.webhook_id != null) ? [
    {
      webhook_id      = var.webhook_id
      webhook_url     = var.webhook_url
      webhook_headers = var.webhook_headers
      webhook_payload = var.webhook_payload
    }
  ] : []

  webhook_destinations = concat(
    var.webhook_destinations,
    local.single_webhook_destination
  )
}

# Create any email destinations that have been defined
module "email_destinations" {
  count = length(local.email_destinations)

  source = "./modules/email-destination"

  account_id      = var.account_id
  name            = var.name
  email_addresses = local.email_destinations[count.index].email_addresses
  email_subject   = local.email_destinations[count.index].email_subject
  email_details   = local.email_destinations[count.index].email_details
}

# Create any webhook destinations that have been defined
module "webhook_destinations" {
  count = length(local.webhook_destinations)

  source = "./modules/api-destination"

  account_id = var.account_id
  name       = var.name

  webhook_id      = local.webhook_destinations[count.index].webhook_id
  webhook_url     = local.webhook_destinations[count.index].webhook_url
  webhook_headers = local.webhook_destinations[count.index].webhook_headers
  webhook_payload = local.webhook_destinations[count.index].webhook_payload
}

resource "newrelic_workflow" "this" {
  account_id = var.account_id

  name                  = var.name
  enabled               = var.enabled
  muting_rules_handling = var.muting

  issues_filter {
    name = var.name
    type = "FILTER"

    dynamic "predicate" {
      for_each = local.issues_filter

      content {
        attribute = predicate.value.attribute
        operator  = predicate.value.operator
        values    = predicate.value.values
      }
    }
  }

  dynamic "enrichments" {
    for_each = var.enrichments

    content {
      nrql {
        name = enrichments.name
        configuration {
          query = enrichments.query
        }
      }
    }
  }

  dynamic "destination" {
    for_each = concat(module.email_destinations, module.webhook_destinations)

    content {
      channel_id            = destination.value.channel_id
      notification_triggers = var.notification_triggers
    }
  }
}

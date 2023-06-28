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

  single_destination = var.email_addresses != null ? [
    {
      email_addresses = var.email_addresses
      email_subject   = var.email_subject
      email_details   = var.email_details
    }
  ] : []

  email_destinations = concat(
    var.email_destinations,
    local.single_destination
  )
}

module "email_destinations" {
  count = length(var.email_destinations)

  source = "./modules/email-destination"

  account_id      = var.account_id
  name            = var.name
  email_addresses = var.email_destinations[count.index].email_addresses
  email_subject   = var.email_destinations[count.index].email_subject
  email_details   = var.email_destinations[count.index].email_details

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
    for_each = module.email_destinations

    content {
      channel_id            = destination.value.channel_id
      notification_triggers = var.notification_triggers
    }
  }
}
module "email_destination" {
  count = length(var.email_destinations)

  source = "./modules/email-destination"

  account_id      = var.account_id
  name            = var.name
  email_addresses = var.email_destinations[count.index].email_addresses

}

resource "newrelic_workflow" "this" {
  account_id = var.account_id

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

  dynamic "enrichments" {
    for_each = var.enrichments == null ? [] : [1]

    content {
      dynamic "nrql" {
        for_each = var.enrichments

        content {
          name = nrql.key
          configuration {
            query = nrql.value
          }
        }
      }
    }
  }

  dynamic "destination" {
    for_each = module.email_destination

    content {
      channel_id            = destination.value.channel_id
      notification_triggers = var.notification_triggers
    }
  }
}

#   destination {
#     channel_id            = compact(
#         [try(module.email_destination[0].channel_id, "")]
#     )
#     notification_triggers = var.notification_triggers
#   }
# }

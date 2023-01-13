output "email_notification_destination" {
  value = {
    id = newrelic_notification_destination.email_notification_destination.id
    account_id = newrelic_notification_destination.email_notification_destination.account_id
    name = newrelic_notification_destination.email_notification_destination.name
    properties = { for p in  newrelic_notification_destination.email_notification_destination.property: p.key => p.value }
  }
}

output "email_notification_channel" {
  value = {
    id          = newrelic_notification_channel.email_notification_channel.id
    name        = newrelic_notification_channel.email_notification_channel.name
    type        = newrelic_notification_channel.email_notification_channel.type
    destination = newrelic_notification_channel.email_notification_channel.destination_id
    properties  = { for p in newrelic_notification_channel.email_notification_channel.property: p.key => p.value if p.key != "" }
  }
}

output "email_workflow" {
  value = {
    id = newrelic_workflow.email_notification_workflow.id
    name = newrelic_workflow.email_notification_workflow.name
    enabed = newrelic_workflow.email_notification_workflow.enabled
    muting = newrelic_workflow.email_notification_workflow.muting_rules_handling
    issues_filter = { for i in  newrelic_workflow.email_notification_workflow.issues_filter: i.name => i.predicate }
  }
}

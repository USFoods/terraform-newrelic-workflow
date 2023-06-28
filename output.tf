# output "email_notification_destination" {
#   value = {
#     id = newrelic_notification_destination.email_notification_destination.id
#     account_id = newrelic_notification_destination.email_notification_destination.account_id
#     name = newrelic_notification_destination.email_notification_destination.name
#     properties = { for p in  newrelic_notification_destination.email_notification_destination.property: p.key => p.value }
#   }
# }

# output "email_notification_channel" {
#   value = {
#     id          = newrelic_notification_channel.email_notification_channel.id
#     name        = newrelic_notification_channel.email_notification_channel.name
#     type        = newrelic_notification_channel.email_notification_channel.type
#     destination = newrelic_notification_channel.email_notification_channel.destination_id
#     properties  = { for p in newrelic_notification_channel.email_notification_channel.property: p.key => p.value if p.key != "" }
#   }
# }

# output "workflow" {
#   value = {
#     id            = newrelic_workflow.this.id
#     name          = newrelic_workflow.this.name
#     enabed        = newrelic_workflow.this.enabled
#     muting        = newrelic_workflow.this.muting_rules_handling
#     issues_filter = { for i in newrelic_workflow.this.issues_filter : i.name => i.predicate }
#   }
# }

output "workflow_id" {
  value = newrelic_workflow.this.id
}

output "workflow_name" {
  value = newrelic_workflow.this.name
}

output "workflow_enabled" {
  value = newrelic_workflow.this.enabled
}

output "workflow_muting" {
  value = newrelic_workflow.this.muting_rules_handling
}

output "email_destinations" {
  value = module.email_destinations
}

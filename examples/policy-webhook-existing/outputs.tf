output "workflow_id" {
  value = module.main.workflow_id
}

output "workflow_name" {
  value = module.main.workflow_name
}

output "workflow_enabled" {
  value = module.main.workflow_enabled
}

output "workflow_muting" {
  value = module.main.workflow_muting
}

output "webhook_destinations" {
  value = module.main.webhook_destinations
}

output "data_source" {
  value = data.newrelic_notification_destination.example_destination
}

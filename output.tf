output "workflow_id" {
  value       = newrelic_workflow.this.id
  description = "The Id of the workflow"
}

output "workflow_name" {
  value       = newrelic_workflow.this.name
  description = "The name of the workflow"
}

output "workflow_enabled" {
  value       = newrelic_workflow.this.enabled
  description = "Whether the workflow is enabled"
}

output "workflow_muting" {
  value       = newrelic_workflow.this.muting_rules_handling
  description = "How the workflow handles muted issues"
}

output "email_destinations" {
  value       = module.email_destinations
  description = "The list of email destinations defined for the workflow"
}

output "webhook_destinations" {
  value       = module.webhook_destinations
  description = "The webhook destination defined for the workflow"
}

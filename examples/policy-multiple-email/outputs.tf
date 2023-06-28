output "workflow_id" {
  value = module.main.id
}

output "workflow_name" {
  value = module.main.name
}

output "workflow_enabled" {
  value = module.main.enabled
}

output "workflow_muting" {
  value = module.main.muting_rules_handling
}

output "email_destinations" {
  value = module.main.email_destinations
}
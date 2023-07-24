output "destination_id" {
  value = newrelic_notification_destination.this.id
}

output "channel_id" {
  value = newrelic_notification_channel.this.id
}

output "webhook_url" {
  # There should be only one property block, but we'll use try() just in case
  value = try(one(newrelic_notification_destination.this.property)["value"], "")
}

output "webhook_headers" {
  value = try(one([for p in newrelic_notification_channel.this.property : p if p.key == "headers"])["value"], "")
}

output "webhook_payload" {
  value = try(one([for p in newrelic_notification_channel.this.property : p if p.key == "payload"])["value"], "")
}

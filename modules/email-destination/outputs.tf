output "destination_id" {
  value = newrelic_notification_destination.this.id
}

output "channel_id" {
  value = newrelic_notification_channel.this.id
}

output "email_addresses" {
  # There should be only one property block, but we'll use try() just in case
  value = try(one([for p in newrelic_notification_destination.this.property : p["value"] if p.key == "email"]), "")
}

output "email_subject" {
  value = try(one([for p in newrelic_notification_channel.this.property : p if p.key == "subject"])["value"], "")
}

output "email_details" {
  value = try(one([for p in newrelic_notification_channel.this.property : p if p.key == "customDetailsEmail"])["value"], "")
}

terraform {
  required_version = ">=1.3"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = ">=3.14"
    }
  }
}

resource "newrelic_notification_destination" "this" {
  account_id = var.account_id
  name       = "${var.name} Email Destination"
  type       = "EMAIL"

  property {
    key   = "email"
    value = join(",", var.email_addresses)
  }
}

resource "newrelic_notification_channel" "this" {
  account_id     = var.account_id
  name           = var.name
  type           = "EMAIL"
  destination_id = newrelic_notification_destination.this.id
  product        = "IINT"

  property {
    key   = "subject"
    value = coalesce(var.email_subject, "{{ issueTitle }} - Issue {{issueId}}")
  }

  property {
      key   = "customDetailsEmail"
      value = var.email_details
  }

  #   dynamic "property" {
  #     for_each = var.email_properties
  #     content {
  #       key   = property.key
  #       value = property.value
  #     }
  #   }
}
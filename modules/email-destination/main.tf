terraform {
  required_version = ">=1.3"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = ">=3.14"
    }
  }
}

locals {
  # Merge properties into a map to support the dynamic property block
  properties = merge(
    {
      "subject" = coalesce(var.email_subject, "{{ issueTitle }}")
    },
    var.email_details != null ? {
      "customDetailsEmail" = var.email_details
    } : {}
  )
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

  dynamic "property" {
    for_each = local.properties

    content {
      key   = property.key
      value = property.value
    }
  }
}

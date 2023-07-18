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
  type       = "WEBHOOK"

  property {
    key   = "url"
    value = var.url
  }
}

resource "newrelic_notification_channel" "this" {
  account_id     = var.account_id
  name           = var.name
  type           = "WEBHOOK"
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

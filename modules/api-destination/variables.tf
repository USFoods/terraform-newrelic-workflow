variable "account_id" {
  description = "Determines the New Relic account where resources will be created"
  type        = string
}

variable "name" {
  description = "The name of the destination"
  type        = string
}

variable "webhook_url" {
  description = "A list of email addresses"
  type        = string
}

variable "webhook_headers" {
    description = "A map of key/value pairs that represents the webhook headers"
    type = map(string)
    default = null
}

variable "webhook_payload" {
    description = "A map of key/value pairs that represents the webhook payload"
    type = map(string)
    default = null
}

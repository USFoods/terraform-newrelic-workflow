variable "account_id" {
  description = "Determines the New Relic account where resources will be created"
  type        = string
}

variable "type" {
  default     = "EMAIL"
  description = "The type of workflow destination"
  type        = string
}

variable "enabled" {
  default     = false
  description = "Whether workflow is enabled"
  type        = bool
}

variable "name" {
  description = "The name of the workflow"
  type        = string
}

variable "muting" {
  default     = "DONT_NOTIFY_FULLY_OR_PARTIALLY_MUTED_ISSUES"
  description = "How to handle muted issues"
  type        = string
}

variable "enrichments" {
  default     = []
  description = "The workflow's notification enrichments"
  type = list(object({
    name  = string
    query = string
  }))

  validation {
    condition     = length(var.enrichments) <= 2
    error_message = "The maximum number of enrichments per workflow is 2"
  }
}

variable "issues_filter" {
  default     = []
  description = "Filters used to identify issues handled by this workflow."
  type = list(object({
    attribute = string
    operator  = string
    values    = list(any)
  }))
}

# Provides a convenient shortcut for configuring issues filters based on policy ids
variable "policy_ids" {
  default     = []
  description = "List of policy ids to be include in the workflow issues filter"
  type        = list(string)
}

# Variables for email destination
variable "email_destinations" {
  default     = []
  description = "List of email destinations to receive alert notifications"
  type = list(object({
    email_addresses = list(string)
    email_subject   = optional(string, "")
    email_details   = optional(string, "")
  }))
}

variable "email_addresses" {
  default     = null
  description = "List of email adresses to receive alert notifications"
  type        = list(string)
}

variable "email_subject" {
  description = "Free text that represents the email subject title"
  type        = string
  default     = null
}

variable "email_details" {
  description = "Free text that represents the email custom details"
  type        = string
  default     = null
}

variable "webhook_destinations" {
  default     = []
  description = "List of webhook destinations to receive alert notifications"
  type = list(object({
    webhook_url    = string
    webook_headers = map(string)
    webook_payload = string
  }))
}

variable "webhook_url" {
  default     = null
  description = "Url of webhook to receive notification"
  type        = string
}

variable "webhook_headers" {
  default     = null
  description = "A map of key/value pairs that represents the webhook headers"
  type        = string
}

variable "webhook_payload" {
  default     = null
  description = "A map of key/value pairs that represents the webhook payload"
  type        = string
}

variable "notification_triggers" {
  default     = []
  description = "Issue events to notify on"
  type        = list(string)
}



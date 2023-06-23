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
  default     = null
  description = "The workflow's notification enrichments"
  type        = map(string)
}

# Variables for email destination
variable "email_destinations" {
  type = list(object({
    email_addresses = list(string)
    email_subject   = optional(string, null)
    email_details   = optional(string, null)
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

variable "notification_triggers" {
  default     = []
  description = "Issue events to notify on"
  type        = list(string)
}

variable "policy_ids" {
  default     = []
  description = "List of policy ids to be include in the workflow issues filter"
  type        = list(string)
}



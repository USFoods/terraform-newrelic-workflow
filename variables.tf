variable "account_id" {
  description = "Determines the New Relic account where resources will be created"
  type        = string
}

variable "parent_id" {
  default     = ""
  description = "Determines the New Relic account where workflows will be created"
  type        = string
}

variable "name" {
  type = string
}

variable "enabled" {
  type = bool
}

variable "email_addresses" {
  description = "List of email adresses to receive alert notifications"
  type        = list(string)
}

variable "email_properties" {
  default     = []
  description = "Nested block that describes additional email properties"
  type        = list(map(string))
}

variable "muting" {
  default     = "DONT_NOTIFY_FULLY_OR_PARTIALLY_MUTED_ISSUES"
  description = "How to handle muted issues"
  type        = string
}

variable "notification_triggers" {
  default     = []
  description = "Issue events to notify on"
  type        = list(string)
}

variable "policy_ids" {
  description = "List of policy ids to be include in the workflow issues filter"
  type        = list(string)
}

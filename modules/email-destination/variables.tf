variable "account_id" {
  description = "Determines the New Relic account where resources will be created"
  type        = string
}

variable "name" {
  description = "The name of the destination"
  type        = string
}

variable "email_addresses" {
  description = "A list of email addresses"
  type        = list(string)
}

variable "email_subject" {
  description = "Free text that represents the email subject title"
  type        = string
  default     = ""
}

variable "email_details" {
  description = "Free text that represents the email custom details"
  type        = string
  default     = ""
}

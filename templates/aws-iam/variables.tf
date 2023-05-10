variable "users" {
  description = "Map of user names to configuration."
  type        = map(any)
}

variable "user_groups" {
  description = "Map of user groups and associated custom policies"
  type        = map(any)
}

variable "actions" {
  description = "Map of user groups and associated custom policies"
  type        = map(any)
}

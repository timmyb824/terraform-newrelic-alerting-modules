# Alert policy and notification channel variables
variable "alert_policy_name" {
    description = "name of the alert policy"
    type = string
    default = null
}

variable "channel_name" {
    description = "notification channel name"
    type = list(string)
}

variable "incident_preference" {
    description = "The rollup strategy for the policy."
    type = string
    default = "PER_POLICY"
}

# NRQL and Infrastructure alert condition variables
variable "nrql_conditions" {
    description = "object that is passed to create nrql conditions"
    type = map
    default = {}
}

variable "infra_conditions" {
    description = "object that is passed to create infrastructure conditions"
    type = map
    default = {}
}


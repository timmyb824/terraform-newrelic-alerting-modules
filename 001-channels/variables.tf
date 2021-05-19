# New Relic provider variables (could also be stored as env variables)
variable "nr_api_key" {
    description = "The New Relic API key"
    type = string
}

variable "nr_account_id" {
    description = "Your New Relic Account Id"
    type = string
}

variable "nr_region" {
    description = "Your New Relic Accounts data center region. US or EU."
    type = string
    default = "US"
}

# Notification channels variable
variable "alert_channels" {
    description = "object that is passed to create notification channels"
    type = map
    default = {}
}


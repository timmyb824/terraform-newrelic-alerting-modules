# creates conditions, alert policy, and subscribes channels
module "alerts" {
  source            = "../modules/alerts"
  alert_policy_name = var.alert_policy_name
  nrql_conditions   = var.nrql_conditions
  infra_conditions  = var.infra_conditions
  channel_name      = var.channel_name
}
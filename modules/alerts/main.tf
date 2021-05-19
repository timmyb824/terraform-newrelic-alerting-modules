# Pulls channel id's for corresponding channel names
data "newrelic_alert_channel" "notification_channels" {
   for_each = toset(var.channel_name)
   name     = each.key
 }

# Creates an alert policy
resource "newrelic_alert_policy" "alert_policy" {
  name                = var.alert_policy_name
  incident_preference = var.incident_preference
}

# Connects the notification channel(s) to the policy using the channel id(s)
resource "newrelic_alert_policy_channel" "policy_channel" {
  for_each    = data.newrelic_alert_channel.notification_channels
  policy_id   = newrelic_alert_policy.alert_policy.id
  channel_ids = [
      each.value.id
  ]
}

# Creates nqrl alert conditions under the alert policy
resource "newrelic_nrql_alert_condition" "nrql_alert_condition" {
  for_each                     = var.nrql_conditions
  policy_id                    = newrelic_alert_policy.alert_policy.id
  type                         = each.value.type
  description                  = each.value.description
  name                         = each.value.name
  enabled                      = each.value.enabled
  violation_time_limit_seconds = each.value.violation_time_limit_seconds
  value_function               = each.value.value_function
  runbook_url                  = each.value.runbook_url

  baseline_direction           = each.value.baseline_direction

  fill_option                  = each.value.fill_option
  fill_value                   = each.value.fill_value

  expected_groups                 = each.value.expected_groups
  open_violation_on_group_overlap = each.value.open_violation_on_group_overlap

  aggregation_window             = each.value.aggregation_window
  expiration_duration            = each.value.expiration_duration
  open_violation_on_expiration   = each.value.open_violation_on_expiration
  close_violations_on_expiration = each.value.close_violations_on_expiration

  nrql {
    query             = each.value.nrql.query
    evaluation_offset = each.value.nrql.evaluation_offset
  }

  critical {
    operator              = each.value.critical.operator
    threshold             = each.value.critical.threshold
    threshold_duration    = each.value.critical.threshold_duration
    threshold_occurrences = each.value.critical.threshold_occurrences
  }

## Only creates warning block if threshold and required values are provided.
## Otherwise if threshold is null then no warning block is created.
  dynamic "warning" {
    for_each                = lookup(each.value.warning, "threshold", [])[*]
    content {
      operator              = lookup(each.value.warning, "operator", [])
      threshold             = lookup(each.value.warning, "threshold", [])
      threshold_duration    = lookup(each.value.warning, "threshold_duration", [])
      threshold_occurrences = lookup(each.value.warning, "threshold_occurrences", [])
  }
 }
}

# Creates infrastructure alert conditions under the alert policy
resource "newrelic_infra_alert_condition" "infra_alert_condition" {
  for_each = var.infra_conditions
  policy_id             = newrelic_alert_policy.alert_policy.id

  name                  = each.value.name
  type                  = each.value.type
  description           = each.value.description
  enabled               = each.value.enabled
  event                 = each.value.event
  select                = each.value.select
  comparison            = each.value.comparison
  where                 = each.value.where
  process_where         = each.value.process_where
  integration_provider  = each.value.integration_provider
  runbook_url           = each.value.runbook_url
  violation_close_timer = each.value.violation_close_timer

   critical {
        value              = each.value.critical.value
        duration           = each.value.critical.duration
        time_function      = each.value.critical.time_function
  }

## Only creates warning block if threshold and required values are provided.
## Otherwise if threshold is null then no warning block is created.
  dynamic "warning" {
    for_each           = lookup(each.value.warning, "value", [])[*]
    content {
      value                = lookup(each.value.warning, "value", [])
      duration             = lookup(each.value.warning, "duration", [])
      time_function        = lookup(each.value.warning, "time_function", [])
    }
  }
}
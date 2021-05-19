# Creates slack and/or email notification channels
resource "newrelic_alert_channel" "alert_channel" {
  for_each = var.alert_channels
  name     = each.value.channel_name
  type     = each.value.channel_type

  config {
      url                         = each.value.slack_url
      include_json_attachment     = each.value.include_json_attachment
      channel                     = each.value.slack_channel
      recipients                  = each.value.email_recipients
    }
}


# creates notification channels
module "channels" {
  source         = "../modules/channels"
  alert_channels = var.alert_channels
}

resource "google_monitoring_notification_channel" "notification_channel" {
  #count = var.database != "" ? 1 : 0
  for_each = toset(var.notification_email)
  #for_each = var.database != "" ? toset(var.notification_email) : {}
  project = "vivid-ocean-386206"

  display_name = lookup(var.notification_channel, each.value, "Default Display Name")
  type         = "email"
  labels = {
    email_address = each.value
  }
}

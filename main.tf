module "cloud_sql_alerts" {
  source = "./Modules/Monitoring" # Replace with the relative path to the directory containing these files

  project_id           = var.project_id
  database             = var.database
  app_name             = var.app_name
  environment          = var.environment
  notification_email   = var.notification_email
  notification_channel = var.notification_channel
  alert_durations      = var.alert_durations
  alert_thresholds     = var.alert_thresholds
  alert_config         = var.alert_config

  # Optional arguments for dashboard creation
  create_dashboard      = var.create_dashboard
  dashboard_displayname = var.dashboard_displayname
}

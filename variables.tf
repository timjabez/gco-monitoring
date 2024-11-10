variable "project_id" {
  type        = string
  description = "The Project ID to create this module's resource in"
}

variable "database" {
  type    = string
  default = ""
}

variable "app_name" {
  type        = string
  description = "Name of the application"
  default     = ""
}

variable "environment" {
  type        = string
  description = "Environment"
  default     = ""
}
variable "dashboard_displayname" {
  type        = string
  description = "Environment"
  default     = "Custom CloudSQL Dashboard"
}
variable "create_dashboard" {
  description = "Boolean to control the creation of the dashboard"
  type        = bool
  default     = true
}

variable "notification_email" {
  description = "List of email addresses for creating notification channels"
  type        = list(string)
  default     = ["example1@example.com", "maravi@google.com"]
}

variable "notification_channel" {
  description = "Map of email addresses to their corresponding display names"
  type        = map(string)
  default = {
    "example1@example.com" = "User One"
    "maravi@google.com"    = "User Two"
  }
}


variable "alert_durations" {
  type = object({
    #sql_uptime_alert_duration                = string
    sql_server_up_alert_duration            = string
    sql_cpu_alert_duration                  = string
    sql_memory_alert_duration               = string
    sql_disk_utilization_alert_duration     = string
    sql_disk_quota_alert_duration           = string
    sql_memory_quota_alert_duration         = string
    sql_postgres_connections_alert_duration = string
    sql_instance_state_alert_duration       = string
    sql_replica_lag_alert_duration          = string

  })
  description = "Duration values for all alerts"
  default = {
    #sql_uptime_alert_duration                = "120s"
    sql_server_up_alert_duration            = "60s"
    sql_cpu_alert_duration                  = "300s"
    sql_memory_alert_duration               = "180s"
    sql_disk_utilization_alert_duration     = "180s"
    sql_disk_quota_alert_duration           = "120s"
    sql_memory_quota_alert_duration         = "120s"
    sql_postgres_connections_alert_duration = "120s"
    sql_instance_state_alert_duration       = "60s"
    sql_replica_lag_alert_duration          = "120s"
  }
}

variable "alert_thresholds" {
  type = object({
    #sql_uptime_threshold               = number
    sql_server_up_threshold            = number
    sql_cpu_threshold                  = number
    sql_memory_threshold               = number
    sql_disk_utilization_threshold     = number
    sql_disk_quota_threshold           = number
    sql_memory_quota_threshold         = number
    sql_postgres_connections_threshold = number
    sql_instance_state_threshold       = number
    sql_replica_lag_threshold          = number
  })
  description = "Threshold values for all alerts"
  default = {
    #sql_uptime_threshold               = 60
    sql_server_up_threshold            = 1
    sql_cpu_threshold                  = 0.9
    sql_memory_threshold               = 0.9
    sql_disk_utilization_threshold     = 0.8
    sql_disk_quota_threshold           = 10
    sql_memory_quota_threshold         = 10
    sql_postgres_connections_threshold = 2000
    sql_instance_state_threshold       = 1
    sql_replica_lag_threshold          = 5 #A negative value indicates that replication is inactive.
  }
}

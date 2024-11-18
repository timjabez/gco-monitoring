variable "project_id" {
  type        = string
  description = "The Project ID to create this module's resource in"
}

variable "database" {
  type = string
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
  default     = []
}

variable "notification_channel" {
  description = "Map of email addresses to their corresponding display names"
  type        = map(string)
  default = {
    # "example1@example.com" = "User One"
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

variable "alert_config" {
  type = object({
    uptime = object({
      filter             = string
      threshold          = number
      comparison         = string
      duration           = string
      alignment_period   = string
      per_series_aligner = string
    })
    server_up = object({
      filter             = string
      threshold          = number
      comparison         = string
      duration           = string
      alignment_period   = string
      per_series_aligner = string
    })
    cpu = object({
      filter             = string
      threshold          = number
      comparison         = string
      duration           = string
      alignment_period   = string
      per_series_aligner = string
    })
    memory = object({
      filter             = string
      threshold          = number
      comparison         = string
      duration           = string
      alignment_period   = string
      per_series_aligner = string
    })
    disk_utilization = object({
      filter             = string
      threshold          = number
      comparison         = string
      duration           = string
      alignment_period   = string
      per_series_aligner = string
    })
    disk_quota = object({
      filter             = string
      threshold          = number
      comparison         = string
      duration           = string
      alignment_period   = string
      per_series_aligner = string
    })
    memory_quota = object({
      filter             = string
      threshold          = number
      comparison         = string
      duration           = string
      alignment_period   = string
      per_series_aligner = string
    })
    postgres_connections = object({
      filter             = string
      threshold          = number
      comparison         = string
      duration           = string
      alignment_period   = string
      per_series_aligner = string
    })
    instance_state = object({
      filter             = string
      threshold          = number
      comparison         = string
      duration           = string
      alignment_period   = string
      per_series_aligner = string
    })
    replica_lag = object({
      filter             = string
      threshold          = number
      comparison         = string
      duration           = string
      alignment_period   = string
      per_series_aligner = string
    })
  })
  description = "Configurations for alert durations and thresholds"
  default = {
    uptime = {
      filter             = "metric.type=\"cloudsql.googleapis.com/database/uptime\" resource.type=\"cloudsql_database\"  "
      threshold          = 60
      comparison         = "COMPARISON_LT"
      duration           = "120s"
      alignment_period   = "60s"
      per_series_aligner = "ALIGN_MAX"
    }
    server_up = {
      filter             = "metric.type=\"cloudsql.googleapis.com/database/up\" resource.type=\"cloudsql_database\" "
      threshold          = 1
      comparison         = "COMPARISON_LT"
      duration           = "60s"
      alignment_period   = "60s"
      per_series_aligner = "ALIGN_SUM"
    }
    cpu = {
      filter             = "metric.type=\"cloudsql.googleapis.com/database/cpu/utilization\" resource.type=\"cloudsql_database\"  "
      threshold          = 0.9
      comparison         = "COMPARISON_GT"
      duration           = "300s"
      alignment_period   = "60s"
      per_series_aligner = "ALIGN_MAX"
    }
    memory = {
      filter             = "metric.type=\"cloudsql.googleapis.com/database/memory/utilization\" resource.type=\"cloudsql_database\" "
      threshold          = 0.9
      comparison         = "COMPARISON_GT"
      duration           = "180s"
      alignment_period   = "60s"
      per_series_aligner = "ALIGN_MAX"
    }
    disk_utilization = {
      filter             = "metric.type=\"cloudsql.googleapis.com/database/disk/utilization\" resource.type=\"cloudsql_database\" "
      threshold          = 0.8
      comparison         = "COMPARISON_GT"
      duration           = "180s"
      alignment_period   = "60s"
      per_series_aligner = "ALIGN_MAX"
    }
    disk_quota = {
      filter             = "metric.type=\"cloudsql.googleapis.com/database/disk/quota\" resource.type=\"cloudsql_database\" "
      threshold          = 10
      comparison         = "COMPARISON_GT"
      duration           = "120s"
      alignment_period   = "60s"
      per_series_aligner = "ALIGN_MAX"
    }
    memory_quota = {
      filter             = "metric.type=\"cloudsql.googleapis.com/database/memory/quota\" resource.type=\"cloudsql_database\"  "
      threshold          = 10
      comparison         = "COMPARISON_GT"
      duration           = "120s"
      alignment_period   = "60s"
      per_series_aligner = "ALIGN_MAX"
    }
    postgres_connections = {
      filter             = "metric.type=\"cloudsql.googleapis.com/database/postgresql/num_backends\" resource.type=\"cloudsql_database\"  "
      threshold          = 2000
      comparison         = "COMPARISON_GT"
      duration           = "120s"
      alignment_period   = "60s"
      per_series_aligner = "ALIGN_MAX"
    }
    instance_state = {
      filter             = "metric.type=\"cloudsql.googleapis.com/database/instance_state\" resource.type=\"cloudsql_database\"  "
      threshold          = 1
      comparison         = "COMPARISON_LT"
      duration           = "60s"
      alignment_period   = "60s"
      per_series_aligner = "ALIGN_FRACTION_TRUE"
    }
    replica_lag = {
      filter             = "metric.type=\"cloudsql.googleapis.com/database/replication/replica_lag\" resource.type=\"cloudsql_database\"  "
      threshold          = 5 #A negative value indicates that replication is inactive.
      comparison         = "COMPARISON_GT"
      duration           = "120s"
      alignment_period   = "60s"
      per_series_aligner = "ALIGN_MEAN"
    }
  }
}

# This is where the main opinion / business logic / meat of the module resides.
# Other .tf files maybe be used as long as they are not reserved for other uses.  See the README.md for the list

# ********************************************************************************************
# Module Name: cloud_sql_server_up_alert
# Display Name: Cloud SQL Server Up Alert
# Description: This alert monitors the health of your Cloud SQL server and throws an alert if
# the server is down
# ********************************************************************************************

resource "google_monitoring_alert_policy" "cloud_sql_server_up_alert" {
  count = var.alert_thresholds.sql_server_up_threshold > 0 ? 1 : 0
  #count = (var.alert_thresholds.sql_server_up_threshold > 0 && var.database != "") ? 1 : 0
  display_name          = "${var.app_name} - Cloud SQL - ${var.environment} - Server Health Alert(SUM)"
  project               = var.project_id
  combiner              = "AND"
  notification_channels = values(google_monitoring_notification_channel.notification_channel)[*].id

  conditions {
    display_name = "${var.app_name} - Cloud SQL - ${var.environment} - Server Health Alert(SUM)"
    condition_threshold {
      filter          = "metric.type=\"cloudsql.googleapis.com/database/up\" resource.type=\"cloudsql_database\" "
      threshold_value = var.alert_thresholds.sql_server_up_threshold
      comparison      = "COMPARISON_LT"
      duration        = var.alert_durations.sql_server_up_alert_duration
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }
  documentation {
    content   = "Cloud SQL Server - ${var.environment} for ${var.app_name} is down. Consider viewing the service logs to retrieve more information."
    mime_type = "text/markdown"
  }
}
# ********************************************************************************************
# Module Name: cloud_sql_cpu_alert
# Display Name: Cloud SQL CPU Alert
# Description: This alert monitors CPU utilization of Cloud SQL instance and throws an alert
# if the CPU utilization is above the configured threshold value
# ********************************************************************************************
resource "google_monitoring_alert_policy" "cloud_sql_cpu_alert" {
  count = var.alert_thresholds.sql_cpu_threshold > 0 ? 1 : 0
  #count = (var.alert_thresholds.sql_cpu_threshold > 0 && var.database != "") ? 1 : 0
  display_name          = "${var.app_name} - Cloud SQL - ${var.environment} - High CPU Utilization Alert(MAX)"
  project               = var.project_id
  combiner              = "AND"
  notification_channels = values(google_monitoring_notification_channel.notification_channel)[*].id
  conditions {
    display_name = "${var.app_name} - Cloud SQL - ${var.environment} - High CPU Utilization Alert"
    condition_threshold {
      filter          = "metric.type=\"cloudsql.googleapis.com/database/cpu/utilization\" metadata.system_labels.name = \"${var.database}\" resource.type=\"cloudsql_database\"  "
      threshold_value = var.alert_thresholds.sql_cpu_threshold
      comparison      = "COMPARISON_GT"
      duration        = var.alert_durations.sql_cpu_alert_duration
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MAX"
      }
    }
  }
  documentation {
    content   = "CPU utilization on Cloud SQL - ${var.environment} for ${var.app_name} is above ${var.alert_thresholds.sql_cpu_threshold}. Consider viewing the service logs to retrieve more information."
    mime_type = "text/markdown"
  }
}
/*
 # ********************************************************************************************
# Module Name: cloud_sql_memory_alert
# Display Name: Cloud SQL Memory Alert
# Description: This alert monitors memory consumption of Cloud SQL instance and throws an alert
# if the memory consumption is above the configured threshold value
# ********************************************************************************************
resource "google_monitoring_alert_policy" "cloud_sql_memory_alert" {
count = var.alert_thresholds.sql_memory_threshold > 0  ? 1 : 0
#count = (var.alert_thresholds.sql_memory_threshold > 0 && var.database != "") ? 1 : 0
    display_name = "${var.app_name} - Cloud SQL - ${var.environment} - High Memory Utilization Alert(MAX)"
  project      = var.project_id
    combiner     = "AND"
notification_channels = values(google_monitoring_notification_channel.notification_channel)[*].id
  conditions {
    display_name = "${var.app_name} - Cloud SQL - ${var.environment} - High Memory Utilization Alert(MAX)"
    condition_threshold {
      filter          = "metric.type=\"cloudsql.googleapis.com/database/memory/utilization\" metadata.system_labels.name = \"${var.database}\" resource.type=\"cloudsql_database\" "
      threshold_value = var.alert_thresholds.sql_memory_threshold
      comparison      = "COMPARISON_GT"
      duration        = var.alert_durations.sql_memory_alert_duration
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MAX"
      }
    }
  }
  documentation {
    content   = "Memory consumption on Cloud SQL - ${var.environment} for ${var.app_name} is above ${var.alert_thresholds.sql_memory_threshold}. Consider viewing the service logs to retrieve more information."
    mime_type = "text/markdown"
  }
}
 
 
# ********************************************************************************************
# Module Name: cloud_sql_disk_utilization_alert
# Display Name: Cloud SQL Disk Utilization Alert
# Description: This alert monitors disk utilization of Cloud SQL instance and throws an alert
# if the usage is above the configured threshold value
# ********************************************************************************************
resource "google_monitoring_alert_policy" "cloud_sql_disk_utilization_alert" {
count = var.alert_thresholds.sql_disk_utilization_threshold > 0  ? 1 : 0
#count = (var.alert_thresholds.sql_disk_utilization_threshold > 0 && var.database != "") ? 1 : 0
    display_name = "${var.app_name} - Cloud SQL - ${var.environment} - High Disk Utilization Alert(MAX)"
  project      = var.project_id
   combiner     = "AND"
  notification_channels = values(google_monitoring_notification_channel.notification_channel)[*].id
  conditions {
    display_name = "${var.app_name} - Cloud SQL - ${var.environment} - High Disk Utilization Alert(MAX)"
    condition_threshold {
      filter          = "metric.type=\"cloudsql.googleapis.com/database/disk/utilization\" metadata.system_labels.name = \"${var.database}\" resource.type=\"cloudsql_database\" "
      threshold_value = var.alert_thresholds.sql_disk_utilization_threshold
      comparison      = "COMPARISON_GT"
      duration        = var.alert_durations.sql_disk_utilization_alert_duration
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MAX"
      }
    }
  }
  documentation {
    content   = "Disk Utilization on Cloud SQL - ${var.environment} for ${var.app_name} is above ${var.alert_thresholds.sql_disk_utilization_threshold}. Consider viewing the service logs to retrieve more information."
    mime_type = "text/markdown"
  }
}
 
resource "google_monitoring_alert_policy" "disk_quota" {
count = var.alert_thresholds.sql_disk_quota_threshold > 0  ? 1 : 0
#count = (var.alert_thresholds.sql_disk_quota_threshold > 0 && var.database != "") ? 1 : 0
    display_name = "${var.app_name} - Cloud SQL - ${var.environment} - Disk Quota Alert(MAX)"
  project      = var.project_id
   combiner     = "AND"
  notification_channels = values(google_monitoring_notification_channel.notification_channel)[*].id
  conditions {
    display_name = "${var.app_name} - Cloud SQL - ${var.environment} - Disk Quota Alert(MAX)"
    condition_threshold {
      filter          = "metric.type=\"cloudsql.googleapis.com/database/disk/quota\" metadata.system_labels.name = \"${var.database}\" resource.type=\"cloudsql_database\" "
      threshold_value = var.alert_thresholds.sql_disk_quota_threshold
      comparison      = "COMPARISON_GT"
      duration        = var.alert_durations.sql_disk_quota_alert_duration
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MAX"
      }
    }
  }
  documentation {
    content   = "Disk Quota on Cloud SQL - ${var.environment} for ${var.app_name} is above ${var.alert_thresholds.sql_disk_quota_threshold}. Consider viewing the service logs to retrieve more information."
    mime_type = "text/markdown"
  }
}
 
resource "google_monitoring_alert_policy" "memory_quota" {
count = var.alert_thresholds.sql_memory_quota_threshold > 0  ? 1 : 0
#count = (var.alert_thresholds.sql_memory_quota_threshold > 0 && var.database != "") ? 1 : 0
    display_name = "${var.app_name} - Cloud SQL - ${var.environment} - Memory Quota Alert(MAX)"
  project      = var.project_id
   combiner     = "AND"
  notification_channels = values(google_monitoring_notification_channel.notification_channel)[*].id
  conditions {
    display_name = "${var.app_name} - Cloud SQL - ${var.environment} - Memory Quota Alert(MAX)"
    condition_threshold {
      filter          = "metric.type=\"cloudsql.googleapis.com/database/memory/quota\" metadata.system_labels.name = \"${var.database}\" resource.type=\"cloudsql_database\"  "
      threshold_value = var.alert_thresholds.sql_memory_quota_threshold
      comparison      = "COMPARISON_GT"
      duration        = var.alert_durations.sql_memory_quota_alert_duration
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MAX"
      }
    }
  }
  documentation {
    content   = "Memory Quota on Cloud SQL - ${var.environment} for ${var.app_name} is above ${var.alert_thresholds.sql_memory_quota_threshold}. Consider viewing the service logs to retrieve more information."
    mime_type = "text/markdown"
  }
}
 
/*resource "google_monitoring_alert_policy" "max_connections" {
count = (var.alert_thresholds.sql_max_connections_threshold > 0 && var.database != "") ? 1 : 0
enabled       = var.enable_Max_connections_metric
    display_name = "${var.app_name} - Cloud SQL - ${var.environment} - Max Connection Alert"
  project      = var.project_id
   combiner     = "AND"
  notification_channels = [     google_monitoring_notification_channel.notification_channel.name   ]
  conditions {
    display_name = "${var.app_name} - Cloud SQL - ${var.environment} - Max Connection Alert"
    condition_threshold {
      filter          = "metric.type=\"cloudsql.googleapis.com/database/mysql/max_connections\" metadata.system_labels.name = \"${var.database}\" resource.type=\"cloudsql_database\"  "
      threshold_value = var.alert_thresholds.sql_max_connections_threshold
      comparison      = "COMPARISON_GT"
      duration        = var.alert_durations.sql_max_connections_alert_duration
    }
  }
  documentation {
    content   = "Max Connection on Cloud SQL - ${var.environment} for ${var.app_name} is above ${var.alert_thresholds.sql_max_connections_threshold}. Consider viewing the service logs to retrieve more information."
    mime_type = "text/markdown"
  }
}
resource "google_monitoring_alert_policy" "postgres_connections" {
count = (var.alert_thresholds.sql_postgres_connections_threshold > 0 && var.database != "") ? 1 : 0
#count = (var.alert_thresholds.sql_postgres_connections_threshold > 0 && var.database != "") ? 1 : 0
    display_name = "${var.app_name} - Cloud SQL - ${var.environment} - postgres Connection Alert"
  project      = var.project_id
   combiner     = "AND"
notification_channels = values(google_monitoring_notification_channel.notification_channel)[*].id
  conditions {
    display_name = "${var.app_name} - Cloud SQL - ${var.environment} - Postgres Connection Alert"
    condition_threshold {
      filter          = "metric.type=\"cloudsql.googleapis.com/database/postgresql/num_backends\" metadata.system_labels.name = \"${var.database}\" resource.type=\"cloudsql_database\"  "
      threshold_value = var.alert_thresholds.sql_postgres_connections_threshold
      comparison      = "COMPARISON_GT"
      duration        = var.alert_durations.sql_postgres_connections_alert_duration
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MAX"
      }
    }
  }
  documentation {
    content   = "postgres connection on Cloud SQL - ${var.environment} for ${var.app_name} is above ${var.alert_thresholds.sql_postgres_connections_threshold}. Consider viewing the service logs to retrieve more information."
    mime_type = "text/markdown"
  }
}
 
resource "google_monitoring_alert_policy" "instance_state" {
count = var.alert_thresholds.sql_instance_state_threshold > 0  ? 1 : 0
#count = (var.alert_thresholds.sql_instance_state_threshold > 0 && var.database != "") ? 1 : 0
    display_name = "${var.app_name} - Cloud SQL - ${var.environment} - Instance State Alert"
  project      = var.project_id
   combiner     = "AND"
  notification_channels = values(google_monitoring_notification_channel.notification_channel)[*].id
  conditions {
    display_name = "${var.app_name} - Cloud SQL - ${var.environment} - Instance State Alert"
    condition_threshold {
      filter          = "metric.type=\"cloudsql.googleapis.com/database/instance_state\" metadata.system_labels.name = \"${var.database}\" resource.type=\"cloudsql_database\"  "
      threshold_value = var.alert_thresholds.sql_instance_state_threshold
      comparison      = "COMPARISON_LT"
      duration        = var.alert_durations.sql_instance_state_alert_duration
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_FRACTION_TRUE"
      }
    }
  }
  documentation {
    content   = "Instance State on Cloud SQL - ${var.environment} for ${var.app_name} is below ${var.alert_thresholds.sql_postgres_connections_threshold}. Consider viewing the service logs to retrieve more information."
    mime_type = "text/markdown"
  }
}
 
resource "google_monitoring_alert_policy" "replica_lag" {
count = var.alert_thresholds.sql_replica_lag_threshold > 0 ? 1 : 0
#count = (var.alert_thresholds.sql_replica_lag_threshold > 0 && var.database != "") ? 1 : 0
    display_name = "${var.app_name} - Cloud SQL - ${var.environment} - Replica_Lag Alert(mean)"
  project      = var.project_id
   combiner     = "AND"
  notification_channels = values(google_monitoring_notification_channel.notification_channel)[*].id
  conditions {
    display_name = "${var.app_name} - Cloud SQL - ${var.environment} - Replica_Lag Alert"
    condition_threshold {
      filter          = "metric.type=\"cloudsql.googleapis.com/database/replication/replica_lag\" metadata.system_labels.name = \"${var.database}\" resource.type=\"cloudsql_database\"  "
      threshold_value = var.alert_thresholds.sql_replica_lag_threshold
      comparison      = "COMPARISON_GT"
      duration        = var.alert_durations.sql_replica_lag_alert_duration
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }
  documentation {
    content   = "Replica Lag on Cloud SQL - ${var.environment} for ${var.app_name} is above ${var.alert_thresholds.sql_replica_lag_threshold}. Consider viewing the service logs to retrieve more information."
    mime_type = "text/markdown"
  }
}
# ********************************************************************************************
# Module Name: cloud_sql_uptime_alert
# Display Name: Cloud SQL Uptime Alert
# Description: This alert checks uptime count that cloud sql instance has been up and running.
# If the count is less than 1s in last 120s, it throws an alert to the notification channel
# ********************************************************************************************
 
/*resource "google_monitoring_alert_policy" "cloud_sql_uptime_alert" {
count = (var.alert_thresholds.sql_uptime_threshold  > 0 && var.database != "") ? 1 : 0
  display_name = "${var.app_name} - Cloud SQL - ${var.environment} - Uptime Alert(MAX)"
  project      = var.project_id
    combiner     = "AND"
notification_channels = values(google_monitoring_notification_channel.notification_channel)[*].id
  conditions {
    display_name = "${var.app_name} - Cloud SQL - ${var.environment} - Uptime  Alert(MAX)"
    condition_threshold {
      filter          = "metric.type=\"cloudsql.googleapis.com/database/uptime\" metadata.system_labels.name = \"${var.database}\" resource.type=\"cloudsql_database\"  "
      threshold_value = var.alert_thresholds.sql_uptime_threshold
      comparison      = "COMPARISON_LT"
      duration        = var.alert_durations.sql_uptime_alert_duration
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MAX"
      }
    }
  }
  documentation {
    content   = "Cloud SQL - ${var.environment} for ${var.app_name} is down. Consider viewing the service logs to retrieve more information."
    mime_type = "text/markdown"
  }
}
 */

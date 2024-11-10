## For Dashboard

resource "google_monitoring_dashboard" "dashboard" {
  count          = var.create_dashboard ? 1 : 0
  project        = var.project_id
  dashboard_json = <<EOF
{
  "displayName": "custom_sql",
  "dashboardFilters": [
    {
      "filterType": "RESOURCE_LABEL",
      "labelKey": "region",
      "templateVariable": "",
      "valueType": "STRING"
    },
    {
      "filterType": "RESOURCE_LABEL",
      "labelKey": "vivid-ocean-386206",
      "templateVariable": "",
      "valueType": "STRING"
    },
    {
      "filterType": "RESOURCE_LABEL",
      "labelKey": "database_id",
      "templateVariable": "",
      "valueType": "STRING"
    }
  ],
  "mosaicLayout": {
    "columns": 48,
    "tiles": [
      {
        "yPos": 24,
        "width": 31,
        "height": 13,
        "widget": {
          "title": "Instance States",
          "xyChart": {
            "chartOptions": {
              "mode": "COLOR"
            },
            "dataSets": [
              {
                "breakdowns": [],
                "dimensions": [],
                "measures": [],
                "minAlignmentPeriod": "60s",
                "plotType": "STACKED_AREA",
                "targetAxis": "Y1",
                "timeSeriesQuery": {
                  "timeSeriesFilter": {
                    "aggregation": {
                      "alignmentPeriod": "60s",
                      "perSeriesAligner": "ALIGN_COUNT_TRUE"
                    },
                    "filter": "metric.type=\"cloudsql.googleapis.com/database/instance_state\" resource.type=\"cloudsql_database\"",
                    "secondaryAggregation": {
                      "alignmentPeriod": "60s",
                      "crossSeriesReducer": "REDUCE_SUM",
                      "groupByFields": [
                        "metric.label.\"state\""
                      ],
                      "perSeriesAligner": "ALIGN_MEAN"
                    }
                  }
                }
              }
            ],
            "thresholds": [],
            "timeshiftDuration": "0s",
            "yAxis": {
              "label": "",
              "scale": "LINEAR"
            }
          }
        }
      },
      {
        "yPos": 45,
        "width": 16,
        "height": 16,
        "widget": {
          "title": "All - Cloud SQL Logs",
          "logsPanel": {
            "filter": "resource.type=\"cloudsql_database\"",
            "resourceNames": []
          }
        }
      },
      {
        "xPos": 32,
        "yPos": 8,
        "width": 16,
        "height": 16,
        "widget": {
          "title": "All - Cloud SQL Database Error Logs",
          "logsPanel": {
            "filter": "resource.type=\"cloudsql_database\"\nlogName=~\".*cloudsql.googleapis.com.*\"\nseverity>=ERROR",
            "resourceNames": []
          }
        }
      },
      {
        "yPos": 16,
        "width": 32,
        "height": 8,
        "widget": {
          "title": "Instance States",
          "text": {
            "content": "The below chart gives a count of how many Cloud SQL instances are in each state. ",
            "format": "RAW",
            "style": {
              "backgroundColor": "",
              "fontSize": "FONT_SIZE_UNSPECIFIED",
              "horizontalAlignment": "H_LEFT",
              "padding": "PADDING_SIZE_UNSPECIFIED",
              "pointerLocation": "POINTER_LOCATION_UNSPECIFIED",
              "textColor": "",
              "verticalAlignment": "V_TOP"
            }
          }
        }
      },
      {
        "yPos": 37,
        "width": 16,
        "height": 8,
        "widget": {
          "title": "All - Cloud SQL Logs",
          "text": {
            "content": "This logs widget shows all the logs relating to Cloud SQL database instances.",
            "format": "RAW",
            "style": {
              "backgroundColor": "",
              "fontSize": "FONT_SIZE_UNSPECIFIED",
              "horizontalAlignment": "H_LEFT",
              "padding": "PADDING_SIZE_UNSPECIFIED",
              "pointerLocation": "POINTER_LOCATION_UNSPECIFIED",
              "textColor": "",
              "verticalAlignment": "V_TOP"
            }
          }
        }
      },
      {
        "xPos": 32,
        "width": 16,
        "height": 8,
        "widget": {
          "title": "All - Cloud SQL Database Error Logs",
          "text": {
            "content": "This logs widget shows all the logs relating to Cloud SQL database instances at the error severity level.",
            "format": "RAW",
            "style": {
              "backgroundColor": "",
              "fontSize": "FONT_SIZE_UNSPECIFIED",
              "horizontalAlignment": "H_LEFT",
              "padding": "PADDING_SIZE_UNSPECIFIED",
              "pointerLocation": "POINTER_LOCATION_UNSPECIFIED",
              "textColor": "",
              "verticalAlignment": "V_TOP"
            }
          }
        }
      },
      {
        "xPos": 31,
        "yPos": 24,
        "width": 17,
        "height": 13,
        "widget": {
          "title": "Replication lag [MEAN]",
          "xyChart": {
            "chartOptions": {
              "mode": "COLOR"
            },
            "dataSets": [
              {
                "breakdowns": [],
                "dimensions": [],
                "measures": [],
                "minAlignmentPeriod": "60s",
                "plotType": "LINE",
                "targetAxis": "Y1",
                "timeSeriesQuery": {
                  "timeSeriesFilter": {
                    "aggregation": {
                      "alignmentPeriod": "60s",
                      "crossSeriesReducer": "REDUCE_MEAN",
                      "groupByFields": [],
                      "perSeriesAligner": "ALIGN_MEAN"
                    },
                    "filter": "metric.type=\"cloudsql.googleapis.com/database/replication/replica_lag\" resource.type=\"cloudsql_database\""
                  }
                }
              }
            ],
            "thresholds": [],
            "yAxis": {
              "label": "",
              "scale": "LINEAR"
            }
          }
        }
      },
      {
        "xPos": 16,
        "yPos": 37,
        "width": 21,
        "height": 17,
        "widget": {
          "title": "Postgres Connection [MAX]",
          "xyChart": {
            "chartOptions": {
              "mode": "COLOR"
            },
            "dataSets": [
              {
                "minAlignmentPeriod": "60s",
                "plotType": "LINE",
                "targetAxis": "Y1",
                "timeSeriesQuery": {
                  "timeSeriesFilter": {
                    "aggregation": {
                      "alignmentPeriod": "60s",
                      "crossSeriesReducer": "REDUCE_MAX",
                      "groupByFields": [],
                      "perSeriesAligner": "ALIGN_MAX"
                    },
                    "filter": "metric.type=\"cloudsql.googleapis.com/database/postgresql/num_backends\" resource.type=\"cloudsql_database\""
                  }
                }
              }
            ],
            "thresholds": [],
            "yAxis": {
              "label": "",
              "scale": "LINEAR"
            }
          }
        }
      },
      {
        "xPos": 10,
        "width": 10,
        "height": 8,
        "widget": {
          "title": "Memory  utilization [MEAN]",
          "scorecard": {
            "dimensions": [],
            "gaugeView": {
              "lowerBound": 0,
              "upperBound": 1
            },
            "measures": [],
            "thresholds": [],
            "timeSeriesQuery": {
              "timeSeriesFilter": {
                "aggregation": {
                  "alignmentPeriod": "60s",
                  "crossSeriesReducer": "REDUCE_MEAN",
                  "groupByFields": [],
                  "perSeriesAligner": "ALIGN_MEAN"
                },
                "filter": "metric.type=\"cloudsql.googleapis.com/database/memory/utilization\" resource.type=\"cloudsql_database\""
              }
            }
          }
        }
      },
      {
        "yPos": 8,
        "width": 16,
        "height": 8,
        "widget": {
          "title": "Disk quota [MAX]",
          "scorecard": {
            "dimensions": [],
            "measures": [],
            "sparkChartView": {
              "sparkChartType": "SPARK_LINE"
            },
            "thresholds": [],
            "timeSeriesQuery": {
              "outputFullDuration": true,
              "timeSeriesFilter": {
                "aggregation": {
                  "alignmentPeriod": "60s",
                  "crossSeriesReducer": "REDUCE_MAX",
                  "groupByFields": [],
                  "perSeriesAligner": "ALIGN_MAX"
                },
                "filter": "metric.type=\"cloudsql.googleapis.com/database/disk/quota\" resource.type=\"cloudsql_database\""
              }
            }
          }
        }
      },
      {
        "width": 10,
        "height": 8,
        "widget": {
          "title": "CPU utilization [MEAN]",
          "scorecard": {
            "dimensions": [],
            "gaugeView": {
              "lowerBound": 0,
              "upperBound": 1
            },
            "measures": [],
            "thresholds": [],
            "timeSeriesQuery": {
              "outputFullDuration": true,
              "timeSeriesFilter": {
                "aggregation": {
                  "alignmentPeriod": "60s",
                  "crossSeriesReducer": "REDUCE_MEAN",
                  "groupByFields": [],
                  "perSeriesAligner": "ALIGN_MEAN"
                },
                "filter": "metric.type=\"cloudsql.googleapis.com/database/cpu/utilization\" resource.type=\"cloudsql_database\""
              }
            }
          }
        }
      },
      {
        "xPos": 20,
        "width": 10,
        "height": 8,
        "widget": {
          "title": "Disk  utilization [MEAN]",
          "scorecard": {
            "dimensions": [],
            "gaugeView": {
              "lowerBound": 0,
              "upperBound": 1
            },
            "measures": [],
            "thresholds": [],
            "timeSeriesQuery": {
              "timeSeriesFilter": {
                "aggregation": {
                  "alignmentPeriod": "60s",
                  "crossSeriesReducer": "REDUCE_MEAN",
                  "groupByFields": [],
                  "perSeriesAligner": "ALIGN_MEAN"
                },
                "filter": "metric.type=\"cloudsql.googleapis.com/database/disk/utilization\" resource.type=\"cloudsql_database\""
              }
            }
          }
        }
      },
      {
  "height": 16,
  "widget": {
    "title": "Cloud SQL Database Memory usage [SUM]",
    "xyChart": {
      "chartOptions": {
        "mode": "COLOR"
      },
      "dataSets": [
        {
          "minAlignmentPeriod": "60s",
          "plotType": "LINE",
          "targetAxis": "Y1",
          "timeSeriesQuery": {
            "timeSeriesFilter": 
 {
              "aggregation": {
                "alignmentPeriod": "60s",
                "crossSeriesReducer": "REDUCE_SUM", 

                "perSeriesAligner": "ALIGN_MEAN"
              },
              "filter": "metric.type=\"cloudsql.googleapis.com/database/memory/usage\" resource.type=\"cloudsql_database\"" 

            }
          }
        }
      ],
      "yAxis": {
        "scale": "LINEAR"
      }
    }
  },
  "width": 24,
  "xPos": 16,
  "yPos": 54
},
      {
        "xPos": 16,
        "yPos": 8,
        "width": 16,
        "height": 8,
        "widget": {
          "title": "Memory quota [MAX]",
          "scorecard": {
            "dimensions": [],
            "measures": [],
            "sparkChartView": {
              "sparkChartType": "SPARK_LINE"
            },
            "thresholds": [],
            "timeSeriesQuery": {
              "outputFullDuration": true,
              "timeSeriesFilter": {
                "aggregation": {
                  "alignmentPeriod": "60s",
                  "crossSeriesReducer": "REDUCE_MAX",
                  "groupByFields": [],
                  "perSeriesAligner": "ALIGN_MAX"
                },
                "filter": "metric.type=\"cloudsql.googleapis.com/database/memory/quota\" resource.type=\"cloudsql_database\" resource.label.\"database_id\"=\"my-project-kd46275:cloudmysql\""
              }
            }
          }
        }
      }
    ]
  },
  "labels": {}
}
 
EOF
}

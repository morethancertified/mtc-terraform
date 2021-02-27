locals {
  deployment = {
    nodered = {
      image      = "nodered/node-red:latest"
      int        = 1880
      ext        = 8000
      volumepath = "/data"
    }
    influxdb = {
      image      = "influxdb"
      int        = 8086
      ext        = 8086
      volumepath = "/var/lib/influxdb"
    }
    grafana = {
      image      = "grafana/grafana"
      int        = 3000
      ext        = 3000
      volumepath = "var/lib/grafana"
    }
  }
}
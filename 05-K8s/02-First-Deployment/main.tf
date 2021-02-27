resource "kubernetes_deployment" "iotdep" {
  metadata {
    name = "iotdep"
    labels = {
      app = "iotapp"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "iotapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "iotapp"
        }
      }

      spec {
        container {
          image = "nodered/node-red:latest"
          name  = "nodered-container"
          volume_mount {
            name       = "nodered-vol"
            mount_path = "/data"
          }
          port {
            container_port = 1880
            host_port      = 8000
          }
        }
        volume {
          name = "nodered-vol"
          empty_dir {
            medium = ""
          }
        }
      }
    }
  }
}
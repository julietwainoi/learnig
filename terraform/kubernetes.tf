resource "kubernetes_deployment" "user_app" {
  metadata {
    name = "user-app"
    labels = {
      app = "user-app"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "user-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "user-app"
        }
      }

      spec {
        container {
          name  = "user-app"
          image = "user-app:local" # local Docker image
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "user_app_service" {
  metadata {
    name = "user-app-service"
  }

  spec {
    selector = {
      app = "user-app"
    }

    port {
      port        = 80
      target_port = 80
      node_port   = 30080
    }

    type = "NodePort"
  }
}
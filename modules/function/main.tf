
resource "helm_release" "openfunction" {
  name       = "openfunction"
  namespace  = "openfunction"
  repository = "https://openfunction.github.io/charts/"
  chart      = "openfunction"
  version    = "1.4.0" # you can check latest version

  create_namespace = true

  # Example values override
  set {
    name  = "global.prometheus.enabled"
    value = "true"
  }

  set {
    name  = "global.grafana.enabled"
    value = "true"
  }

  # If you want to enable Knative
  set {
    name  = "global.knative.enabled"
    value = "true"
  }
}


# OpenFunction HTTP Function
resource "kubernetes_manifest" "http_function" {
  depends_on = [helm_release.openfunction]

  manifest = {
    apiVersion = "core.openfunction.io/v1beta1"
    kind       = "Function"
    metadata = {
      name      = "minio-http-processor"
      namespace = "openfunction"
    }
    spec = {
      runtime    = "python"
      sourceType = "inline"
      inline = {
        code = <<EOF
import json

def main(context, event):
    print("Received event:", event.body)
    return {"status": "processed"}
EOF
      }
      trigger = {
        type = "http"
        http = {
          port = 8080
        }
      }
    }
  }
}


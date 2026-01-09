
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
  manifest = {
    apiVersion = "core.openfunction.io/v1beta1"
    kind       = "Function"
    metadata = {
      name      = "minio-http-processor"
      namespace = "openfunction-system"
    }
    spec = {
      runtime    = "python"
      sourceType = "inline"
      inline = {
        code = <<EOF
import json

def main(context, event):
    print("Received event:", event.body)
    # process the file
    return {"status": "processed", "file": event.body.get("Records", [{}])[0].get("s3", {}).get("object", {}).get("key", "")}
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

# Kubernetes Secret for MinIO credentials (used by Argo Events)
resource "kubernetes_secret" "minio_credentials" {
  metadata = {
    name      = "minio-credentials"
    namespace = kubernetes_namespace.argo_events.metadata[0].name
  }

  string_data = {
    accesskey = "minioadmin"
    secretkey = "minioadmin"
  }

  type = "Opaque"
}

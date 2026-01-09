
resource "kubernetes_manifest" "http_demo_function" {
  manifest = {
    apiVersion = "core.openfunction.io/v1beta1"
    kind       = "Function"
    metadata = {
      name      = "http-demo"
      namespace = "openfunction-system"
    }
    spec = {
      runtime     = "python"
      sourceType  = "inline"
      inline = {
        code = <<EOF
import json

def main(context, event):
    name = event.body.get("name", "world")
    return {"message": f"Hello, {name}!"}
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

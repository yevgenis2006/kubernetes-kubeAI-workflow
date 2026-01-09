
resource "helm_release" "openfunction" {
  name       = "openfunction"
  namespace  = "openfunction"
  repository = "https://openfunction.github.io/charts/"
  chart      = "openfunction/openfunction"
  version    = "0.7.0" # you can check latest version

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
    value = "false"
  }
}

# Wait for Function CRD to exist
resource "null_resource" "wait_function_crd" {
  depends_on = [helm_release.openfunction]

  provisioner "local-exec" {
    command = <<EOT
echo "Waiting for OpenFunction Function CRD..."
until kubectl get crd functions.core.openfunction.io > /dev/null 2>&1; do
  sleep 5
done
echo "CRD exists!"
EOT
  }
}

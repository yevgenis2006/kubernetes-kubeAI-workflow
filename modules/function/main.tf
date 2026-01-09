
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

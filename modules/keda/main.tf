
resource "helm_release" "keda" {
  name = "keda"

  repository = "https://kedacore.github.io/charts"
  chart      = "keda"
  namespace  = "keda"

  create_namespace = true

  version = "2.14.0" # optional but recommended

  values = [
    yamlencode({
      operator = {
        replicaCount = 1
      }
      metricsServer = {
        replicaCount = 1
      }
      webhooks = {
        replicaCount = 1
      }
    })
  ]
}

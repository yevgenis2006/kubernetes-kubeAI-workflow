
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


resource "kubernetes_manifest" "scaledobject_cpu" {
  manifest = {
    apiVersion = "keda.sh/v1alpha1"
    kind       = "ScaledObject"
    metadata = {
      name      = "cpu-scaledobject"
      namespace = "default"
    }
    spec = {
      scaleTargetRef = {
        name = "my-app"
      }

      minReplicaCount = 1
      maxReplicaCount = 10

      triggers = [
        {
          type = "cpu"
          metadata = {
            type  = "Utilization"
            value = "70"
          }
        }
      ]
    }
  }
}

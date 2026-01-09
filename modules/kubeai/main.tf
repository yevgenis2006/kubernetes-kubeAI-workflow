
resource "helm_release" "kubeai" {
  name       = "kubeai"
  repository = "https://www.kubeai.org"
  chart      = "kubeai"
  namespace  = "kubeai-system"

  create_namespace = true

  # optional: add custom settings here
  values = [
  yamlencode({
    proxy = {
      service = {
        type = "ClusterIP"
      }
    }
    ui = {
      service = {
        type = "ClusterIP"
      }
    }
  })
]
}

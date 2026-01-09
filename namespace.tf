
resource "kubernetes_namespace" "kubeai_system" {
metadata {
name = "kubeai-system"
labels = {
"app.kubernetes.io/managed-by" = "terraform"
  }
 }
}

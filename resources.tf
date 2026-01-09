
###  ---  Default Template  ---  ###
module "minio" {
  source = "./modules/minio"
  depends_on = [kubernetes_namespace.kubeai-system]
}

module "events" {
  source = "./modules/events"
  depends_on = [module.minio]
}

module "function" {
  source = "./modules/function"
  depends_on = [module.events]
}

module "keda" {
  source = "./modules/keda"
  depends_on = [module.function"]
}

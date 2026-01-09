![image](https://github.com/user-attachments/assets/45145f35-04f8-4c16-9db8-84964131c4d5)


## KubeAI | Kubernetes ☸️
KubeAI, an open-source project designed to deliver the building blocks that enable companies to integrate AI within their private environments. KubeAI is intended to serve as a drop-in alternative to proprietary platforms. With KubeAI you can regain control over your data while taking advantage of the rapidly accelerating pace of innovation in open source models and tools.


👌  Key Features 
```
✔ OpenAI-compatible API — Offers endpoints like /v1/chat/completions, /v1/embeddings, and /v1/audio/transcriptions, so many existing tools that speak the OpenAI API can work with KubeAI.
✔ Scale-from-zero and autoscaling — Automatically scales model replicas based on load, including spinning up from zero when requests arrive.
✔ Optimized routing & caching — Built-in proxy and load-balancing strategies improve performance for stateful models (e.g., cache-aware routing).
✔ Model management — Automates downloading, mounting, and lifecycle tasks for model pods through Kubernetes custom resources.
✔ Hardware flexibility — Works on both CPU and GPU nodes, and doesn’t depend on heavy service meshes or external systems like Istio/Knative

```


🚀 Deployment Workflow
```
terraform init
terraform validate
terraform plan -var-file="template.tfvars"
terraform apply -var-file="template.tfvars" -auto-approve
```

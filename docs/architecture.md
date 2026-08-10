### ArgoCD bootstrap boundary

I decided to configure argocd via terraform seperate to my main platform. The issue with this is that I will need to deploy the entire platform across two applies. Keeping the ArgoCD and terraform workload seperate means one doesn't depend on the other if a workflow breaks. Anything in the cluster that is not ArgoCD is defined in `gitops/`.

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.argocd_chart_version
  namespace        = "argocd"
  create_namespace = true

  wait    = true
  timeout = 600

  values = [yamlencode({
    global = {
      domain = "argocd.${var.cluster_name}.local"
    }

    configs = {
      params = {
        # Ingress and TLS come later; run the server insecure behind
        # port-forward until ticket 21 decides how to expose it.
        "server.insecure" = true
      }
    }

    # Single-node cluster: trim the default footprint.
    controller = {
      resources = {
        requests = { cpu = "100m", memory = "256Mi" }
        limits   = { memory = "512Mi" }
      }
    }

    repoServer = {
      resources = {
        requests = { cpu = "50m", memory = "128Mi" }
        limits   = { memory = "256Mi" }
      }
    }

    server = {
      resources = {
        requests = { cpu = "50m", memory = "128Mi" }
        limits   = { memory = "256Mi" }
      }
    }

    applicationSet = {
      resources = {
        requests = { cpu = "25m", memory = "64Mi" }
        limits   = { memory = "128Mi" }
      }
    }

    dex = {
      enabled = false
    }

    notifications = {
      enabled = false
    }

    redis = {
      resources = {
        requests = { cpu = "25m", memory = "64Mi" }
        limits   = { memory = "128Mi" }
      }
    }
  })]
}

# App-of-apps root. The only Application Terraform owns.
resource "kubernetes_manifest" "root_app" {
  depends_on = [helm_release.argocd]

  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      name       = "root"
      namespace  = "argocd"
      finalizers = ["resources-finalizer.argocd.argoproj.io"]
    }

    spec = {
      project = "default"

      source = {
        repoURL        = var.gitops_repo_url
        targetRevision = var.gitops_revision
        path           = var.gitops_path
        directory = {
          recurse = true
        }
      }

      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "argocd"
      }

      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
        syncOptions = ["CreateNamespace=true"]
      }
    }
  }
}

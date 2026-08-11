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
    configs = {
      params = {
        # TLS terminates at ingress-nginx; running the server without its own
        # TLS avoids a redirect loop.
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

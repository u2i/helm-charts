# Helm charts prepared by u2i LLC

This repository contains and builds Helm charts that support our apps.

## RetroTool

This chart allows you to install RetroTool into a Kubernetes cluster. It supports certificates (through Cert-Manager), backups (through Velero) 
and automatically installs MongoDB replicaset (configurable).

Install with:
1. `helm repo add u2i https://u2i.github.io/helm-charts`
2. `helm install u2i/retrotool`

### Supported version

* 1.0.0 - released on 2021-01-15


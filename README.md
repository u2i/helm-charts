# Helm charts prepared by u2i LLC

This repository contains and builds Helm charts that support our apps.

### How to deploy new charts

1. You need to build new chart version (using RetroTool as example):
   ```
   helm package retrotool
   ```
2. Update repository index file:
   ```
   helm repo index . --url https://u2i.github.io/helm-charts --merge index.yaml
   ```
3. Commit and push created `.tgz` file and updated `index.yaml` - the repository is updated now.

## RetroTool

This chart allows you to install RetroTool into a Kubernetes cluster. It supports certificates (through Cert-Manager), backups (through Velero) 
and automatically installs MongoDB replicaset (configurable).

Install with:
1. `helm repo add u2i https://u2i.github.io/helm-charts`
2. `helm install u2i/retrotool`

### Supported versions

* 1.4.1 - released on 2021-08-13
* 1.4.0 - released on 2021-08-04
* 1.3.2 - released on 2021-07-25
* 1.2.8 - released on 2021-07-10
* 1.2.5 - released on 2021-06-28
* 1.2.4 - released on 2021-06-23
* 1.2.3 - released on 2021-06-23
* 1.2.1 - released on 2021-04-20
* 1.1.0 - released on 2021-04-14
* 1.0.0 - released on 2021-01-15

## MongoDB Kubernetes Operator

This chart allows you to install MongoDB Community Kubernetes Operator into a Kubernetes cluster. 

It is a copy of official chart, just packaged and published for ease of use.

Install with:
1. `helm repo add u2i https://u2i.github.io/helm-charts`
2. `helm install u2i/mongodb-kubernetes-operator`

### Supported versions

* 0.7.0 - released on 2021-08-04


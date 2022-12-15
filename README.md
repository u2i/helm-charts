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

* 1.6.11 - released on 2022-12-15
  * Add ability to specify landing page health endpoint
* 1.6.10 - released on 2022-12-08
  * Set ulimits to recommended values for MongoDB operator databases
* 1.6.9 - released on 2022-12-07
  * Add support for disabling Transparent Hugepages for better MongoDB performance in operator mode
* 1.6.5 - released on 2022-12-07
  * Update Redis dependency with default settings for persistence storage class
* 1.6.4 - released on 2022-11-24
  * Update HPA to autoscaling/v2 (requires Kubernetes v1.23)
* 1.6.3 - released on 2022-11-24
  * Add support for separate landing page app
* 1.5.2 - released on 2022-07-12
  * Fix namespacing of new RBAC for MongoDBCommunity operator
* 1.5.1 - released on 2022-07-12
  * Update MongoDBCommunity resource to properly configure a replicaset and connect to it
* 1.5.0 - released on 2022-06-28
  * Upgrade Redis chart to 16.13.0 (**contains changes to values file**)
* 1.4.6 - released on 2022-06-28
  * Allow eviction of MongoDB pods created by Kubernetes operator
* 1.4.5 - released on 2022-02-08
* 1.4.4 - released on 2021-12-13
* 1.4.3 - released on 2021-12-10
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

## Next.js

This chart allows you to deploy a Next.js app into a Kubernetes cluster. It supports certificates (through Cert-Manager) and CDN with Google Kubernetes Engine (GKE) deployment.

Install with:
1. `helm repo add u2i https://u2i.github.io/helm-charts`
2. `helm install u2i/nextjs`

### Supported versions

* 1.0.0 - released on 2021-11-30

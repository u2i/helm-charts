# vim: set filetype=mustache:

# Create MongoDB url for replicaset chart
{{- define "mongodb.replicaset_url" -}}
  {{- $database := index .Values "mongodb-replicaset" "database" -}}
  {{- $replicaSetName := index .Values "mongodb-replicaset" "replicaSetName" -}}
  {{- $readPreference := default "" (index .Values "mongodb-replicaset" "readPreference") -}}
  {{- $maxStalenessSeconds := default "" ((index .Values "mongodb-replicaset" "maxStalenessSeconds")|int) -}}
  {{- $port := (index .Values "mongodb-replicaset" "port")|int -}}
  {{- $replicas := (index .Values "mongodb-replicaset" "replicas")|int -}}
  {{- printf "mongodb://%s-mongodb-replicaset-client:%d/%s" $.Release.Name $port $database -}}
  {{- if gt $replicas 1 -}}
    {{- printf "?replicaSet=%s" $replicaSetName -}}
    {{- if and $readPreference -}}
      {{- printf "&readPreference=%s" $readPreference  -}}
      {{- if and $maxStalenessSeconds (ne $readPreference "primary") -}}
        {{- printf "&maxStalenessSeconds=%d" ($maxStalenessSeconds|int)  -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

# Create MongoDB Oplog url for replicaset
{{- define "mongodb.replicaset_oplog_url" -}}
  {{- $replicaSetName := index .Values "mongodb-replicaset" "replicaSetName" -}}
  {{- $port := (index .Values "mongodb-replicaset" "port")|int -}}
  {{- $replicas := (index .Values "mongodb-replicaset" "replicas")|int -}}
  {{- printf "mongodb://%s-mongodb-replicaset-client:%d/local?authSource=admin" $.Release.Name $port -}}
  {{- if gt $replicas 1 -}}
    {{- printf "&replicaSet=%s" $replicaSetName -}}
  {{- end -}}
{{- end -}}

# Create custom MongoDB url
{{- define "mongodb.custom_url" -}}
  {{- printf "mongodb://%s:%d/%s" .Values.database.custom.host (.Values.database.custom.port|int) .Values.database.custom.database -}}
  {{- if and .Values.database.custom.replicaset -}}
    {{- printf "?replicaSet=%s" .Values.database.custom.replicaset -}}
  {{- end -}}
  {{- if and .Values.database.custom.readPreference -}}
    {{- printf "&readPreference=%s" .Values.database.custom.readPreference  -}}
    {{- if and .Values.database.custom.maxStalenessSeconds (ne .Values.database.custom.readPreference "primary") -}}
      {{- printf "&maxStalenessSeconds=%d" (.Values.database.custom.maxStalenessSeconds|int)  -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

# Create custom MongoDB Oplog url
{{- define "mongodb.custom_oplog_url" -}}
  {{- printf "mongodb://%s:%d/local?authSource=admin" .Values.database.custom.host (.Values.database.custom.port|int) -}}
  {{- if and .Values.database.custom.replicaset -}}
    {{- printf "&replicaSet=%s" .Values.database.custom.replicaset -}}
  {{- end -}}
{{- end -}}

# Create MongoDB url for MongoDB Kubernetes Operator
{{- define "mongodb.operator_url" -}}
  {{- $replicaSetName := .Values.database.operator.replicaSetName -}}
  {{- $readPreference := default "" .Values.database.operator.readPreference -}}
  {{- $maxStalenessSeconds := default "" (.Values.database.operator.maxStalenessSeconds|int) -}}
  {{- $replicas := .Values.database.operator.replicas|int -}}
  {{- printf "mongodb://retrotool:%s@mongodb-svc/retrotool?authSource=admin" .password -}}
  {{- if gt $replicas 1 -}}
    {{- printf "&replicaSet=%s" $replicaSetName -}}
    {{- if and $readPreference -}}
      {{- printf "&readPreference=%s" $readPreference  -}}
      {{- if and $maxStalenessSeconds (ne $readPreference "primary") -}}
        {{- printf "&maxStalenessSeconds=%d" ($maxStalenessSeconds|int)  -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

# Create MongoDB Oplog url for MongoDB Kubernetes Operator
{{- define "mongodb.operator_oplog_url" -}}
  {{- $replicaSetName := .Values.database.operator.replicaSetName -}}
  {{- $readPreference := default "" .Values.database.operator.readPreference -}}
  {{- $maxStalenessSeconds := default "" (.Values.database.operator.maxStalenessSeconds|int) -}}
  {{- $replicas := .Values.database.operator.replicas|int -}}
  {{- printf "mongodb://retrotool:%s@mongodb-svc/local?authSource=admin" .password -}}
  {{- if gt $replicas 1 -}}
    {{- printf "&replicaSet=%s" $replicaSetName -}}
    {{- if and $readPreference -}}
      {{- printf "&readPreference=%s" $readPreference  -}}
      {{- if and $maxStalenessSeconds (ne $readPreference "primary") -}}
        {{- printf "&maxStalenessSeconds=%d" ($maxStalenessSeconds|int)  -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

# Create MongoDB url
{{- define "mongodb.url" -}}
  {{- if eq .Values.database.type "custom" -}}
    {{- include "mongodb.custom_url" . }}
  {{- else if eq .Values.database.type "operator" -}}
    {{- include "mongodb.operator_url" . }}
  {{- else if eq .Values.database.type "replicaset" -}}
    {{- include "mongodb.replicaset_url" . }}
  {{- end -}}
{{- end -}}

# Create MongoDB Oplog url
{{- define "mongodb.oplog_url" -}}
  {{- if eq .Values.database.type "custom" -}}
    {{- include "mongodb.custom_oplog_url" . }}
  {{- else if eq .Values.database.type "operator" -}}
    {{- include "mongodb.operator_oplog_url" . }}
  {{- else if eq .Values.database.type "replicaset" -}}
    {{- include "mongodb.replicaset_oplog_url" . }}
  {{- end -}}
{{- end -}}


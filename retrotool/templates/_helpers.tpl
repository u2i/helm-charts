{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "retrotool-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "retrotool-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create full MongoDB url with correct replicaset
*/}}
{{- define "mongodb.replicaset_url" -}}
  {{- if and .Values.overrideDatabase.host -}}
    {{- printf "mongodb://%s:%d/%s" .Values.overrideDatabase.host (.Values.overrideDatabase.port|int) .Values.overrideDatabase.database -}}
    {{- if and .Values.overrideDatabase.replicaset -}}
      {{- printf "?replicaSet=%s" .Values.overrideDatabase.replicaset -}}
    {{- end -}}
    {{- if and .Values.overrideDatabase.readPreference -}}
      {{- printf "&readPreference=%s" .Values.overrideDatabase.readPreference  -}}
      {{- if and .Values.overrideDatabase.maxStalenessSeconds (ne .Values.overrideDatabase.readPreference "primary") -}}
        {{- printf "&maxStalenessSeconds=%d" (.Values.overrideDatabase.maxStalenessSeconds|int)  -}}
      {{- end -}}
    {{- end -}}
  {{- else -}}
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
{{- end -}}

{{/*
Create full MongoDB url with correct replicaset for oplog
*/}}
{{- define "mongodb.replicaset_oplog_url" -}}
  {{- if and .Values.overrideDatabase.host -}}
    {{- printf "mongodb://%s:%d/local?authSource=admin" .Values.overrideDatabase.host (.Values.overrideDatabase.port|int) -}}
    {{- if and .Values.overrideDatabase.replicaset -}}
      {{- printf "&replicaSet=%s" .Values.overrideDatabase.replicaset -}}
    {{- end -}}
  {{- else -}}
    {{- $replicaSetName := index .Values "mongodb-replicaset" "replicaSetName" -}}
    {{- $port := (index .Values "mongodb-replicaset" "port")|int -}}
    {{- $replicas := (index .Values "mongodb-replicaset" "replicas")|int -}}
    {{- printf "mongodb://%s-mongodb-replicaset-client:%d/local?authSource=admin" $.Release.Name $port -}}
    {{- if gt $replicas 1 -}}
      {{- printf "&replicaSet=%s" $replicaSetName -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

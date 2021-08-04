# vim: set filetype=mustache:

# Create Redis settings for performance oplog
{{- define "redis.settings" -}}
  {{- $settings := dict "redis" (dict) -}}
  {{- $overrides := default (dict) .Values.app.redisOplog -}}
  {{- if .Values.redis.sentinel.enabled -}}
    {{- $sentinel := dict "host" (printf "%s-redis" $.Release.Name) "port" .Values.redis.sentinel.port -}}
    {{- $_ := set $settings.redis "sentinels" (list $sentinel) -}}
    {{- $_ := set $settings.redis "name" .Values.redis.sentinel.masterSet -}}
  {{- else -}}
    {{- $_ := set $settings.redis "host" (printf "%s-redis-master" $.Release.Name) -}}
  {{- end -}}
  {{- printf (toJson (mustMerge $settings $overrides)) -}}
{{- end -}}

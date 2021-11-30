# vim: set filetype=mustache:
# Expand the name of the chart.
{{- define "app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

# Create app name with version as used by the app name label.
{{- define "chart.name" -}}
{{- printf "%s-%s-%s" .Release.Name .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

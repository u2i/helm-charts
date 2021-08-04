# vim: set filetype=mustache:
# Expand the name of the chart.
{{- define "retrotool-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

# Create chart name and version as used by the chart label.
{{- define "retrotool-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

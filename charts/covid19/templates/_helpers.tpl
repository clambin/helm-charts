{{/*
Expand the name of the chart.
*/}}
{{- define "covid19.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "covid19.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "covid19.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "covid19.labels" -}}
helm.sh/chart: {{ include "covid19.chart" . }}
{{ include "covid19.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "covid19.selectorLabels" -}}
app.kubernetes.io/name: {{ include "covid19.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Get configMap name
*/}}
{{- define "covid19.getConfigMap" -}}
{{- if .Values.configMap }}
{{- .Values.configMap | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-covid19-config" .Release.Name | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end}}
{{- end}}

{{/*
Get secret name
*/}}
{{- define "covid19.getSecret" -}}
{{- if .Values.secret }}
{{- .Values.secret | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-covid19-secret" .Release.Name | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end}}
{{- end}}


{{/*
Expand the name of the chart.
*/}}
{{- define "proteus.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "proteus.fullname" -}}
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
{{- define "proteus.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "proteus.labels" -}}
helm.sh/chart: {{ include "proteus.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Prometheus listener port
*/}}
{{- define "ports.prometheus"}}
{{- int (last (splitList ":" (default .Values.config.prometheus.addr ":9090"))) }}
{{- end }}

{{/*
Healthz listener port
*/}}
{{- define "ports.healthz"}}
{{- int (last (splitList ":" (default .Values.config.health.addr ":8888"))) }}
{{- end }}

{{/*
Solar Web listener port
*/}}
{{- define "ports.solar.web"}}
{{- int (last (splitList ":" (default .Values.config.apps.solar.web.addr ":8080"))) }}
{{- end }}

{{/*
Environment variable definitions for credentials stored in secret(s)
*/}}
{{- define "proteus.credentialsEnv" }}
{{- range $envName, $ref := .Values.secretRefs.keys }}
- name: {{ $envName }}
  valueFrom:
    secretKeyRef:
      name: {{ default $.Values.secretRefs.secret (index $ref "secret") }}
      key: {{ $ref.key }}
{{- end }}
{{- end }}

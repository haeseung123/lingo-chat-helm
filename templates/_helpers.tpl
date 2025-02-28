{{/*
Expand the name of the chart.
*/}}
{{- define "lingochat.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lingochat.fullname" -}}
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
Prefix (e.g., lingo-)
*/}}
{{- define "lingochat.prefix" -}}
{{- printf "%s-" .Release.Name -}}
{{- end }}

{{/*
Full name for Nginx (e.g., lingo-nginx)
*/}}
{{- define "lingochat.nginxFullname" -}}
{{- printf "%s%s" (include "lingochat.prefix" .) .Values.nginx.component | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Full name for Socket (e.g., lingo-socket)
*/}}
{{- define "lingochat.socketFullname" -}}
{{- printf "%s%s" (include "lingochat.prefix" .) .Values.socket.component | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Full name for API (e.g., lingo-api)
*/}}
{{- define "lingochat.apiFullname" -}}
{{- printf "%s%s" (include "lingochat.prefix" .) .Values.api.component | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "lingochat.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "lingochat.labels" -}}
helm.sh/chart: {{ include "lingochat.chart" . }}
{{ include "lingochat.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "lingochat.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lingochat.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "lingochat.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "lingochat.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

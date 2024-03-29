{{/*
Expand the name of the chart.
*/}}
{{- define "zuul.name" -}}
{{- default .Chart.Name .Values.mariadb.mariab.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "zuul.fullname" -}}
{{- if .Values.mariadb.mariab.fullnameOverride }}
{{- .Values.mariadb.mariab.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.mariadb.mariab.nameOverride }}
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
{{- define "zuul.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "zuul.labels" -}}
helm.sh/chart: {{ include "zuul.chart" . }}
{{ include "zuul.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "zuul.selectorLabels" -}}
app.kubernetes.io/name: {{ include "zuul.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "zuul.serviceAccountName" -}}
{{- if .Values.mariadb.mariab.serviceAccount.create }}
{{- default (include "zuul.fullname" .) .Values.mariadb.mariab.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.mariadb.mariab.serviceAccount.name }}
{{- end }}
{{- end }}

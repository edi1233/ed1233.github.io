{{/*
Expand the name of the chart.
*/}}
{{- define "technitium.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a fully qualified app name.
If the release name contains the chart name it will be used as-is.
Otherwise, it adds the release name as a prefix.
Example:  release name = "dns" → dns-technitium
*/}}
{{- define "technitium.fullname" -}}
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
{{- end -}}

{{/*
Common labels for all Technitium objects.
*/}}
{{- define "technitium.labels" -}}
app.kubernetes.io/name: {{ include "technitium.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end -}}

{{/*
Selector labels for StatefulSet/Service matching.
*/}}
{{- define "technitium.selectorLabels" -}}
app: {{ include "technitium.name" . }}
{{- end -}}

{{/*
Annotations block (optional helper for reuse)
*/}}
{{- define "technitium.annotations" -}}
{{- with .Values.podAnnotations }}
{{- toYaml . | nindent 4 }}
{{- end }}
{{- end -}}

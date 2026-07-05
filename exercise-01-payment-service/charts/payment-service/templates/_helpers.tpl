{{- define "payment-service.name" -}}
{{- .Chart.Name -}}
{{- end -}}

{{- define "payment-service.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "payment-service.labels" -}}
app.kubernetes.io/name: {{ include "payment-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: Helm
{{- end -}}

{{/*
Check to see if the secret has already been created and if it has if it has the MASTER_KEY value provided.
If the MASTER_KEY value exists, then it will return the existing value otherwise it will generate a new one.
*/}}
{{- define "octopus-deploy.masterKeySecret" -}}
  {{- $secretObj := (lookup "v1" "Secret" .Release.Namespace (printf "%s-config" .Release.Name)) | default dict }}
  {{- $secretData := (get $secretObj "data") | default dict }}
  {{- if (hasKey $secretData "MASTER_KEY") -}}
    {{- index $secretData "MASTER_KEY" | b64dec -}}
  {{- else -}}
    {{- randAlphaNum 16 | b64enc -}}
  {{- end -}}
{{- end }}
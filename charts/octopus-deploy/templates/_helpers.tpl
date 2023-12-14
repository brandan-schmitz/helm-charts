{{/*
Generate a random 128-bit string and encode it to base64
*/}}
{{- define "octopus-deploy.generateMasterKey" -}}
{{- $randomBytes := randAlphaNum 16 -}}
{{- $base64String := $randomBytes | b64enc -}}
{{- printf "%s" $base64String -}}
{{- end -}}
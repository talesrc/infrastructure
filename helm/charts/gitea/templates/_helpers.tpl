{{/* Gitea repository migration job name */}}
{{- define "gitea.jobs.mirrorRepository.name" }}
{{- printf "gitea-mirror-repository-%s" .repository }}
{{- end }}

{{/* Gitea repository migration job labels */}}
{{- define "gitea.jobs.mirrorRepository.labels" -}}
app.kubernetes.io/managed-by: {{ .context.Release.Service | quote }}
repository: {{ .repository }}
{{- end }}

{{/* Gitea repository migration job annotations */}}
{{- define "gitea.jobs.mirrorRepository.annotations" -}}
meta.helm.sh/release-name: {{ .Release.Name | quote }}
meta.helm.sh/release-namespace: {{ .Release.Namespace | quote }}
{{- end }}


{{/* Gitea repository mirror configmap name */}}
{{- define "gitea.jobs.mirrorRepository.configmap.name" }}
{{- printf "gitea-migrate-repository-job-scripts" }}
{{- end }}

{{/* Gitea repository mirror script name */}}
{{- define "gitea.jobs.mirrorRepository.script.name" }}
{{- printf "mirror-repository.sh" }}
{{- end }}

{{/* Gitea kubernetes local URL */}}
{{- define "gitea.localURL" }}
{{- print "http://" .Release.Name "-http:" .Values.gitea.service.http.port }}
{{- end }}

{{/* Gitea init conatiner command to wait for gitea gets ready */}}
{{- define "gitea.jobs.wait-for-gitea.command" -}}
command:
  - /bin/sh
  - -c
  - |
    while true; do
      wget {{ include "gitea.localURL" $ }} --quiet -O /dev/null
      if [ $? -eq 0 ]; then
          echo "[INIT_CONTAINER] Gitea is ready!"
          break
      else
          echo "[INIT_CONTAINER] Waiting while gitea gets ready..."
          sleep 5
      fi
    done;
{{- end }}

# radarr

![Version: 2.6.0](https://img.shields.io/badge/Version-2.6.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 5.12.2.9335](https://img.shields.io/badge/AppVersion-5.12.2.9335-informational?style=flat-square)

A fork of Sonarr to work with movies à la Couchpotato.

<br>

## Source Code

* <https://github.com/linuxserver/docker-radarr>
* <https://github.com/Radarr/Radarr>

<br>

## Installing the Chart

To install the chart with the release name `radarr`:

```console
$ helm repo add brandan-schmitz http://brandan-schmitz.github.io/helm-charts
$ helm install radarr brandan-schmitz/radarr
```

<br>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.repository | string | `"linuxserver/radarr"` | image repository |
| image.tag | string | `nil` | image tag |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| env.TZ | string | `"America/Chicago"` | Set the timezone that will be used by the container |
| env.PUID | string | `"1000"` | Set the user ID that the container will run Radarr as |
| env.PGID | string | `"1000"` | Set the group ID that the container will run Radarr as |
| service.main.enabled | bool | `true` | Enables or disables the service |
| service.main.type | string | `"ClusterIP"` | Set the service type |
| service.main.externalTrafficPolicy | string | `nil` | [[ref](https://kubernetes.io/docs/tutorials/services/source-ip/)] |
| service.main.annotations | object | `{}` | Provide additional annotations which may be required. |
| service.main.labels | object | `{}` | Provide additional labels which may be required. |
| service.main.ports.http.port | int | `7878` | The port number |
| service.main.ports.http.protocol | string | `"HTTP"` | Port protocol. |
| service.main.ports.http.nodePort | int | `7878` | Specify the nodePort value for the LoadBalancer and NodePort service types. [[ref]](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport) |
| ingress.main.enabled | bool | `false` | Enables or disables the ingress |
| ingress.main.primary | bool | `true` | Make this the primary ingress (used in probes, notes, etc...). If there is more than 1 ingress, make sure that only 1 ingress is marked as primary. |
| ingress.main.nameOverride | string | `nil` | Override the name suffix that is used for this ingress. |
| ingress.main.annotations | object | `{}` | Provide additional annotations which may be required. |
| ingress.main.labels | object | `{}` | Provide additional labels which may be required. |
| ingress.main.ingressClassName | string | `nil` | Set the ingressClass that is used for this ingress. |
| ingress.main.hosts[0].host | string | `"chart-example.local"` | Host address. Helm template can be passed. |
| ingress.main.hosts[0].paths[0].path | string | `"/"` | Path.  Helm template can be passed. |
| ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.main.hosts[0].paths[0].service.name | string | `nil` | Overrides the service name reference for this path |
| ingress.main.hosts[0].paths[0].service.port | string | `nil` | Overrides the service port reference for this path |
| ingress.main.tls | list | `[]` | Configure TLS for the ingress. Both secretName and hosts can process a Helm template. |
| persistence.config | object | See below | Persistence for Radarr configuration and cache files. |
| persistence.config.enabled | bool | `true` | Enables or disables the persistence item |
| persistence.config.storageClass | string | `nil` | Storage Class for the config volume. If set to `-`, dynamic provisioning is disabled. If set to something else, the given storageClass is used. If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. |
| persistence.config.existingClaim | string | `nil` | If you want to reuse an existing claim, the name of the existing PVC can be passed here. |
| persistence.config.accessMode | string | `"ReadWriteOnce"` | AccessMode for the persistent volume. Make sure to select an access mode that is supported by your storage provider! [[ref]](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) |
| persistence.config.size | string | `"10Gi"` | The amount of storage that is requested for the persistent volume. |
| persistence.config.retain | bool | `true` | Set to true to retain the PVC upon `helm uninstall` |
| persistence.media | object | See below | Persistence for media files. |
| persistence.media.enabled | bool | `true` | Enables or disables the persistence item |
| persistence.media.storageClass | string | `nil` | Storage Class for the config volume. If set to `-`, dynamic provisioning is disabled. If set to something else, the given storageClass is used. If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. |
| persistence.media.existingClaim | string | `nil` | If you want to reuse an existing claim, the name of the existing PVC can be passed here. |
| persistence.media.accessMode | string | `"ReadWriteOnce"` | AccessMode for the persistent volume. Make sure to select an access mode that is supported by your storage provider! [[ref]](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) |
| persistence.media.size | string | `"1Ti"` | The amount of storage that is requested for the persistent volume. |
| persistence.media.retain | bool | `true` | Set to true to retain the PVC upon `helm uninstall` |
| resources.requests.cpu | string | `"500m"` | CPU Request amount |
| resources.requests.memory | string | `"512Mi"` |  |
| resources.limits.cpu | string | `"1500m"` | CPU Limit amount |
| resources.limits.memory | string | `"2Gi"` | Memory Limit amount |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.3](https://github.com/norwoodj/helm-docs/releases/v1.11.3)
# bitmagnet

![Version: 1.0.4](https://img.shields.io/badge/Version-1.0.4-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.10.0](https://img.shields.io/badge/AppVersion-0.10.0-informational?style=flat-square)

A self-hosted BitTorrent indexer, DHT crawler, content classifier and torrent search engine with web UI, GraphQL API and Servarr stack integration.

<br>

## Source Code

* <https://github.com/bitmagnet-io/bitmagnet>
* <https://bitmagnet.io/>

<br>

## Installing the Chart

To install the chart with the release name `bitmagnet`:

```console
$ helm repo add brandan-schmitz http://brandan-schmitz.github.io/helm-charts
$ helm install bitmagnet brandan-schmitz/bitmagnet
```

<br>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| controllers.bitmagnet.initContainers.wait-for-postgres.image.repository | string | `"postgres"` |  |
| controllers.bitmagnet.initContainers.wait-for-postgres.image.tag | string | `"16-alpine"` |  |
| controllers.bitmagnet.initContainers.wait-for-postgres.image.pullPolicy | string | `"IfNotPresent"` |  |
| controllers.bitmagnet.initContainers.wait-for-postgres.command[0] | string | `"sh"` |  |
| controllers.bitmagnet.initContainers.wait-for-postgres.command[1] | string | `"-c"` |  |
| controllers.bitmagnet.initContainers.wait-for-postgres.command[2] | string | `"until pg_isready -h $POSTGRES_HOST -p 5432; do echo \"waiting for postgres\"; sleep 2; done;\n"` |  |
| controllers.bitmagnet.initContainers.wait-for-postgres.env[0].name | string | `"POSTGRES_HOST"` |  |
| controllers.bitmagnet.initContainers.wait-for-postgres.env[0].value | string | `"{{ .Release.Name }}-postgres"` |  |
| controllers.bitmagnet.initContainers.wait-for-postgres.env[1].name | string | `"POSTGRES_DB"` |  |
| controllers.bitmagnet.initContainers.wait-for-postgres.env[1].value | string | `"bitmagnet"` |  |
| controllers.bitmagnet.initContainers.wait-for-postgres.env[2].name | string | `"POSTGRES_USER"` |  |
| controllers.bitmagnet.initContainers.wait-for-postgres.env[2].valueFrom.secretKeyRef.name | string | `"{{ .Release.Name }}-secrets"` |  |
| controllers.bitmagnet.initContainers.wait-for-postgres.env[2].valueFrom.secretKeyRef.key | string | `"postgres-username"` |  |
| controllers.bitmagnet.initContainers.wait-for-postgres.env[3].name | string | `"POSTGRES_PASSWORD"` |  |
| controllers.bitmagnet.initContainers.wait-for-postgres.env[3].valueFrom.secretKeyRef.name | string | `"{{ .Release.Name }}-secrets"` |  |
| controllers.bitmagnet.initContainers.wait-for-postgres.env[3].valueFrom.secretKeyRef.key | string | `"postgres-password"` |  |
| controllers.bitmagnet.containers.bitmagnet.image.repository | string | `"ghcr.io/bitmagnet-io/bitmagnet"` | image repository |
| controllers.bitmagnet.containers.bitmagnet.image.tag | string | `nil` | image tag (defaults to version defined in the chart) |
| controllers.bitmagnet.containers.bitmagnet.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| controllers.bitmagnet.containers.bitmagnet.args[0] | string | `"worker"` |  |
| controllers.bitmagnet.containers.bitmagnet.args[1] | string | `"run"` |  |
| controllers.bitmagnet.containers.bitmagnet.args[2] | string | `"--all"` |  |
| controllers.bitmagnet.containers.bitmagnet.env | list | `[{"name":"POSTGRES_HOST","value":"{{ .Release.Name }}-postgres"},{"name":"POSTGRES_NAME","value":"bitmagnet"},{"name":"POSTGRES_USER","valueFrom":{"secretKeyRef":{"key":"postgres-username","name":"{{ .Release.Name }}-secrets"}}},{"name":"POSTGRES_PASSWORD","valueFrom":{"secretKeyRef":{"key":"postgres-password","name":"{{ .Release.Name }}-secrets"}}},{"name":"TMDB_API_KEY","valueFrom":{"secretKeyRef":{"key":"tmdb-api-key","name":"{{ .Release.Name }}-secrets"}}}]` | Environment variables. Template enabled. |
| controllers.bitmagnet.containers.bitmagnet.probes | object | `{"liveness":{"custom":false,"enabled":true,"spec":{"failureThreshold":3,"initialDelaySeconds":0,"periodSeconds":10,"timeoutSeconds":1},"type":"TCP"},"readiness":{"custom":false,"enabled":true,"spec":{"failureThreshold":3,"initialDelaySeconds":0,"periodSeconds":10,"timeoutSeconds":1},"type":"TCP"},"startup":{"custom":false,"enabled":true,"spec":{"failureThreshold":30,"initialDelaySeconds":0,"periodSeconds":5,"timeoutSeconds":1},"type":"TCP"}}` | [[ref]](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
| controllers.bitmagnet.containers.bitmagnet.probes.liveness | object | See below | Liveness probe configuration |
| controllers.bitmagnet.containers.bitmagnet.probes.liveness.enabled | bool | `true` | Enable the liveness probe |
| controllers.bitmagnet.containers.bitmagnet.probes.liveness.custom | bool | `false` | Set this to `true` if you wish to specify your own livenessProbe |
| controllers.bitmagnet.containers.bitmagnet.probes.liveness.type | string | "TCP" | sets the probe type when not using a custom probe |
| controllers.bitmagnet.containers.bitmagnet.probes.liveness.spec | object | See below | The spec field contains the values for the default livenessProbe. If you selected `custom: true`, this field holds the definition of the livenessProbe. |
| controllers.bitmagnet.containers.bitmagnet.probes.readiness | object | `{"custom":false,"enabled":true,"spec":{"failureThreshold":3,"initialDelaySeconds":0,"periodSeconds":10,"timeoutSeconds":1},"type":"TCP"}` | Readiness probe configuration |
| controllers.bitmagnet.containers.bitmagnet.probes.readiness.enabled | bool | `true` | Enable the readiness probe |
| controllers.bitmagnet.containers.bitmagnet.probes.readiness.custom | bool | `false` | Set this to `true` if you wish to specify your own readinessProbe |
| controllers.bitmagnet.containers.bitmagnet.probes.readiness.type | string | "TCP" | sets the probe type when not using a custom probe |
| controllers.bitmagnet.containers.bitmagnet.probes.readiness.spec | object | See below | The spec field contains the values for the default readinessProbe. If you selected `custom: true`, this field holds the definition of the readinessProbe. |
| controllers.bitmagnet.containers.bitmagnet.probes.startup | object | `{"custom":false,"enabled":true,"spec":{"failureThreshold":30,"initialDelaySeconds":0,"periodSeconds":5,"timeoutSeconds":1},"type":"TCP"}` | Startup probe configuration |
| controllers.bitmagnet.containers.bitmagnet.probes.startup.enabled | bool | `true` | Enable the startup probe |
| controllers.bitmagnet.containers.bitmagnet.probes.startup.custom | bool | `false` | Set this to `true` if you wish to specify your own startupProbe |
| controllers.bitmagnet.containers.bitmagnet.probes.startup.type | string | "TCP" | sets the probe type when not using a custom probe |
| controllers.bitmagnet.containers.bitmagnet.probes.startup.spec | object | See below | The spec field contains the values for the default startupProbe. If you selected `custom: true`, this field holds the definition of the startupProbe. |
| controllers.bitmagnet.containers.bitmagnet.resources | object | `{}` | Set the resource requests / limits for the container. |
| controllers.postgres.enabled | bool | `true` | enable the controller. |
| controllers.postgres.type | string | `"statefulset"` | Set the controller type. Valid options are deployment, daemonset, statefulset, cronjob or job |
| controllers.postgres.replicas | int | `1` | Number of desired pods. When using a HorizontalPodAutoscaler, set this to `null`. |
| controllers.postgres.strategy | string | `"OnDelete"` | Set the controller upgrade strategy |
| controllers.postgres.statefulset | object | `{"volumeClaimTemplates":[{"accessMode":"ReadWriteOnce","annotations":{},"globalMounts":[{"path":"/var/lib/postgresql"}],"labels":{},"name":"data","size":"80Gi"}]}` | StatefulSet configuration. |
| controllers.postgres.statefulset.volumeClaimTemplates | list | `[{"accessMode":"ReadWriteOnce","annotations":{},"globalMounts":[{"path":"/var/lib/postgresql"}],"labels":{},"name":"data","size":"80Gi"}]` | Used to create individual disks for each instance. |
| controllers.postgres.containers.postgres.image.repository | string | `"postgres"` | image repository |
| controllers.postgres.containers.postgres.image.tag | string | `"16-alpine"` | image tag |
| controllers.postgres.containers.postgres.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| controllers.postgres.containers.postgres.env | list | `[{"name":"POSTGRES_HOST","value":"{{ .Release.Name }}-postgres"},{"name":"POSTGRES_DB","value":"bitmagnet"},{"name":"POSTGRES_USER","valueFrom":{"secretKeyRef":{"key":"postgres-username","name":"{{ .Release.Name }}-secrets"}}},{"name":"POSTGRES_PASSWORD","valueFrom":{"secretKeyRef":{"key":"postgres-password","name":"{{ .Release.Name }}-secrets"}}}]` | Environment variables. Template enabled. |
| controllers.postgres.containers.postgres.probes | object | `{"liveness":{"custom":true,"enabled":true,"spec":{"exec":{"command":["sh","-c","pg_isready -U \"$POSTGRES_USER\" -d \"$POSTGRES_DB\" -h localhost\n"]},"failureThreshold":3,"initialDelaySeconds":60,"periodSeconds":30,"timeoutSeconds":5}},"readiness":{"custom":true,"enabled":true,"spec":{"exec":{"command":["sh","-c","psql -U \"$POSTGRES_USER\" -d \"$POSTGRES_DB\" -c \"SELECT 1\"\n"]},"failureThreshold":3,"initialDelaySeconds":20,"periodSeconds":15,"timeoutSeconds":5}},"startup":{"custom":true,"enabled":true,"spec":{"exec":{"command":["sh","-c","pg_isready -U \"$POSTGRES_USER\" -d \"$POSTGRES_DB\" -h localhost\n"]},"failureThreshold":12,"initialDelaySeconds":10,"periodSeconds":10,"timeoutSeconds":5}}}` | [[ref]](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
| controllers.postgres.containers.postgres.probes.liveness | object | See below | Liveness probe configuration |
| controllers.postgres.containers.postgres.probes.liveness.enabled | bool | `true` | Enable the liveness probe |
| controllers.postgres.containers.postgres.probes.liveness.custom | bool | `true` | Set this to `true` if you wish to specify your own livenessProbe |
| controllers.postgres.containers.postgres.probes.liveness.spec | object | See below | The spec field contains the values for the default livenessProbe. |
| controllers.postgres.containers.postgres.probes.readiness | object | `{"custom":true,"enabled":true,"spec":{"exec":{"command":["sh","-c","psql -U \"$POSTGRES_USER\" -d \"$POSTGRES_DB\" -c \"SELECT 1\"\n"]},"failureThreshold":3,"initialDelaySeconds":20,"periodSeconds":15,"timeoutSeconds":5}}` | Readiness probe configuration |
| controllers.postgres.containers.postgres.probes.readiness.enabled | bool | `true` | Enable the readiness probe |
| controllers.postgres.containers.postgres.probes.readiness.custom | bool | `true` | Set this to `true` if you wish to specify your own readinessProbe |
| controllers.postgres.containers.postgres.probes.readiness.spec | object | See below | The spec field contains the values for the default readinessProbe. |
| controllers.postgres.containers.postgres.probes.startup | object | `{"custom":true,"enabled":true,"spec":{"exec":{"command":["sh","-c","pg_isready -U \"$POSTGRES_USER\" -d \"$POSTGRES_DB\" -h localhost\n"]},"failureThreshold":12,"initialDelaySeconds":10,"periodSeconds":10,"timeoutSeconds":5}}` | Startup probe configuration |
| controllers.postgres.containers.postgres.probes.startup.enabled | bool | `true` | Enable the startup probe |
| controllers.postgres.containers.postgres.probes.startup.custom | bool | `true` | Set this to `true` if you wish to specify your own startupProbe |
| controllers.postgres.containers.postgres.probes.startup.spec | object | See below | The spec field contains the values for the default startupProbe. |
| controllers.postgres.containers.postgres.resources | object | `{}` | Set the resource requests / limits for the container. |
| secrets | object | See below | Use this to populate secrets with the values you specify. Be aware that these values are not encrypted by default, and could therefore visible to anybody with access to the values.yaml file. |
| secrets.bitmagnet-secrets.enabled | bool | `true` | Enables or disables the Secret |
| secrets.bitmagnet-secrets.suffix | string | `"secrets"` | Sets the suffix of the secret otherwise it will just be the release name |
| secrets.bitmagnet-secrets.stringData | object | `{"postgres-password":"K8Y763jYxsFz","postgres-username":"postgres"}` | Secret stringData content. Helm template enabled. |
| service | object | See below | Configure the services for the chart here. Additional services can be added by adding a dictionary key similar to the 'main' service. |
| service.bitmagnet.enabled | bool | `true` | Enables or disables the service |
| service.bitmagnet.controller | string | `"bitmagnet"` | Configure which controller this service should target |
| service.bitmagnet.primary | bool | `true` | Make this the primary service for this controller (used in probes, notes, etc...). If there is more than 1 service targeting the controller, make sure that only 1 service is marked as primary. |
| service.bitmagnet.type | string | `"ClusterIP"` | Set the service type |
| service.bitmagnet.annotations | object | `{}` | Provide additional annotations which may be required. |
| service.bitmagnet.labels | object | `{}` | Provide additional labels which may be required. |
| service.bitmagnet.extraSelectorLabels | object | `{}` | Allow adding additional match labels |
| service.bitmagnet.ports | object | See below | Configure the Service port information here. Additional ports can be added by adding a dictionary key similar to the 'http' service. |
| service.bitmagnet.ports.http.enabled | bool | `true` | Enables or disables the port |
| service.bitmagnet.ports.http.primary | bool | `true` | Make this the primary port |
| service.bitmagnet.ports.http.port | int | `80` | The port number |
| service.bitmagnet.ports.http.protocol | string | `"HTTP"` | Port protocol. Support values are `HTTP`, `HTTPS`, `TCP` and `UDP`. HTTP and HTTPS spawn a TCP service and get used for internal URL and name generation |
| service.bitmagnet.ports.http.targetPort | int | `3333` | Specify a service targetPort if you wish to differ the service port from the application port. |
| service.bitmagnet.ports.bittorrent-tcp.enabled | bool | `true` | Enables or disables the port |
| service.bitmagnet.ports.bittorrent-tcp.primary | bool | `true` | Make this the primary port |
| service.bitmagnet.ports.bittorrent-tcp.port | int | `3334` | The port number |
| service.bitmagnet.ports.bittorrent-tcp.protocol | string | `"TCP"` | Port protocol. Support values are `HTTP`, `HTTPS`, `TCP` and `UDP`. HTTP and HTTPS spawn a TCP service and get used for internal URL and name generation |
| service.bitmagnet.ports.bittorrent-udp.enabled | bool | `true` | Enables or disables the port |
| service.bitmagnet.ports.bittorrent-udp.primary | bool | `true` | Make this the primary port |
| service.bitmagnet.ports.bittorrent-udp.port | int | `3334` | The port number |
| service.bitmagnet.ports.bittorrent-udp.protocol | string | `"UDP"` | Port protocol. Support values are `HTTP`, `HTTPS`, `TCP` and `UDP`. HTTP and HTTPS spawn a TCP service and get used for internal URL and name generation |
| service.postgres.enabled | bool | `true` | Enables or disables the service |
| service.postgres.controller | string | `"postgres"` | Configure which controller this service should target |
| service.postgres.primary | bool | `true` | Make this the primary service for this controller (used in probes, notes, etc...). If there is more than 1 service targeting the controller, make sure that only 1 service is marked as primary. |
| service.postgres.type | string | `"ClusterIP"` | Set the service type |
| service.postgres.annotations | object | `{}` | Provide additional annotations which may be required. |
| service.postgres.labels | object | `{}` | Provide additional labels which may be required. |
| service.postgres.extraSelectorLabels | object | `{}` | Allow adding additional match labels |
| service.postgres.ports | object | See below | Configure the Service port information here. Additional ports can be added by adding a dictionary key similar to the 'http' service. |
| service.postgres.ports.postgres.enabled | bool | `true` | Enables or disables the port |
| service.postgres.ports.postgres.primary | bool | `true` | Make this the primary port |
| service.postgres.ports.postgres.port | int | `5432` | The port number |
| service.postgres.ports.postgres.protocol | string | `"TCP"` | Port protocol. Support values are `HTTP`, `HTTPS`, `TCP` and `UDP`. HTTP and HTTPS spawn a TCP service and get used for internal URL and name generation |
| ingress | object | `{}` | Configure the ingresses for the chart here. |
| persistence | object | See below | Configure persistence for the chart here. Additional items can be added by adding a dictionary key similar to the 'config' key. [[ref]](https://bjw-s-labs.github.io/helm-charts/docs/common-library/common-library-storage) |
| persistence.bitmagnet-config.enabled | bool | `true` | Enables or disables the persistence item. Defaults to true |
| persistence.bitmagnet-config.suffix | string | `"config"` | The sufix to append to the release name for this item. |
| persistence.bitmagnet-config.type | string | `"persistentVolumeClaim"` | Sets the persistence type Valid options are persistentVolumeClaim, emptyDir, nfs, hostPath, secret, configMap or custom |
| persistence.bitmagnet-config.storageClass | string | `nil` | Storage Class for the config volume. If set to `-`, dynamic provisioning is disabled. If set to something else, the given storageClass is used. If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. |
| persistence.bitmagnet-config.existingClaim | string | `nil` | If you want to reuse an existing claim, the name of the existing PVC can be passed here. |
| persistence.bitmagnet-config.dataSource | object | `{}` | The optional data source for the persistentVolumeClaim. [[ref]](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#volume-populators-and-data-sources) |
| persistence.bitmagnet-config.dataSourceRef | object | `{}` | The optional volume populator for the persistentVolumeClaim. [[ref]](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#volume-populators-and-data-sources) |
| persistence.bitmagnet-config.accessMode | string | `"ReadWriteOnce"` | AccessMode for the persistent volume. Make sure to select an access mode that is supported by your storage provider! [[ref]](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) |
| persistence.bitmagnet-config.size | string | `"10Gi"` | The amount of storage that is requested for the persistent volume. |
| persistence.bitmagnet-config.retain | bool | `true` | Set to true to retain the PVC upon `helm uninstall` |
| persistence.bitmagnet-config.advancedMounts | object | `{"bitmagnet":{"main":[{"path":"/root/.config/bitmagnet","readOnly":false}]}}` | Configure mounts to all controllers and containers. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.3](https://github.com/norwoodj/helm-docs/releases/v1.11.3)
# octopus-deploy

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![AppVersion: 2023.4.8166](https://img.shields.io/badge/AppVersion-2023.4.8166-informational?style=flat-square)

Octopus automates complex deployments. This chart deploys the Octopus Deploy server into a Kubernetes cluster.

<br>

## Source Code

* <https://octopus.com>
* <https://hub.docker.com/r/octopusdeploy/octopusdeploy>
* <https://mcr.microsoft.com/en-us/product/mssql/server/>

<br>

## Installing the Chart

To install the chart with the release name `octopus-deploy`:

```console
$ helm repo add brandan-schmitz http://brandan-schmitz.github.io/helm-charts
$ helm install octopus-deploy brandan-schmitz/octopus-deploy
```

<br>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| settings.existingSecret | string | `nil` | If this is defined, this chart will pull the below settings from the secret defined. This is useful if upgrading from previous deployments. |
| settings.retain | bool | `false` | Set to true to retain the secret containing the config upon "helm uninstall" |
| settings.acceptEula | bool | `false` | Do you accept the [Microsoft SQL Server Eula](https://hub.docker.com/r/microsoft/mssql-server-windows-express/) and the [Octopus Deploy Eula](https://octopus.com/company/legal)? |
| settings.databaseName | string | `"OctopusDeploy"` | The name of the database to use for Octopus |
| settings.databaseUser | string | `"sa"` | The username for the database server and what Octopus will use to connect to the database. If using the built in database to this chart this must be "sa". |
| settings.databasePassword | string | `"thispasswordshouldbechanged"` | The password for the database server and what Octopus will use to connect to the database |
| settings.masterKey | string | `nil` |  |
| settings.adminEmail | string | `""` | The email address to associate with the first admin user for Octopus Deploy |
| settings.adminUsername | string | `"admin"` | The username to associate with the first admin user for Octopus Deploy |
| settings.adminPassword | string | `"DefaultPassword*1234"` | The password to associate with the first admin user for Octopus Deploy |
| settings.licenseKey | string | `nil` | The license key to use for Octopus Deploy. If this is left blank then it will automatically attempt to create a free license key. |
| settings.enableDockerInDocker | bool | `false` | Docker-In-Docker is used to support worker container images. WARNING: Enabling this forces the Octopus Deploy container to run in privileged mode. |
| octopus.image.repository | string | `"octopusdeploy/octopusdeploy"` | image repository |
| octopus.image.tag | string | `nil` | image tag (uses appVersion by default) |
| octopus.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| octopus.statefulset.annotations | object | `{}` | Set annotations on the deployment/statefulset/daemonset/cronjob |
| octopus.statefulset.labels | object | `{}` | Set labels on the deployment/statefulset/daemonset/cronjob |
| octopus.statefulset.replicas | int | `1` | Number of desired pods. |
| octopus.statefulset.strategy | string | `"RollingUpdate"` | Set the upgrade strategy Valid values are OnDelete and RollingUpdate (default). |
| octopus.statefulset.rollingUpdate.unavailable | string | `nil` | Set deployment RollingUpdate max unavailable |
| octopus.statefulset.rollingUpdate.surge | string | `nil` | Set deployment RollingUpdate max surge |
| octopus.statefulset.rollingUpdate.partition | string | `nil` | Set statefulset RollingUpdate partition |
| octopus.podOverrides | object | `{}` | Overide various options for the octopus pods. You can see the items able to be overridden by looking at the defaultPodOptions section [here](https://github.com/bjw-s/helm-charts/blob/main/charts/library/common/values.yaml). |
| octopus.resources | object | `{}` |  |
| octopus.storage.individual | object | See below | Configure the volumeClaimTemplate that will be used to create per-pod persistence. |
| octopus.storage.individual.enabled | bool | `true` | Enables or disables the persistence item. |
| octopus.storage.individual.storageClass | string | `nil` | Storage Class for the config volume. If set to `-`, dynamic provisioning is disabled. If set to something else, the given storageClass is used. If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. |
| octopus.storage.individual.accessMode | string | `"ReadWriteOnce"` | AccessMode for the persistent volume. Make sure this is ReadWriteMany if you have more than one replica. |
| octopus.storage.individual.size | string | `"10Gi"` | The amount of storage that is requested for the persistent volume. |
| octopus.storage.individual.retain | bool | `true` | Set to true to retain the PVC upon `helm uninstall` |
| octopus.storage.shared | object | See below | Configure the persistentVolumeClaim that will be used to create shared storage between pods. |
| octopus.storage.shared.enabled | bool | `true` | Enables or disables the persistence item. |
| octopus.storage.shared.storageClass | string | `nil` | Storage Class for the config volume. If set to `-`, dynamic provisioning is disabled. If set to something else, the given storageClass is used. If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. |
| octopus.storage.shared.existingClaim | string | `nil` | If you want to reuse an existing claim, the name of the existing PVC can be passed here. |
| octopus.storage.shared.accessMode | string | `"ReadWriteMany"` | AccessMode for the persistent volume. Make sure this is ReadWriteMany if you have more than one replica. |
| octopus.storage.shared.size | string | `"25Gi"` | The amount of storage that is requested for the persistent volume. |
| octopus.storage.shared.retain | bool | `true` | Set to true to retain the PVC upon `helm uninstall` |
| octopus.service.enabled | bool | `true` | Enables or disables the service |
| octopus.service.type | string | `"ClusterIP"` | Set the service type |
| octopus.service.externalTrafficPolicy | string | `nil` | [[ref](https://kubernetes.io/docs/tutorials/services/source-ip/)] |
| octopus.service.ipFamilyPolicy | string | `nil` | Specify the ip policy. Options: SingleStack, PreferDualStack, RequireDualStack |
| octopus.service.ipFamilies | list | `[]` | The ip families that should be used. Options: IPv4, IPv6 |
| octopus.service.annotations | object | `{}` | Provide additional annotations which may be required. |
| octopus.service.labels | object | `{}` | Provide additional labels which may be required. |
| octopus.service.extraSelectorLabels | object | `{}` | Allow adding additional match labels |
| octopus.service.ports.http.enabled | bool | `true` | Enable or disable the HTTP port for octopus-deploy |
| octopus.service.ports.http.port | int | `8080` | Set the port number that will be exposed by the service for the HTTP server. |
| octopus.service.ports.polling.enabled | bool | `true` | Enable or disable the tentacle polling port for octopus-deploy |
| octopus.service.ports.polling.port | int | `10943` | Set the port number that will be exposed by the service for the tentacle polling server. |
| octopus.probes.liveness | object | See below | Liveness probe configuration |
| octopus.probes.liveness.enabled | bool | `true` | Enable the liveness probe |
| octopus.probes.liveness.spec | object | See below | The spec field contains the values for the default livenessProbe. |
| octopus.probes.readiness | object | See below | Redainess probe configuration |
| octopus.probes.readiness.enabled | bool | `true` | Enable the readiness probe |
| octopus.probes.readiness.spec | object | See below | The spec field contains the values for the default readinessProbe. |
| octopus.probes.startup | object | See below | Startup probe configuration |
| octopus.probes.startup.enabled | bool | `true` | Enable the startup probe |
| octopus.probes.startup.spec | object | See below | The spec field contains the values for the default startupProbe. |
| octopus.ingress.enabled | bool | `false` | Enables or disables the ingress |
| octopus.ingress.annotations | object | `{}` | Provide additional annotations which may be required. |
| octopus.ingress.labels | object | `{}` | Provide additional labels which may be required. |
| octopus.ingress.className | string | `nil` | Set the ingressClass that is used for this ingress. |
| octopus.ingress.hostname | string | `"chart-example.local"` | Set the hostname that octopus will be exposed on. |
| octopus.ingress.tls | list | `[]` | Configure TLS for the ingress. Both secretName and hosts can process a Helm template. |
| mssql.image.repository | string | `"mcr.microsoft.com/mssql/server"` | image repository |
| mssql.image.tag | string | `"2022-CU10-ubuntu-22.04"` | image tag |
| mssql.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| mssql.resources | object | `{}` |  |
| mssql.podOverrides | object | `{}` | Overide various options for the mssql pods. You can see the items able to be overridden by looking at the defaultPodOptions section [here](https://github.com/bjw-s/helm-charts/blob/main/charts/library/common/values.yaml). |
| mssql.storage.enabled | bool | `true` | Enables or disables the persistence item. |
| mssql.storage.storageClass | string | `nil` | Storage Class for the config volume. If set to `-`, dynamic provisioning is disabled. If set to something else, the given storageClass is used. If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. |
| mssql.storage.existingClaim | string | `nil` | If you want to reuse an existing claim, the name of the existing PVC can be passed here. |
| mssql.storage.accessMode | string | `"ReadWriteOnce"` | AccessMode for the persistent volume. Make sure this is ReadWriteMany if you have more than one replica. |
| mssql.storage.size | string | `"25Gi"` | The amount of storage that is requested for the persistent volume. |
| mssql.storage.retain | bool | `true` | Set to true to retain the PVC upon `helm uninstall` |
| mssql.service.enabled | bool | `true` | Enables or disables the service |
| mssql.service.type | string | `"ClusterIP"` | Set the service type |
| mssql.service.externalTrafficPolicy | string | `nil` | [[ref](https://kubernetes.io/docs/tutorials/services/source-ip/)] |
| mssql.service.ipFamilyPolicy | string | `nil` | Specify the ip policy. Options: SingleStack, PreferDualStack, RequireDualStack |
| mssql.service.ipFamilies | list | `[]` | The ip families that should be used. Options: IPv4, IPv6 |
| mssql.service.annotations | object | `{}` | Provide additional annotations which may be required. |
| mssql.service.labels | object | `{}` | Provide additional labels which may be required. |
| mssql.service.extraSelectorLabels | object | `{}` | Allow adding additional match labels |
| mssql.service.ports.mssql.enabled | bool | `true` | Enable or disable the HTTP port for octopus-deploy |
| mssql.service.ports.mssql.port | int | `1433` | Set the port number that will be exposed by the service for the HTTP server. |
| mssql.probes.liveness | object | See below | Liveness probe configuration |
| mssql.probes.liveness.enabled | bool | `true` | Enable the liveness probe |
| mssql.probes.liveness.spec | object | See below | The spec field contains the values for the default livenessProbe. |
| mssql.probes.readiness | object | See below | Redainess probe configuration |
| mssql.probes.readiness.enabled | bool | `true` | Enable the readiness probe |
| mssql.probes.readiness.spec | object | See below | The spec field contains the values for the default readinessProbe. |
| mssql.probes.startup | object | See below | Startup probe configuration |
| mssql.probes.startup.enabled | bool | `true` | Enable the startup probe |
| mssql.probes.startup.spec | object | See below | The spec field contains the values for the default startupProbe. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.3](https://github.com/norwoodj/helm-docs/releases/v1.11.3)
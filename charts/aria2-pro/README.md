# aria2-pro

![Version: 1.1.3](https://img.shields.io/badge/Version-1.1.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 202209060423](https://img.shields.io/badge/AppVersion-202209060423-informational?style=flat-square)

A perfect Aria2 Docker image. Out of the box, just add download tasks and don't need to think about anything else.

<br>

## Source Code

* <https://github.com/P3TERX/Aria2-Pro-Docker>
* <https://github.com/aria2/aria2>

<br>

## Installing the Chart

To install the chart with the release name `aria2-pro`:

```console
$ helm repo add brandan-schmitz http://brandan-schmitz.github.io/helm-charts
$ helm install aria2-pro brandan-schmitz/aria2-pro
```

<br>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.repository | string | `"p3terx/aria2-pro"` | image repository |
| image.tag | string | `nil` | image tag |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| env.TZ | string | `"America/Chicago"` | Set the timezone that will be used by the container |
| env.PUID | string | `"1000"` | Set the user ID that the container will run as |
| env.PGID | string | `"1000"` | Set the group ID that the container will as |
| env.UMASK_SET | int | `18` | The default umask to set for the container |
| env.RPC_SECRET | string | `nil` | Set the secret that is used for RPC communication to Aira2 |
| env.RPC_PORT | int | `6800` | Set the port that Aria2 listens on for RPC communications |
| env.UPDATE_TRACKERS | bool | `false` | Enable or disable the updating of common torrent trackers for torrent downloads |
| service.main.enabled | bool | `true` | Enables or disables the service |
| service.main.type | string | `"ClusterIP"` | Set the service type |
| service.main.externalTrafficPolicy | string | `nil` | [[ref](https://kubernetes.io/docs/tutorials/services/source-ip/)] |
| service.main.annotations | object | `{}` | Provide additional annotations which may be required. |
| service.main.labels | object | `{}` | Provide additional labels which may be required. |
| service.main.ports.http | object | See below | Configure the port for the AriaNG Interface |
| service.main.ports.http.port | int | `80` | The port number |
| service.main.ports.http.protocol | string | `"HTTP"` | Port protocol. |
| service.main.ports.http.nodePort | int | `80` | Specify the nodePort value for the LoadBalancer and NodePort service types. [[ref]](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport) |
| service.main.ports.http.targetPort | int | `6880` | Specify a service targetPort if you wish to differ the service port from the application port. If `targetPort` is specified, this port number is used in the container definition instead of the `port` value. Therefore named ports are not supported for this field. |
| service.main.ports.rpc | object | See below | Configure the port for the Aria2 RPC communications |
| service.main.ports.rpc.port | int | `6800` | The port number |
| service.main.ports.rpc.protocol | string | `"TCP"` | Port protocol. |
| service.main.ports.rpc.nodePort | int | `6800` | Specify the nodePort value for the LoadBalancer and NodePort service types. [[ref]](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport) |
| persistence.config | object | See below | Persistence for Aria2 and AriaNG configuration files. |
| persistence.config.enabled | bool | `true` | Enables or disables the persistence item |
| persistence.config.storageClass | string | `nil` | Storage Class for the config volume. If set to `-`, dynamic provisioning is disabled. If set to something else, the given storageClass is used. If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. |
| persistence.config.existingClaim | string | `nil` | If you want to reuse an existing claim, the name of the existing PVC can be passed here. |
| persistence.config.accessMode | string | `"ReadWriteOnce"` | AccessMode for the persistent volume. Make sure to select an access mode that is supported by your storage provider! [[ref]](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) |
| persistence.config.size | string | `"1Gi"` | The amount of storage that is requested for the persistent volume. |
| persistence.config.retain | bool | `true` | Set to true to retain the PVC upon `helm uninstall` |
| persistence.data | object | See below | Persistence for downloaded data |
| persistence.data.enabled | bool | `true` | Enables or disables the persistence item |
| persistence.data.storageClass | string | `nil` | Storage Class for the config volume. If set to `-`, dynamic provisioning is disabled. If set to something else, the given storageClass is used. If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. |
| persistence.data.existingClaim | string | `nil` | If you want to reuse an existing claim, the name of the existing PVC can be passed here. |
| persistence.data.accessMode | string | `"ReadWriteOnce"` | AccessMode for the persistent volume. Make sure to select an access mode that is supported by your storage provider! [[ref]](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) |
| persistence.data.size | string | `"1Ti"` | The amount of storage that is requested for the persistent volume. |
| persistence.data.retain | bool | `true` | Set to true to retain the PVC upon `helm uninstall` |
| resources.requests.cpu | string | `"500m"` | CPU Request amount |
| resources.requests.memory | string | `"1Gi"` |  |
| resources.limits.cpu | string | `"4000m"` | CPU Limit amount |
| resources.limits.memory | string | `"8Gi"` | Memory Limit amount |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.3](https://github.com/norwoodj/helm-docs/releases/v1.11.3)
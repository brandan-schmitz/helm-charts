# syncthing

![Version: 1.1.0](https://img.shields.io/badge/Version-1.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.30.0](https://img.shields.io/badge/AppVersion-1.30.0-informational?style=flat-square)

Syncthing is a continuous file synchronization program. It synchronizes files between two or more computers in real time, safely protected from prying eyes.

<br>

## Source Code

* <https://github.com/syncthing/syncthing>
* <https://syncthing.net/>

<br>

## Installing the Chart

To install the chart with the release name `syncthing`:

```console
$ helm repo add brandan-schmitz http://brandan-schmitz.github.io/helm-charts
$ helm install syncthing brandan-schmitz/syncthing
```

<br>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| controllers.main.pod.securityContext | object | `{"fsGroup":1000,"fsGroupChangePolicy":"OnRootMismatch","runAsGroup":1000,"runAsUser":1000}` | Configure the Security Context for the Pod |
| controllers.main.containers.main.image.repository | string | `"syncthing/syncthing"` | image repository |
| controllers.main.containers.main.image.tag | string | `nil` | image tag |
| controllers.main.containers.main.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| controllers.main.containers.main.resources | object | `{"limits":{"cpu":"500m","memory":"1024Mi"},"requests":{"cpu":"250m","memory":"512Mi"}}` | Set the resource requests / limits for the container. |
| service | object | See below | Configure the services for the chart here. Additional services can be added by adding a dictionary key similar to the 'main' service. |
| service.main.enabled | bool | `true` | Enables or disables the service |
| service.main.controller | string | `"main"` | Configure which controller this service should target |
| service.main.type | string | `"ClusterIP"` | Set the service type |
| service.main.annotations | object | `{}` | Provide additional annotations which may be required. |
| service.main.labels | object | `{}` | Provide additional labels which may be required. |
| service.main.extraSelectorLabels | object | `{}` | Allow adding additional match labels |
| service.main.ports | object | See below | Configure the Service port information here. Additional ports can be added by adding a dictionary key similar to the 'http' service. |
| service.main.ports.http.enabled | bool | `true` | Enables or disables the port |
| service.main.ports.http.primary | bool | `true` | Make this the primary port (used in probes, notes, etc...) If there is more than 1 service, make sure that only 1 port is marked as primary. |
| service.main.ports.http.port | int | `8384` | The port number |
| service.main.ports.http.protocol | string | `"HTTP"` | Port protocol. Support values are `HTTP`, `HTTPS`, `TCP` and `UDP`. HTTP and HTTPS spawn a TCP service and get used for internal URL and name generation |
| service.main.ports.listen.enabled | bool | `true` | Enables or disables the port |
| service.main.ports.listen.primary | bool | `true` | Make this the primary port (used in probes, notes, etc...) If there is more than 1 service, make sure that only 1 port is marked as primary. |
| service.main.ports.listen.port | int | `22000` | The port number |
| service.main.ports.listen.protocol | string | `"TCP"` | Port protocol. Support values are `HTTP`, `HTTPS`, `TCP` and `UDP`. HTTP and HTTPS spawn a TCP service and get used for internal URL and name generation |
| service.main.ports.discovery.enabled | bool | `true` | Enables or disables the port |
| service.main.ports.discovery.primary | bool | `true` | Make this the primary port (used in probes, notes, etc...) If there is more than 1 service, make sure that only 1 port is marked as primary. |
| service.main.ports.discovery.port | int | `21027` | The port number |
| service.main.ports.discovery.protocol | string | `"UDP"` | Port protocol. Support values are `HTTP`, `HTTPS`, `TCP` and `UDP`. HTTP and HTTPS spawn a TCP service and get used for internal URL and name generation |
| ingress | object | `{}` | Configure the ingresses for the chart here. |
| persistence | object | See below | Configure persistence for the chart here. Additional items can be added by adding a dictionary key similar to the 'config' key. [[ref]](https://bjw-s-labs.github.io/helm-charts/docs/common-library/common-library-storage) |
| persistence.config.enabled | bool | `true` | Enables or disables the persistence item. Defaults to true |
| persistence.config.type | string | `"persistentVolumeClaim"` | Sets the persistence type Valid options are persistentVolumeClaim, emptyDir, nfs, hostPath, secret, configMap or custom |
| persistence.config.storageClass | string | `nil` | Storage Class for the config volume. If set to `-`, dynamic provisioning is disabled. If set to something else, the given storageClass is used. If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. |
| persistence.config.existingClaim | string | `nil` | If you want to reuse an existing claim, the name of the existing PVC can be passed here. |
| persistence.config.dataSource | object | `{}` | The optional data source for the persistentVolumeClaim. [[ref]](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#volume-populators-and-data-sources) |
| persistence.config.dataSourceRef | object | `{}` | The optional volume populator for the persistentVolumeClaim. [[ref]](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#volume-populators-and-data-sources) |
| persistence.config.accessMode | string | `"ReadWriteOnce"` | AccessMode for the persistent volume. Make sure to select an access mode that is supported by your storage provider! [[ref]](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) |
| persistence.config.size | string | `"10Gi"` | The amount of storage that is requested for the persistent volume. |
| persistence.config.retain | bool | `true` | Set to true to retain the PVC upon `helm uninstall` |
| persistence.config.globalMounts | list | `[{"path":"/var/syncthing","readOnly":false}]` | Configure mounts to all controllers and containers. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.3](https://github.com/norwoodj/helm-docs/releases/v1.11.3)
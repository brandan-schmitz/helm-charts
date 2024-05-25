# flaresolverr

![Version: 1.2.3](https://img.shields.io/badge/Version-1.2.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 3.3.15](https://img.shields.io/badge/AppVersion-3.3.15-informational?style=flat-square)

FlareSolverr is a proxy server to bypass Cloudflare and DDoS-GUARD protection.

<br>

## Source Code

* <https://github.com/FlareSolverr/FlareSolverr>

<br>

## Installing the Chart

To install the chart with the release name `flaresolverr`:

```console
$ helm repo add brandan-schmitz http://brandan-schmitz.github.io/helm-charts
$ helm install flaresolverr brandan-schmitz/flaresolverr
```

<br>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.repository | string | `"flaresolverr/flaresolverr"` | image repository |
| image.tag | string | `nil` | image tag |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| env.TZ | string | `"America/Chicago"` | Set the timezone that will be used by the container |
| service.main.enabled | bool | `true` | Enables or disables the service |
| service.main.type | string | `"ClusterIP"` | Set the service type |
| service.main.externalTrafficPolicy | string | `nil` | [[ref](https://kubernetes.io/docs/tutorials/services/source-ip/)] |
| service.main.annotations | object | `{}` | Provide additional annotations which may be required. |
| service.main.labels | object | `{}` | Provide additional labels which may be required. |
| service.main.ports.http.port | int | `8191` | The port number |
| resources.requests.cpu | string | `"100m"` | CPU Request amount |
| resources.requests.memory | string | `"128Mi"` |  |
| resources.limits.cpu | string | `"250m"` | CPU Limit amount |
| resources.limits.memory | string | `"512Mi"` | Memory Limit amount |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.3](https://github.com/norwoodj/helm-docs/releases/v1.11.3)
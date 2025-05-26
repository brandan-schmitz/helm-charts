# blackhole-manager

![Version: 1.3.3](https://img.shields.io/badge/Version-1.3.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.1.2](https://img.shields.io/badge/AppVersion-v1.1.2-informational?style=flat-square)

Blackhole Manager coordinates the downloading of magnet and torrent files send to a blackhole folder from Sonarr and Radarr from real-debrid through the Aria2 download program.

<br>

## Source Code

* <https://github.com/brandan-schmitz/blackhole-manager>

<br>

## Installing the Chart

To install the chart with the release name `blackhole-manager`:

```console
$ helm repo add brandan-schmitz http://brandan-schmitz.github.io/helm-charts
$ helm install blackhole-manager brandan-schmitz/blackhole-manager
```

<br>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.repository | string | `"public-docker.nexus.celestialdata.net/brandan-schmitz/blackhole-manager"` | image repository |
| image.tag | string | `nil` | image tag |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| enableGrafanaDashboard | bool | `false` | Enable the Grafana Dashboard |
| imagePullSecrets | list | `[]` | Set image pull secrets |
| env.TZ | string | `"America/Chicago"` | Set the timezone that will be used by the container |
| service.main.enabled | bool | `true` | Enables or disables the service |
| service.main.type | string | `"ClusterIP"` | Set the service type |
| service.main.externalTrafficPolicy | string | `nil` | [[ref](https://kubernetes.io/docs/tutorials/services/source-ip/)] |
| service.main.annotations | object | `{}` | Provide additional annotations which may be required. |
| service.main.labels | object | `{}` | Provide additional labels which may be required. |
| service.main.ports.http.port | int | `8080` | The port number |
| service.main.ports.http.protocol | string | `"HTTP"` | Port protocol. |
| service.main.ports.http.nodePort | int | `8080` | Specify the nodePort value for the LoadBalancer and NodePort service types. [[ref]](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport) |
| persistence.config | object | See below | Persistence for application configuration |
| persistence.config.enabled | bool | `true` | Enables or disables the persistence item |
| persistence.config.type | string | `"secret"` | Sets the persistence type Valid options are pvc, emptyDir, hostPath, secret, configMap or custom |
| persistence.config.name | string | `"blackhole-manager-config"` | The name of the secret to utilize. This may need to be changed based upon the release name specified when installing with helm. |
| persistence.config.mountPath | string | `"/deployments/config"` | The folder the config will be mounted too in the container. |
| persistence.config.readOnly | bool | `true` | Specify if the volume should be mounted read-only. |
| persistence.config.items | list | `[{"key":"application.yaml","path":"application.yaml"}]` | The name of the key in the secret containing the config file contents as well as the file name it will be created as in the container under the path specified above. This should not be changed. |
| persistence.media | object | See below | Persistence for media files. |
| persistence.media.enabled | bool | `true` | Enables or disables the persistence item |
| persistence.media.storageClass | string | `nil` | Storage Class for the config volume. If set to `-`, dynamic provisioning is disabled. If set to something else, the given storageClass is used. If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. |
| persistence.media.existingClaim | string | `nil` | If you want to reuse an existing claim, the name of the existing PVC can be passed here. |
| persistence.media.mountPath | string | `"/deployments/data"` | The folder the media will be mounted too in the container. |
| persistence.media.accessMode | string | `"ReadWriteOnce"` | AccessMode for the persistent volume. Make sure to select an access mode that is supported by your storage provider! [[ref]](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) |
| persistence.media.size | string | `"1Ti"` | The amount of storage that is requested for the persistent volume. |
| persistence.media.retain | bool | `true` | Set to true to retain the PVC upon `helm uninstall` |
| resources.requests.cpu | string | `"100m"` | CPU Request amount |
| resources.requests.memory | string | `"512Mi"` |  |
| resources.limits.cpu | string | `"500m"` | CPU Limit amount |
| resources.limits.memory | string | `"1Gi"` | Memory Limit amount |
| serviceMonitor | object | See below | Configure the ServiceMonitors for the chart here. Additional ServiceMonitors can be added by adding a dictionary key similar to the 'main' ServiceMonitors. |
| serviceMonitor.main.enabled | bool | `false` | Enables or disables the serviceMonitor. |
| serviceMonitor.main.nameOverride | string | `nil` | Override the name suffix that is used for this serviceMonitor. |
| serviceMonitor.main.annotations | object | `{}` | Provide additional annotations which may be required. |
| serviceMonitor.main.labels | object | `{}` | Provide additional labels which may be required. |
| serviceMonitor.main.selector | object | `{}` | Configures a custom selector for the serviceMonitor, this takes precedence over specifying a service name. Helm templates can be used. |
| serviceMonitor.main.serviceName | string | `"{{ include \"bjw-s.common.lib.chart.names.fullname\" $ }}"` | Configures the target Service for the serviceMonitor. Helm templates can be used. |
| serviceMonitor.main.endpoints | list | See values.yaml | Configures the endpoints for the serviceMonitor. |
| secrets.config.enabled | bool | `true` |  |
| secrets.config.stringData."application.yaml" | string | `"############################\n### Application Settings ###\n############################\nApplicationSettings:\n  # Level at of which the application will start displaying logging information.\n  # Valid logging levels are as follows, in order from the most output to the least output:\n  #  - ALL\n  #  - TRACE\n  #  - DEBUG\n  #  - INFO\n  #  - WARN\n  #  - ERROR\n  #  - FATAL\n  #  - OFF\n  logLevel: INFO\n\n  # Private API key for real-debrid which is where the movies get downloaded from\n  # In order to get an API key, you will need to register an account at https://real-debrid.com\n  # and purchase a premium offer. Generally the 180 day plan is the best deal. Once purchased, go\n  # to https://real-debrid.com/apitoken to retrieve your token. You will need to purchase more time\n  # before your plan expires otherwise the bot will not function.\n  realDebridKey: somerandomeapikeygoeshereotherwiseitwontwork\n\n\n#########################\n### Database Settings ###\n#########################\nDatabaseSettings:\n  # Enable or disable the external database. This provides the ability for the application\n  # to keep a history of its work. Disabling this will enable the built-in, in-memory database.\n  enabled: true\n\n  # The IP or URL of the server hosting the application's database.\n  address: localhost\n\n  # The database server port.\n  port: 3306\n\n  # The name of the database the bot should use\n  name: blackhole-manager\n\n  # The username the bot will use to access the database\n  username: blackhole-manager\n\n  # The password the bot will use to access the database\n  password: ChangeMe*1234\n\n  # Enable or disable the ability for the application to automatically apply\n  # database migrations to the database upon startup. This is recommended to be\n  # set to true in order to prevent issues with updates. This is only used if an\n  # external database is enabled and specified.\n  enableMigrations: true\n\n\n######################\n### Aria2 Settings ###\n######################\nAriaSettings:\n  # The protocol (http/https), IP/DNS address, and port number of the Aria2 server.\n  # Example address: http://127.0.0.1:8080/jsonrpc\n  address: \"http://127.0.0.1:8080/jsonrpc\"\n\n  # The access token used in the JSONRPC requests.\n  accessToken: \"\"\n\n  # The path to the folder Aria2 is configured to download files into as mounted on the machine\n  # running the blackhole-manager application if it is not the same machine as aria2 is running on.\n  downloadFolder: /path/to/aria2/downloads\n\n  # The path to the aria download folder as it appears to aria. If this is on a different system\n  # than the one running the blackhole-manager this should be the file path on that remote system.\n  remoteDownloadFolder: /aria2/data\n\n\n#######################\n### Radarr Settings ###\n#######################\nRadarrSettings:\n  # The path to the folder Radarr is configured to use as a black hole\n  # for torrent and magnet files that it finds.\n  sourceFolder: /path/to/radarr/sources\n\n  # The path to the folder where files that this application is prepping to be moved to\n  # the completed folder for Radarr to process are stored.\n  tempFolder: /path/to/radarr/temp\n\n  # The path to the folder Radarr is configured to watch for completed downloads.\n  completedFolder: /path/to/radarr/completed\n\n  # The protocol (http/https), IP/DNS address, and port number of the Radarr server.\n  # Example address: http://127.0.0.1:7878\n  address: http://127.0.0.1:7878\n\n  # The API key used to access the Radarr API\n  apiKey: \"\"\n\n\n#######################\n### Sonarr Settings ###\n#######################\nSonarrSettings:\n  # The path to the folder Sonarr is configured to use as a black hole\n  # for torrent and magnet files that it finds.\n  sourceFolder: /path/to/sonarr/sources\n\n  # The path to the folder where files that this application is prepping to be moved to\n  # the completed folder for Sonarr to process are stored.\n  tempFolder: /path/to/sonarr/temp\n\n  # The path to the folder Sonarr is configured to watch for completed downloads.\n  completedFolder: /path/to/sonarr/completed\n\n  # The protocol (http/https), IP/DNS address, and port number of the Sonarr server.\n  # Example address: http://127.0.0.1:8989\n  address: http://127.0.0.1:8989\n\n  # The API key used to access the Sonarr API\n  apiKey: \"\"\n\n\n################################\n### Manual Download Settings ###\n################################\nManualDownloadSettings:\n  # The path to the folder where you will put torrent or magnet file, or link files\n  # A link file is a text file that ends with .link and has one link to download a file per line\n  sourceFolder: /path/to/manual/sources\n\n  # The path to the folder where the completed downloads will be placed. Note that\n  # files downloaded using this method will need to be manually moved to the proper completed folder.\n  completedFolder: /path/to/manual/completed"` | Configure the application.yaml file contents. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.3](https://github.com/norwoodj/helm-docs/releases/v1.11.3)
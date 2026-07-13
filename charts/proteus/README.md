# Proteus Helm Chart

Proteus is a home automation and monitoring service. This Helm chart deploys Proteus on a Kubernetes cluster.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+

### Secret Configuration

The chart requires a secret containing credentials for various services. By default, it expects a secret with the same name as the release, or you can specify one using `secretName`.

The following keys are expected in the secret:

| Key | Description |
| --- | --- |
| `PROTEUS_CLIMATE_CONTROLLER_SLACK_APPTOKEN` | Slack App token |
| `PROTEUS_CLIMATE_CONTROLLER_SLACK_TOKEN` | Slack token |
| `PROTEUS_COMPONENTS_SOLAREDGE_KEY` | SolarEdge site key |
| `PROTEUS_COMPONENTS_TADO_PASSPHRASE` | Tadoº token encryption passphrase |
| `PROTEUS_SOLAR_STORE_DB` | Postgres connection string (e.g., `postgres://user:password@postgres:5432/database?sslmode=disable`) |

## Installation

```bash
helm install my-proteus charts/proteus
```

## Configuration

The following table lists the configurable parameters of the Proteus chart and their default values.

| Parameter | Description | Default |
| --- | --- | --- |
| `nameOverride` | String to partially override proteus.fullname | `""` |
| `fullnameOverride` | String to fully override proteus.fullname | `""` |
| `image.repository` | Image repository | `codeberg.org/clambin/proteus` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `image.tag` | Image tag (overrides Chart.appVersion) | `""` |
| `secretName` | Name of the secret containing credentials | `""` |
| `dashboards.install` | Install Grafana dashboards | `true` |
| `persistence.enabled` | Enable persistence | `false` |
| `persistence.claimName` | Name of the PVC | `proteus-data` |
| `ingress.enabled` | Enable Ingress (HTTPRoute) | `false` |
| `ingress.hostname` | Ingress hostname | `""` |
| `ingress.gateway.name` | Gateway name | `traefik-gateway` |
| `ingress.gateway.namespace` | Gateway namespace | `traefik` |
| `rules.configMap` | ConfigMap name for heating rules | `proteus-heating-rules` |
| `rules.secret` | Secret name for heating rules | `""` |
| `server.args` | Arguments for the server container | `["--config=/etc/proteus/config.yaml"]` |
| `server.resources` | Resource limits and requests for server | `{}` |
| `server.nodeSelector` | Node selector for server pods | `{}` |
| `server.startupProbe` | Startup probe configuration for server | `{"failureThreshold": 6, "initialDelaySeconds": 5, "periodSeconds": 10}` |
| `server.livenessProbe` | Liveness probe configuration for server | `{"failureThreshold": 6, "periodSeconds": 10}` |
| `solarweb.enabled` | Enable SolarWeb component | `true` |
| `solarweb.args` | Arguments for the solarweb container | `["--db=$(PROTEUS_SOLAR_STORE_DB)"]` |
| `solarweb.ports.web` | Port for SolarWeb web interface | `":8080"` |
| `solarweb.ports.health` | Port for SolarWeb health checks | `":8888"` |
| `solarweb.ports.prometheus` | Port for SolarWeb Prometheus metrics | `":9100"` |
| `solarweb.resources` | Resource requests for solarweb | `{}` |
| `solarweb.nodeSelector` | Node selector for solarweb pods | `{}` |
| `solarweb.startupProbe` | Startup probe configuration for solarweb | `{"failureThreshold": 6, "initialDelaySeconds": 5, "periodSeconds": 10}` |
| `solarweb.livenessProbe` | Liveness probe configuration for solarweb | `{"failureThreshold": 6, "periodSeconds": 10}` |
| `config.log.level` | Log level | `info` |
| `config.log.format` | Log format (json/text) | `json` |
| `config.prometheus.addr` | Prometheus metrics address | `":9100"` |
| `config.prometheus.path` | Prometheus metrics path | `/metrics` |
| `config.health.addr` | Health check address | `":8888"` |
| `config.health.path` | Health check path | `/healthz` |
| `config.grid.enabled` | Enable grid monitoring | `true` |
| `config.grid.type` | Grid monitoring type (e.g., homewizard) | `homewizard` |
| `config.grid.interval` | Grid monitoring interval | `30s` |
| `config.battery.enabled` | Enable battery monitoring | `true` |
| `config.battery.type` | Battery monitoring type (e.g., sigenergy) | `sigenergy` |
| `config.battery.interval` | Battery monitoring interval | `30s` |
| `config.solar.enabled` | Enable solar monitoring | `true` |
| `config.solar.type` | Solar monitoring type (e.g., solaredge) | `solaredge` |
| `config.solar.interval` | Solar monitoring interval | `1m` |
| `config.solar.store.enabled` | Enable solar data storage | `true` |
| `config.solar.store.db` | Postgres connection string for solar store | `postgres://user:password@postgres:5432/database?sslmode=disable` |
| `config.solar.store.interval` | Solar store interval | `15m` |
| `config.climate.enabled` | Enable climate monitoring | `true` |
| `config.climate.type` | Climate monitoring type (e.g., tado) | `tado` |
| `config.climate.interval` | Climate monitoring interval | `1m` |
| `config.climate.controller.enabled` | Enable climate controller | `true` |
| `config.climate.controller.rules` | Path to climate controller rules | `/etc/proteus/heating/rules.yaml` |
| `config.watchdog.enabled` | Enable watchdog | `false` |
| `config.components.homewizard.addr` | HomeWizard address | `""` |
| `config.components.sigenergy.addr` | Sigenergy address | `""` |
| `config.components.solaredge.key` | SolarEdge site key | `""` |
| `config.components.tado.storage` | Tado storage path | `/data` |
| `config.components.tado.passphrase` | Tado encryption passphrase | `""` |

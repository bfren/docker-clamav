# ClamAV

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-clamav) ![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fclamav) ![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fclamav) ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/bfren/docker-clamav/dev.yml?branch=main)

[Docker Hub](https://hub.docker.com/r/bfren/clamav) - [Quay.io](https://quay.io/repository/bfren/clamav) - [bfren ecosystem](https://github.com/bfren/docker)

## Introduction

[ClamAV](https://www.clamav.net) virus scanner, running as a daemon (`clamd`) that other containers send files to for scanning. It is built on [Alpine + S6](https://github.com/bfren/docker-alpine-s6), with ClamAV from Alpine's packages - each ClamAV version uses the newest Alpine release that has it.

The virus database is included in published images, so the scanner is ready quickly, and `freshclam` keeps it up to date while the container runs.

## Quickstart

```yaml
services:
  clamav:
    image: quay.io/bfren/clamav:clamav1.4-5.1
    restart: unless-stopped

  app:
    image: your/app
    environment:
      - CLAMAV_HOST=clamav
      - CLAMAV_PORT=3310
```

Run `docker compose up -d` - your app connects to `clamav:3310` using the clamd protocol (most languages have a client library). To check it is working:

```sh
docker compose exec clamav sh -c 'echo PING | nc localhost 3310'   # PONG
```

## Features

* 🦠 ClamAV 1.2 or 1.4 - choose with the image tag
* 📡 `clamd` listening on TCP port 3310 and a local socket
* 🔄 Virus database updated 12 times a day (you choose), and `clamd` reloads it automatically
* 📦 Database included in published images, so start-up is quick
* 🩺 Health check that pings `clamd`
* 🧪 Built-in tests

## Tags

Images are published to Docker Hub (`bfren/clamav`) and Quay.io (`quay.io/bfren/clamav`) for `linux/amd64`, `linux/arm/v7` and `linux/arm64`.

| Tag                            | Example            | Use when                                       |
| ------------------------------ | ------------------ | ---------------------------------------------- |
| `clamavX.Y`                    | `clamav1.4`        | You want the latest image for a ClamAV version |
| `clamavX.Y-MAJOR`              | `clamav1.4-5`      | You want updates, but not breaking changes     |
| `clamavX.Y-MINOR`              | `clamav1.4-5.1`    | You want fixes only - **recommended**          |
| `clamavX.Y-VERSION`            | `clamav1.4-5.1.15` | You want to pin this image exactly             |
| `clamavX.Y.Z`                  | `clamav1.4.6`      | You want an exact ClamAV release               |
| `latest`, `5`, `5.1`, `5.1.15` |                    | As above, on ClamAV 1.4                        |

| ClamAV | Release | Alpine | Support                                   |
| ------ | ------- | ------ | ----------------------------------------- |
| 1.4    | 1.4.6   | 3.24   | LTS - supported until 2027-08-15          |
| 1.2    | 1.2.2   | 3.20   | ended 2024-12-15 - updates may be blocked |

Use 1.4. ClamAV blocks versions it no longer supports from downloading virus database updates, and 1.2 may be blocked at any time. Images for older versions (0.104, 0.105 and 1.1) are no longer built. A scanner with an old database misses new threats. See ClamAV's [end-of-life policy](https://docs.clamav.net/faq/faq-eol.html).

## Configuration

### Ports

| Port   | Purpose                                   |
| ------ | ----------------------------------------- |
| `3310` | `clamd` - only needed by other containers |

### Environment Variables

| Variable                  | Values  | Description                                          | Default |
| ------------------------- | ------- | ---------------------------------------------------- | ------- |
| `BF_CLAMAV_FRESH_PER_DAY` | 1 to 50 | How many times a day `freshclam` checks for updates. | `12`    |

See [Alpine + S6](https://github.com/bfren/docker-alpine-s6#environment-variables) for `BF_DEBUG`, `BF_TZ` and the other base image variables.

## How It Works

On every start:

1. `clamd.conf` and `freshclam.conf` are generated in `/etc/clamav`.
2. If there is no virus database in `/var/lib/clamav` (e.g. in an image you built yourself), it is downloaded.
3. `clamd` runs under S6, listening on TCP port 3310 and on `/run/clamav/clamd.sock`. The container stops if it crashes.
4. `freshclam` runs under S6, checking for updates `BF_CLAMAV_FRESH_PER_DAY` times a day and telling `clamd` to reload after each update. If it stops, S6 starts it again.

Both log to `docker logs`.

The health check (every 30 seconds) sends `PING` to port 3310 and expects `PONG`.

## Testing

```sh
./test.nu                   # builds ClamAV 1.4 and runs /test
./test.nu 1.2               # or any version directory
./test.nu --all             # every version, in parallel
./run.sh 1.4                # builds and opens a shell
./generate-dockerfiles.sh   # regenerates the Dockerfiles from Dockerfile.esh
```

`/test` runs this image's tests alongside the base images' tests: the generated configuration files, finding the database, the `freshclam` schedule (and its limits), the services and start-up order, and the installed ClamAV version.

## Troubleshooting

### The container takes a long time to start

The virus database is being downloaded - a few hundred MB. Published images include it, so this only happens with images you build yourself (unless you set `BF_PUBLISHING=1` when building).

### `freshclam` reports it is blocked, or the database is out of date

Your ClamAV version is no longer supported. Change to `clamav1.4`.

### The container is unhealthy

`clamd` isn't answering on port 3310 - it may still be loading the database, which can take a minute or more on small machines and uses over 1GB of memory.

## FAQs

### Should I keep the database in a volume?

There's no need - published images include it, and `freshclam` brings it up to date within minutes of starting.

## Licence

> [MIT](https://mit.bfren.dev/2020)

## Copyright

> Copyright (c) 2020-2026 [bfren](https://bfren.dev) (unless otherwise stated)

# Docker ClamAV

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-clamav) ![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fclamav) ![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fclamav)<br/>
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-clamav/dev-0_103?label=ClamAV+0.103) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-clamav/dev-0_104?label=ClamAV+0.104)

[Docker Repository](https://hub.docker.com/r/bfren/clamav) - [bfren ecosystem](https://github.com/bfren/docker)

ClamAV installed in daemon mode. Database updates handled automatically.

## Contents

* [Ports](#ports)
* [Environment Variables](#environment-variables)
* [Licence / Copyright](#licence)

## Ports

* 3310

## Environment Variables

| Variable               | Values  | Description                                                           | Default |
| ---------------------- | ------- | --------------------------------------------------------------------- | ------- |
| `CLAMAV_FRESH_PER_DAY` | integer | The number of times per day freshclam will run to update definitions. | 12      |

## Licence

> [MIT](https://mit.bfren.dev/2020)

## Copyright

> Copyright (c) 2020-2022 [bfren](https://bfren.dev) (unless otherwise stated)

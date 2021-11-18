# Docker ClamAV

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-clamav) ![Docker Pulls](https://img.shields.io/docker/pulls/bfren/clamav?label=pulls) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/clamav/latest?label=size)<br/>
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-clamav/dev?label=build)

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

> Copyright (c) 2021 [bfren](https://bfren.dev) (unless otherwise stated)

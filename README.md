# Docker ClamAV

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-clamav) ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/clamav?label=pulls) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/clamav/latest?label=size)<br/>
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-clamav/dev?label=build)

[Docker Repository](https://hub.docker.com/r/bcgdesign/clamav) - [bcg|design ecosystem](https://github.com/bencgreen/docker)

ClamAV installed in daemon mode. Database updates handled automatically.

## Contents

* [Ports](#ports)
* [Environment Variables](#environment-variables)
* [Authors / Licence / Copyright](#authors)

## Ports

* 3310

## Environment Variables

| Variable               | Values  | Description                                                           | Default |
| ---------------------- | ------- | --------------------------------------------------------------------- | ------- |
| `CLAMAV_FRESH_PER_DAY` | integer | The number of times per day freshclam will run to update definitions. | 12      |

## Authors

* [Ben Green](https://github.com/bencgreen)

## License

> [MIT](https://mit.bcgdesign.com/2020)

## Copyright

> Copyright (c) 2021 Ben Green <https://bcgdesign.com>
> Unless otherwise stated

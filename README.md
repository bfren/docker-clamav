# Docker ClamAV

![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/bcgdesign/clamav/latest) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-clamav/build?label=github) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/clamav?label=docker) ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/clamav?label=pulls) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/clamav/latest?label=size)

[Docker Repository](https://hub.docker.com/r/bcgdesign/clamav) - [bcg|design ecosystem](https://github.com/bencgreen/docker)

ClamAV installed in daemon mode. Database updates handled automatically.

## Ports

* 3310

## Environment Variables

| Variable            | Values  | Description                                                           | Default |
| ------------------- | ------- | --------------------------------------------------------------------- | ------- |
| `FRESHCLAM_PER_DAY` | integer | The number of times per day freshclam will run to update definitions. | 12      |

## Authors

* [Ben Green](https://github.com/bencgreen)

## License

> MIT

## Copyright

> Copyright (c) 2021 Ben Green <https://bcgdesign.com>  
> Unless otherwise stated

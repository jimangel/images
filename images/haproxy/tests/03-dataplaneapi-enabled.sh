#!/usr/bin/env bash

set -o errexit -o nounset -o errtrace -o pipefail -x

IMAGE_DIR="$(basename "$(cd "$(dirname ${BASH_SOURCE[0]})/.." && pwd )")"
IMAGE_NAME=${IMAGE_NAME:-"cgr.dev/chainguard/${IMAGE_DIR}:latest"}

docker run -it --rm -d --name my-running-haproxy --expose 5555 -v "$(pwd)/configs/dataplaneapi-enabled:/usr/local/etc/haproxy:rw" "${IMAGE_NAME}" -c -f /usr/local/etc/haproxy/haproxy.cfg
#!/usr/bin/env bash

set -o errexit -o nounset -o errtrace -o pipefail -x

IMAGE_DIR="$(basename "$(cd "$(dirname ${BASH_SOURCE[0]})/.." && pwd )")"
IMAGE_NAME=${IMAGE_NAME:-"cgr.dev/chainguard/${IMAGE_DIR}:latest"}

docker run -it --rm -v "$(pwd)/configs/default:/etc/haproxy" --name haproxy-syntax-check "${IMAGE_NAME}" -c -f /etc/haproxy/haproxy.cfg

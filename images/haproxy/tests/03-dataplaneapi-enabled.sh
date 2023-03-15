#!/usr/bin/env bash

set -o errexit -o nounset -o errtrace -o pipefail -x

IMAGE_DIR="$(basename "$(cd "$(dirname ${BASH_SOURCE[0]})/.." && pwd )")"
IMAGE_NAME=${IMAGE_NAME:-"cgr.dev/chainguard/${IMAGE_DIR}:latest"}

docker run -it --rm --name test-haproxy-config --expose 5555 -v "$(pwd)/configs/dataplaneapi-enabled:/etc/haproxy:rw" "${IMAGE_NAME}" -c -f /etc/haproxy/haproxy.cfg
docker run -d --name my-running-haproxy --expose 5555 -p 8080:5555 -v "$(pwd)/configs/dataplaneapi-enabled:/etc/haproxy:rw" "${IMAGE_NAME}" -f /etc/haproxy/haproxy.cfg
curl -u admin:test123 -H "Content-Type: application/json" "http://127.0.0.1:8080/v2/"
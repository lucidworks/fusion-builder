#!/bin/bash
set -exuo pipefail
if [[ -z "${USE_CACHE:-}" ]]; then
  CACHE_ARG=--no-cache
else
  CACHE_ARG=""
fi
docker build $CACHE_ARG -t lucidworks/fusion-builder:openjdk-10 .

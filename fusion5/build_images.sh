#!/bin/bash

BUILD_TAG=${BUILD_TAG:-latest}

versions=(
  gradle-jdk11-docker-builder
  gradle-jdk8-docker-builder
)

BASE_REPO="fusion-dev-docker.ci-artifactory.lucidworks.com"

for version in ${versions[@]}; do
  IMAGE_NAME="${BASE_REPO}/${version}:${BUILD_TAG}"
  echo "Building Image ${IMAGE_NAME}"
  pushd "${version}"
  docker build -t ${IMAGE_NAME} .
  docker push "${IMAGE_NAME}"
  popd
done


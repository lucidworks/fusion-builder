#!/bin/bash
set -euo pipefail
set -x

git log --oneline --no-abbrev -n 1

NOW=$(date '+%Y%m%d%H%M%S')
echo "Building with timestamp $NOW"

if [[ ! -z "${HUB_USERNAME:-}" && ! -z "${HUB_PASSWORD:-}" ]]; then
  docker login --username "$HUB_USERNAME" --password "$HUB_PASSWORD"
  DO_PUSH=1
fi

CREATED=()

function build_and_push {
  local d=$1
  local IMAGE_NAME="lucidworks/builder:$d-$NOW"
  cat >"$d/build.info" <<EOM
IMAGE=$IMAGE_NAME
GIT_COMMIT=${GIT_COMMIT:-}
EOM
  (cd "$d"; docker build -t "$IMAGE_NAME" .)
  latest_tag=$(sed "s/-$NOW/-latest/" <<< $IMAGE_NAME)
  docker tag "$IMAGE_NAME" "$latest_tag"
  CREATED+=("$IMAGE_NAME")
  if [[ ! -z "${DO_PUSH:-}" ]]; then
    docker push "$IMAGE_NAME"
    docker push "lucidworks/fusion-builder-$d:latest"
  fi
}

DIRS="$(find . -mindepth 1 -maxdepth 1 -type d | sed -e 's,^\./,,' | egrep -v '^\.')"
for d in $DIRS; do
  build_and_push "$d"
done

echo "Built all images:"
: > report.txt
for image in "${CREATED[@]}"; do
  docker image list --format "{{.ID}} {{.Repository}}:{{.Tag}}" "$image" >> report.txt
done

cat >> report.txt <<EOM

To use:

    docker login --username lucidworkstest --password XXX
    docker pull lucidworks/fusion-builder-openjdk-8:$NOW
EOM


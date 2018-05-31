#!/bin/bash
set -e
for d in openjdk-7 openjdk-8; do
 (cd $d; touch build.info; ./build.sh)
done

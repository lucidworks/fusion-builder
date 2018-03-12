#!/bin/bash
set -e
for d in openjdk-7 openjdk-8 openjdk-9; do
 (cd $d; touch build.info; ./build.sh)
done

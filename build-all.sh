#!/bin/bash
set -e
for d in openjdk-10 openjdk-8 openjdk-7; do
 (cd $d; touch build.info; ./build.sh)
done

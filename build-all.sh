#!/bin/bash
set -e
for d in openjdk-7 openjdk-8 oracle-jdk-7; do
 (cd $d; ./build.sh)
done

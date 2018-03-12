#!/bin/bash
sed -e 's,FROM_GOES_HERE,java:openjdk-7,' templates/Dockerfile > openjdk-7/Dockerfile
sed -e 's,FROM_GOES_HERE,java:openjdk-8,' templates/Dockerfile > openjdk-8/Dockerfile
sed -e 's,FROM_GOES_HERE,java:openjdk-9,' templates/Dockerfile > openjdk-9/Dockerfile
sed -e 's,FROM_GOES_HERE,makuk66/docker-oracle-java7,' templates/Dockerfile > oracle-jdk-7/Dockerfile
for d in openjdk-7 openjdk-8 openjdk-9; do
  cp templates/requirements.txt templates/pyenv.sh $d/
done

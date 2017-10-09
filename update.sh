#!/bin/bash
sed -e 's,FROM_GOES_HERE,java:openjdk-7,' -e 's, openjfx,,' Dockerfile.template > openjdk-7/Dockerfile
sed -e 's,FROM_GOES_HERE,java:openjdk-8,' Dockerfile.template > openjdk-8/Dockerfile
sed -e 's,FROM_GOES_HERE,java:openjdk-9,' Dockerfile.template > openjdk-9/Dockerfile
sed -e 's,FROM_GOES_HERE,makuk66/docker-oracle-java7,' -e 's, openjfx,,' Dockerfile.template > oracle-jdk-7/Dockerfile
for d in openjdk-7 openjdk-8 oracle-jdk-7; do
  cp requirements.txt.template $d/requirements.txt
done

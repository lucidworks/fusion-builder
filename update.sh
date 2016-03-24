#!/bin/bash
sed -e 's,FROM_GOES_HERE,java:openjdk-7,' Dockerfile.template > openjdk-7/Dockerfile
sed -e 's,FROM_GOES_HERE,java:openjdk-8u66,' Dockerfile.template > openjdk-8/Dockerfile
sed -e 's,FROM_GOES_HERE,makuk66/docker-oracle-java7,' Dockerfile.template > oracle-jdk-7/Dockerfile

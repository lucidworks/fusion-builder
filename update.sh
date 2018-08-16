#!/bin/bash
sed -e 's,FROM_GOES_HERE,openjdk:7-jdk,' templates/Dockerfile > openjdk-7/Dockerfile
sed -e 's,FROM_GOES_HERE,openjdk:8-jdk,' templates/Dockerfile > openjdk-8/Dockerfile
sed -e 's,FROM_GOES_HERE,openjdk:10-jdk,' templates/Dockerfile > openjdk-10/Dockerfile
sed -e 's,FROM_GOES_HERE,openjdk:11-ea-jdk,' templates/Dockerfile > openjdk-11/Dockerfile
for d in openjdk-11 openjdk-10 openjdk-8 openjdk-7; do
  cp templates/requirements.txt templates/pyenv.sh templates/bash_profile templates/bashrc templates/fusion_builder_profile $d/
done

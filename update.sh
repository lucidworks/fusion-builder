#!/bin/bash
sed -e 's,FROM_GOES_HERE,java:openjdk-7,' templates/Dockerfile > openjdk-7/Dockerfile
sed -e 's,FROM_GOES_HERE,java:openjdk-8,' templates/Dockerfile > openjdk-8/Dockerfile
sed -e 's,FROM_GOES_HERE,java:openjdk-9,' templates/Dockerfile > openjdk-9/Dockerfile
for d in openjdk-7 openjdk-8 openjdk-9; do
  cp templates/requirements.txt templates/pyenv.sh templates/bash_profile templates/bashrc templates/fusion_builder_profile $d/
done

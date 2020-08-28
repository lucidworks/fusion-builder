FROM gradle:6.6.1-jdk11

USER root
RUN apt-get update && \
apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
apt-get update && \
apt-get install -y docker-ce && \
apt-get clean && \
groupadd jenkins -g 7000 && \
useradd jenkins -d /home/jenkins -m -u 7000 -g docker -G docker -s /bin/bash

USER gradle

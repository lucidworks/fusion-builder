FROM python:3.7.7-slim-buster

USER root
RUN apt-get update && \
apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common python-pip build-essential automake1.11 autoconf libtool isort flake8 black && \
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
apt-get update && \
apt-get install -y docker-ce && \
apt-get clean && \
groupadd jenkins -g 7000 && \
useradd jenkins -d /home/jenkins -m -u 7000 -g docker -G docker -s /bin/bash

COPY ./ai-builder-deps.sh .
RUN ./ai-builder-deps.sh && \
rm ai-builder-deps.sh

USER jenkins

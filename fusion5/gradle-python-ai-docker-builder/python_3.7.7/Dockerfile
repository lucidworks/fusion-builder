FROM python:3.7.7-slim-buster

USER root
RUN apt-get update && \
apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
apt-get update && \
apt-get install -y docker-ce && \
apt-get clean && \
groupadd jenkins -g 7000 && \
useradd jenkins -d /home/jenkins -m -u 7000 -g docker -G docker -s /bin/bash

RUN echo "fusion ALL = NOPASSWD: /usr/bin/make, /usr/bin/automake,  /usr/bin/automake-1.11, /sbin/ldconfig" >> /etc/sudoers
USER jenkins

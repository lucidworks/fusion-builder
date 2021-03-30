FROM gradle:5.6.1-jdk8

USER root
RUN apt-get update && \
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release  && \
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" |  tee /etc/apt/sources.list.d/docker.list > /dev/null && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
apt-get update && \
apt-get install -y docker-ce docker-ce docker-ce-cli containerd.io && \
apt-get clean && \
groupadd jenkins -g 7000 && \
useradd jenkins -d /home/jenkins -m -u 7000 -g docker -G docker -s /bin/bash

USER gradle

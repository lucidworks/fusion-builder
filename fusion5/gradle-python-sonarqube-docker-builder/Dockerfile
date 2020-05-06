FROM python:3

ENV SONAR_SCANNER_HOME="/opt/sonar-scanner" \
    SONAR_SCANNER_VERSION="4.2.0.1873" \
    PATH=${SONAR_SCANNER_HOME}/bin:${PATH}

USER root

RUN apt-get update && \
apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common pylint unzip wget && \
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
apt-get update && \
apt-get install -y docker-ce nodejs npm  && \
apt-get clean && \
groupadd jenkins -g 7000 && \
useradd jenkins -d /home/jenkins -m -u 7000 -g docker -G docker -s /bin/bash

WORKDIR /opt
RUN wget -U "scannercli" -O /opt/sonar-scanner-cli.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    unzip sonar-scanner-cli.zip && \
    rm sonar-scanner-cli.zip && \
    mv sonar-scanner-${SONAR_SCANNER_VERSION}-linux ${SONAR_SCANNER_HOME} && \
    cp -R ${SONAR_SCANNER_HOME}/bin/ /usr/bin/ && \
    chown jenkins:jenkins /usr/bin/


USER jenkins

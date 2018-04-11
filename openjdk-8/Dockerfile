# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node,
# plus dependencies for our build and some python tools we use for testing.
# Note the plaintext password here; depending on your environment that may not be advisable.
# Based on evarga/jenkins-slave
FROM    java:openjdk-8
MAINTAINER  Martijn Koster "martijn.koster@lucidworks.com"

ARG NEED_OPENJFX=no

# See http://phantomjs.org/download.html
ENV PHANTOMJS_VERSION=2.1.1
# Use the sha256 checksum for the linux-x86_64.tar.bz2
ENV PHANTOMJS_SHA256_CHECKSUM=86dd9a4bf4aee45f1a84c9f61cf1947c1d6dce9b9e8d2a907105da7852460d2f
# Use our copy
ENV PHANTOMJS_URL=https://s3.amazonaws.com/lucidworks-build-dependencies-public/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2

ENV MAVEN_URL=https://archive.apache.org/dist/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz

ENV JENKINS_GID=7000
ENV JENKINS_UID=7000

RUN export DEBIAN_FRONTEND=noninteractive TERM=linux && \
  echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
  apt-get update && \
  apt-get -y install apt-utils && \
  apt-get -y upgrade

RUN if [ "${NEED_OPENJFX}" = "yes" ]; then \
      echo "deb http://ftp.de.debian.org/debian jessie main" >> /etc/apt/sources.list && \
      apt-get update; \
      apt-get -y install openjfx; \
      echo "installed openjfx"; \
      dpkg -l | awk '{if ($2 == "openjfx") print}'; \
    else \
      echo "Not installing OpenJFX"; \
    fi

RUN export DEBIAN_FRONTEND=noninteractive TERM=linux && \
  apt-get -y install ant \
  build-essential libssl-dev libcurl4-openssl-dev libexpat1-dev gettext libz-dev automake autoconf \
  libxml2-dev libxslt1-dev libxmlsec1-dev python-dev python-pip \
  libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-dev libyaml-dev \
  curl netcat-openbsd net-tools procps lsof rpm gnupg gnupg2 expect \
  libmysqlclient-dev libpq-dev libsvn-dev bzip2 libfreetype6 libfontconfig \
  unzip zip less vim smbclient gtk+3.0-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN groupadd --gid $JENKINS_GID jenkins && \
  adduser --quiet --gecos "" --disabled-password --uid $JENKINS_UID --gid $JENKINS_GID jenkins && \
  (echo "jenkins:jenkins" | chpasswd) && \
  mkdir -p /home/jenkins/.ssh && chown -R jenkins:jenkins /home/jenkins/.ssh
RUN pip install virtualenv awscli beautifulsoup4
RUN wget --no-verbose $PHANTOMJS_URL && \
  echo "$PHANTOMJS_SHA256_CHECKSUM phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2" > phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2.sha256 && \
  sha256sum -c phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2.sha256 && \
  rm phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2.sha256 && \
  tar xjC /opt < phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  rm phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  ln -s /opt/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs /usr/local/bin/
RUN export DEBIAN_FRONTEND=noninteractive TERM=linux && \
  wget --no-verbose --output-document=- https://get.docker.com/ | sh && \
  usermod -aG docker jenkins
RUN export DEBIAN_FRONTEND=noninteractive TERM=linux && \
  apt-get -y install locales && \
  sed -i.bak -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
  locale-gen && \
  update-locale LC_ALL="en_US.UTF-8" && \
  export LANGUAGE=en_US:en && \
  export LANG=en_US.UTF-8 && \
  export LC_ALL=en_US.UTF-8 && \
  dpkg-reconfigure locales
# Add maven, for #osdevs
RUN mkdir -p /opt/apache-maven && \
  wget -nv --output-document=/opt/apache-maven.tgz $MAVEN_URL && \
  tar -C /opt/apache-maven --extract --file /opt/apache-maven.tgz --strip-components=1 && \
  ln -s /opt/apache-maven/bin/mvn /usr/local/bin/mvn && \
  rm /opt/apache-maven.tgz
# Add git
RUN echo "deb http://ftp.us.debian.org/debian testing main contrib non-free" >> /etc/apt/sources.list && \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y --reinstall binutils && \
  apt-get install -y git && \
  apt-get clean all && \
  /usr/bin/git --version
ADD requirements.txt /tmp/requirements.txt
ADD pyenv.sh /tmp/pyenv.sh
RUN export DEBIAN_FRONTEND=noninteractive TERM=linux && \
  bash -x /tmp/pyenv.sh

ADD build.info /build.info

ENV LANGUAGE en_US:en
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

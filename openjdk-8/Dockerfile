# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node,
# plus dependencies for our build and some python tools we use for testing.
# Note the plaintext password here; depending on your environment that may not be advisable.
# Based on evarga/jenkins-slave
FROM    java:openjdk-8
MAINTAINER  Martijn Koster "martijn.koster@lucidworks.com"

ENV PHANTOMJS_VERSION=1.9.8
ENV SPARK_VERSION=1.4.1
ENV SPARK_PACKAGE=${SPARK_VERSION}-bin-hadoop2.6
ENV SPARK_BASE=/opt


RUN export DEBIAN_FRONTEND=noninteractive TERM=linux && \
  echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
  apt-get update && \
  apt-get -y install ant git openssh-server \
  build-essential libxml2-dev libxslt1-dev python-dev python-pip \
  libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
  curl netcat-openbsd net-tools procps lsof && \
  sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
  mkdir -p /var/run/sshd && \
  adduser --quiet --gecos "" --disabled-password jenkins && \
  (echo "jenkins:jenkins" | chpasswd)  && \
  mkdir -p /home/jenkins/.ssh && chown -R jenkins:jenkins /home/jenkins/.ssh && \
  apt-get -y install libmysqlclient-dev libpq-dev libsvn-dev && \
  pip install virtualenv && \
  wget --no-verbose https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  apt-get -y install bzip2 libfreetype6 libfontconfig unzip && \
  tar xjC /opt < phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  rm phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  ln -s /opt/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs /usr/local/bin/ && \
  apt-get -y install vim && \
  apt-get -y install smbclient
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
# Download Spark for the python bindings
RUN wget -O ${SPARK_BASE}/spark-${SPARK_PACKAGE}.tgz --no-verbose http://apache.cs.utah.edu/spark/spark-${SPARK_VERSION}/spark-${SPARK_PACKAGE}.tgz && \
  cd ${SPARK_BASE} && \
  tar xzf spark-${SPARK_PACKAGE}.tgz && \
  ln -s /opt/spark-${SPARK_PACKAGE} /opt/spark && \
  chown -R jenkins:jenkins /opt/spark && \
  rm ${SPARK_BASE}/spark-${SPARK_PACKAGE}.tgz
# Add maven, for #osdevs
RUN mkdir -p /opt/apache-maven && \
  wget -nv --output-document=/opt/apache-maven.tgz http://mirror.vorboss.net/apache/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz && \
  tar -C /opt/apache-maven --extract --file /opt/apache-maven.tgz --strip-components=1 && \
  ln -s /opt/apache-maven/bin/mvn /usr/local/bin/mvn

ADD requirements.txt /tmp/requirements.txt
ADD pyenv.sh /tmp/pyenv.sh
RUN export DEBIAN_FRONTEND=noninteractive TERM=linux && \
  bash -x /tmp/pyenv.sh

ENV LANGUAGE en_US:en
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

EXPOSE 22 8764

CMD ["/usr/sbin/sshd", "-D"]

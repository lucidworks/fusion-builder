FROM python:3.7.7-slim-buster

USER root
RUN apt-get update && \
apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common python-pip build-essential automake1.11 autoconf libtool isort flake8 black && \
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
apt-get update && \
apt-get install -y docker-ce && \
apt-get clean && \
pip install gdown && \
groupadd jenkins -g 7000 && \
useradd jenkins -d /home/jenkins -m -u 7000 -g docker -G docker -s /bin/bash

RUN gdown "https://drive.google.com/uc?id=1Rv3k_ztXR1J5ImgaQFv-k5SlV6m-UIhp" -O models_and_files.tar.gz && \
tar xf models_and_files.tar.gz && \
rm models_and_files.tar.gz && \
cd augmentation_deps/spacy_tokenizers && \
tar xf mecab-0.996-ko-0.9.2.tar.gz && \
cd mecab-0.996-ko-0.9.2 && \
./configure && \
make && \
make check && \
make install  && \
cd .. && \
tar zxfv mecab-ko-dic-2.1.1-20180720.tar.gz && \
cd mecab-ko-dic-2.1.1-20180720 && \
./configure && \
ldconfig && \
make && \
make install

USER jenkins

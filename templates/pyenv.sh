#!/bin/bash
#
# install a specific version of python with pyenv

PYTHON_VERSION=2.7.14

cd /home/jenkins
git clone git://github.com/pyenv/pyenv.git .pyenv
(cd .pyenv && git checkout v1.2.2)
git clone https://github.com/pyenv/pyenv-virtualenv.git .pyenv/plugins/pyenv-virtualenv
(cd .pyenv/plugins/pyenv-virtualenv && git checkout v20150526)
export PYENV_ROOT=$(pwd)/.pyenv
export PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION
python --version
pip install --upgrade pip
pip install -r /tmp/requirements.txt
chown -R jenkins:jenkins $(pwd)/.pyenv

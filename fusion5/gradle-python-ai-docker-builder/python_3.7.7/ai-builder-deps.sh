#!/bin/bash
set -x

curl https://ci-artifactory.lucidworks.com:443/artifactory/ai-buiilder-packages/mecab-0.996-ko-0.9.2.tar.gz --output mecab-0.996-ko-0.9.2.tar.gz
tar xf mecab-0.996-ko-0.9.2.tar.gz
(cd mecab-0.996-ko-0.9.2 ; ./configure )
(cd mecab-0.996-ko-0.9.2 ; make)
(cd mecab-0.996-ko-0.9.2 ; make check)
(cd mecab-0.996-ko-0.9.2 ; make install)
rm -rf mecab-0.996-ko-0.9.2
rm mecab-0.996-ko-0.9.2.tar.gz


curl https://ci-artifactory.lucidworks.com:443/artifactory/ai-buiilder-packages/mecab-ko-dic-2.1.1-20180720.tar.gz --output mecab-ko-dic-2.1.1-20180720.tar.gz
tar xf mecab-ko-dic-2.1.1-20180720.tar.gz
(cd mecab-ko-dic-2.1.1-20180720 ; ./configure )
(cd mecab-ko-dic-2.1.1-20180720 ; ldconfig)
(cd mecab-ko-dic-2.1.1-20180720 ; make)
(cd mecab-ko-dic-2.1.1-20180720 ; make install)
rm -rf mecab-ko-dic-2.1.1-20180720
rm mecab-ko-dic-2.1.1-20180720.tar.gz

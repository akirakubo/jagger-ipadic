#!/bin/bash

cd $(dirname $0)
JAGGER_URL="http://www.tkl.iis.u-tokyo.ac.jp/~ynaga/jagger/jagger-latest.tar.gz"

curl -o ../work/jagger-latest.tar.gz $JAGGER_URL

mkdir -p ../work/jagger
tar xvf ../work/jagger-latest.tar.gz --strip-components 1 -C ../work/jagger

patch ../work/jagger/src/train_jagger.cc < ../patch/jagger/train_jagger.cc.patch

cd ../work/jagger
./configure && make

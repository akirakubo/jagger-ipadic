#!/bin/bash

cd $(dirname $0)

IPADIC_FILE=../work/mecab-ipadic-2.7.0-20070801.tar.gz
NEOLOGD_DIR=../work/mecab-ipadic-neologd
NEOLOGD_REPO=https://github.com/neologd/mecab-ipadic-neologd

# clone repository
git clone --depth 1 $NEOLOGD_REPO $NEOLOGD_DIR

# for saving time
if [ -e $IPADIC_FILE ]; then
    mkdir -p $NEOLOGD_DIR/build
    cp $IPADIC_FILE $NEOLOGD_DIR/build/
fi

# install mecab-ipadic-neologd
(
    cd $NEOLOGD_DIR && ./bin/install-mecab-ipadic-neologd -n -y -p $(pwd)
)

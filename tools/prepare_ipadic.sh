#!/bin/bash

cd $(dirname $0)

IPADIC_DIR=../work/mecab-ipadic-2.7.0-20070801

mkdir ../work

curl -fsSL 'https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM' -o ../work/mecab-ipadic-2.7.0-20070801.tar.gz

tar xzvf ../work/mecab-ipadic-2.7.0-20070801.tar.gz -C ../work

nkf -u -o --overwrite $IPADIC_DIR/*.csv
nkf -u -o --overwrite $IPADIC_DIR/*.def
perl -i -pe 's/^config-charset = EUC-JP/config-charset = UTF-8/' $IPADIC_DIR/dicrc

mecab-dict-index -f utf-8 -t utf-8 -d $IPADIC_DIR -o $IPADIC_DIR

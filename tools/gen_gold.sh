#!/bin/bash

cd $(dirname $0)

SPLIT_DIR=../work/split
IPADIC_DIR=../work/mecab-ipadic-2.7.0-20070801
FILES=${1:-15}

rm $SPLIT_DIR/preprocess.train.*.mecab

find $SPLIT_DIR -name 'preprocess.train.*' -print0 | \
tr '\0\n' '\n\0' | \
LC_ALL=C sort | \
shuf --random-source <(yes 42) | \
head -n $FILES | \
tr '\0\n' '\n\0' | \
xargs -0 -P8 -I{} -s 5000 \
bash -c "echo {} && mecab -d $IPADIC_DIR -b500000 -r/dev/null {} >> $SPLIT_DIR/\$(basename {}).mecab"

cat $SPLIT_DIR/preprocess.train.*.mecab > ../work/train.mecab

#!/bin/bash

cd $(dirname $0)

SPLIT_DIR=../work/split
FILES=${1:-30}

rm ../work/train.mecab

find $SPLIT_DIR -name 'preprocess.train.*' -print0 | \
tr '\0\n' '\n\0' | \
LC_ALL=C sort | \
shuf --random-source <(yes 42) | \
head -n $FILES | \
tr '\0\n' '\n\0' | \
xargs -0 -I{} bash -c "echo {} && cat {} >> ../work/train.mecab"

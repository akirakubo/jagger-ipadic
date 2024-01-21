#!/bin/bash
WORK_DIR=$(pwd)
cd $(dirname $0)

if [ -z "$1" ]; then
    MECAB_DIC_DIR=../work/mecab-ipadic-2.7.0-20070801
else
    MECAB_DIC_DIR=${WORK_DIR}/$1
fi

if [ ! -d ${MECAB_DIC_DIR} ]; then
    echo "${MECAB_DIC_DIR} not existed."
    exit 1
fi

MODEL=${2:-../model/jagger-ipadic}
SPLIT_DIR=../work/split
mkdir -p $MODEL
rm $MODEL/patterns*

echo "Training"
train_jagger -d <(cat $MECAB_DIC_DIR/*.csv) ../work/train.mecab > $MODEL/patterns

echo "Evaluation"
cat $SPLIT_DIR/preprocess.test.*.mecab > ../work/preprocess.test.mecab
mecab-test-gen < ../work/preprocess.test.mecab > ../work/preprocess.test.txt
jagger -m $MODEL -f < ../work/preprocess.test.txt > ../work/preprocess.test.jagger
mecab-system-eval -l "0 1 2 3 -1" ../work/preprocess.test.jagger ../work/preprocess.test.mecab | tee $MODEL/RESULT
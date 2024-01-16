#!/bin/bash
cd $(dirname $0)

IPADIC_DIR=${1:-../work/mecab-ipadic-2.7.0-20070801}
MODEL=${2:-../model/jagger-ipadic}
SPLIT_DIR=../work/split
mkdir -p $MODEL
rm $MODEL/patterns*

echo "Training"
train_jagger -d <(cat $IPADIC_DIR/*.csv) ../work/train.mecab > $MODEL/patterns

echo "Evaluation"
cat $SPLIT_DIR/preprocess.test.*.mecab > ../work/preprocess.test.mecab
mecab-test-gen < ../work/preprocess.test.mecab > ../work/preprocess.test.txt
jagger -m $MODEL -f < ../work/preprocess.test.txt > ../work/preprocess.test.jagger
mecab-system-eval -l "0 1 2 3 -1" ../work/preprocess.test.jagger ../work/preprocess.test.mecab | tee $MODEL/RESULT
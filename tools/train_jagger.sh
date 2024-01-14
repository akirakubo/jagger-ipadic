#!/bin/bash
cd $(dirname $0)

IPADIC_DIR=${1:../work/mecab-ipadic-2.7.0-20070801}
MODEL=${2:../model/jagger-ipadic}
mkdir -p $MODEL
rm $MODEL/patterns*

echo "Training"
train_jagger -d <(cat $IPADIC_DIR/*.csv) ../work/train.mecab > $MODEL/patterns

echo "Evaluation"
mecab -r /dev/null -d $IPADIC_DIR -b500000 ../work/test.txt > ../work/test.mecab
jagger -m $MODEL -f < ../work/test.txt > ../work/test.jagger
mecab-system-eval -l "0 1 2 3 -1" ../work/test.jagger ../work/test.mecab | tee > $MODEL/RESULT
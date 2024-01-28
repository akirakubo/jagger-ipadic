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

if [ "$(uname)" == 'Darwin' ]; then
    XARGS="xargs -S 512"
else
    XARGS="xargs"
fi

mkdir -p ../work

echo "Download started"
python3 ./download.py --outdir ../work

echo "Split started"
rm ../work/split/*

mkdir -p ../work/split
rm ../work/split/*

split \
-l 50000 \
../work/test.txt \
../work/split/test.

split \
-l 50000 \
../work/train.txt \
../work/split/train.

split \
-l 50000 \
../work/validation.txt \
../work/split/validation.

echo "Preprocessing started"
find ../work/split -type f -print0 | \
$XARGS -0 -P 8 -I{} \
bash -c "python3 preprocess.py \
--mecab-dict $MECAB_DIC_DIR \
--mecabrc /dev/null \
--remove-unk {} > \$(dirname {})/preprocess.\$(basename {}).mecab"

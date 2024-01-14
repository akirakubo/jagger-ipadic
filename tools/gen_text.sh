#!/bin/bash

cd $(dirname $0)

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
xargs -0 -P 8 -I{} \
bash -c 'python3 preprocess.py {} > $(dirname {})/preprocess.$(basename {})'

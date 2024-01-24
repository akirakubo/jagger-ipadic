# Tools

This directory has tools used for training.

## Setup

```
$ pip install -r requirements.txt
```

nkf, perl, mecab (mecab, mecab-dict-index, mecab-test-gen, mecab-system-eval), and jagger is also required.

## Buiding model

```
# Prepare mecab-ipadic
$ ./prepare_ipadic.sh

# Get data from wiki40b
$ ./get_text.sh

# Create gold data
# Training data is divided into 50k sentences.
# By default, 30 files are randomly choosed and used.
$ ./gen_gold.sh

# You can also change amount of training data.
# Please note that large amount of data takes 
# a lot of memory during train_jagger.
$ ./gen_gold.sh 30

# Train jagger and evaluate
$ ./train_jagger.sh
```

## Building model with mecab-ipadic-neologd

```
# Prepare mecab-ipadic
$ ./prepare_ipadic.sh

# Prepare mecab-ipadic-neologd
$ ./prepare_ipadic_neologd.sh

# Get data from wiki40b
$ ./get_text.sh \
../work/mecab-ipadic-neologd/build/mecab-ipadic-2.7.0-20070801-neologd-20200910

# Create gold data
# Training data is divided into 50k sentences.
# By default, 30 files are randomly choosed and used.
$ ./gen_gold.sh

# You can also change amount of training data.
# Please note that large amount of data takes 
# a lot of memory during train_jagger.
$ ./gen_gold.sh 30

# Train jagger and evaluate
$ ./train_jagger.sh \
../work/mecab-ipadic-neologd/build/mecab-ipadic-2.7.0-20070801-neologd-20200910 \
../model/jagger-ipadic-neologd
```
# Tools

This directory has tools used for training.

## Setup

```
$ pip install -r requirements.txt
```

nkf, perl, mecab (mecab, mecab-dict-index, mecab-system-eval), and jagger is also required.

## Buiding model

```
# Get data from wiki40b
$ ./get_text.sh

# Prepare mecab-ipadic
$ ./prepare_ipadic.sh

# Create gold data
# Training data is divided into 50k sentences.
# By default, 15 files are randomly choosed and used.
$ ./gen_gold.sh

# You can also change amount of training data.
# Please note that large amount of data takes 
# a lot of memory during train_jagger.
$ ./gen_gold.sh 30

# Train jagger and evaluate
$ ./train_jagger.sh
```
# jagger-ipadic

## Usage

You can download the latest model in [Releases](releases/).

### Command Line
```
$ jagger -m ./model/jagger-ipadic
(input: stdin)
吾輩は猫である。名前はまだない。
吾輩 	名詞,代名詞,一般,*,*,*,吾輩,ワガハイ,ワガハイ
は 	助詞,係助詞,*,*,*,*,は,ハ,ワ
猫 	名詞,一般,*,*,*,*,猫,ネコ,ネコ
で 	助動詞,*,*,*,特殊・ダ,連用形,だ,デ,デ
ある 	助動詞,*,*,*,五段・ラ行アル,基本形,ある,アル,アル
。 	記号,句点,*,*,*,*,。,。,。
名前 	名詞,一般,*,*,*,*,名前,ナマエ,ナマエ
は 	助詞,係助詞,*,*,*,*,は,ハ,ワ
まだ 	副詞,助詞類接続,*,*,*,*,まだ,マダ,マダ
ない 	形容詞,自立,*,*,形容詞・アウオ段,基本形,ない,ナイ,ナイ
。 	記号,句点,*,*,*,*,。,。,。
EOS
```

### [jagger-python](https://github.com/lighttransport/jagger-python)

```
import jagger

model_path = "model/jagger-ipadic/patterns"

tokenizer = jagger.Jagger()
tokenizer.load_model(model_path)

text = "吾輩は猫である。名前はまだない。"
toks = tokenizer.tokenize(text)

for tok in toks:
    print(tok.surface(), tok.feature())
print("EOL")

"""
吾輩 	名詞,代名詞,一般,*,*,*,吾輩,ワガハイ,ワガハイ
は 	助詞,係助詞,*,*,*,*,は,ハ,ワ
猫 	名詞,一般,*,*,*,*,猫,ネコ,ネコ
で 	助動詞,*,*,*,特殊・ダ,連用形,だ,デ,デ
ある 	助動詞,*,*,*,五段・ラ行アル,基本形,ある,アル,アル
。 	記号,句点,*,*,*,*,。,。,。
名前 	名詞,一般,*,*,*,*,名前,ナマエ,ナマエ
は 	助詞,係助詞,*,*,*,*,は,ハ,ワ
まだ 	副詞,助詞類接続,*,*,*,*,まだ,マダ,マダ
ない 	形容詞,自立,*,*,形容詞・アウオ段,基本形,ない,ナイ,ナイ
。 	記号,句点,*,*,*,*,。,。,。
EOL
"""
```

## Model Performance

* Dataset: test data of wiki40b (after [pre-processed](tools/preprocess.py) with `--remove-unk`)
* Gold data: output from mecab with mecab-ipadic-2.7.0-20070801 is regarded as gold data
* Predicted data: output from jagger with jagger-ipadic-0.2

```
              precision          recall         F
LEVEL 0:    97.2484(10486265/10782971) 92.9519(10486265/11281387) 95.0516
LEVEL 1:    96.8835(10446916/10782971) 92.6031(10446916/11281387) 94.6949
LEVEL 2:    96.0927(10361647/10782971) 91.8473(10361647/11281387) 93.9220
LEVEL 3:    95.8627(10336849/10782971) 91.6275(10336849/11281387) 93.6973
LEVEL ALL: 95.7733(10327205/10782971) 91.5420(10327205/11281387) 93.6098
```

## How to train your model

See [tools/README.md](tools/README.md).

## License

Same as IPAdic. See [LICENSE](./LICENSE).
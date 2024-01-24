# jagger-ipadic

## Usage

You can download the latest model in [Releases](https://github.com/akirakubo/jagger-ipadic/releases/).

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
* Predicted data: output from jagger with jagger-ipadic-0.3 trained by [patched train_jagger](patch/jagger/README.md)

```
              precision          recall         F
LEVEL 0:    99.5261(11231041/11284522) 99.5537(11231041/11281387) 99.5399
LEVEL 1:    99.1735(11191261/11284522) 99.2011(11191261/11281387) 99.1873
LEVEL 2:    98.4122(11105348/11284522) 98.4396(11105348/11281387) 98.4259
LEVEL 3:    98.1923(11080529/11284522) 98.2196(11080529/11281387) 98.2059
LEVEL ALL: 98.1069(11070900/11284522) 98.1342(11070900/11281387) 98.1206
```

## How to Train Your Model

See [tools/README.md](tools/README.md).

## License

Same as IPAdic. See [LICENSE](./LICENSE).
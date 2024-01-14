# jagger-ipadic

## Usage

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

* Dataset: test data of wiki40b (after [pre-processed](tools/preprocess.py))
* Gold data: output from mecab with mecab-ipadic-2.7.0-20070801 is regarded as gold data
* Predicted data: output from jagger with jagger-ipadic-0.1

```
               precision          recall         F
LEVEL 0:    81.4596(17444598/21415026) 80.6501(17444598/21629967) 81.0529
LEVEL 1:    81.1085(17369413/21415026) 80.3025(17369413/21629967) 80.7035
LEVEL 2:    77.0905(16508950/21415026) 76.3244(16508950/21629967) 76.7056
LEVEL 3:    75.3978(16146450/21415026) 74.6485(16146450/21629967) 75.0213
LEVEL ALL: 75.2949(16124426/21415026) 74.5467(16124426/21629967) 74.9189
```

## How to train your model

See [tools/README.md](tools/README.md).

## License

Same as IPAdic. See [LICENSE](./LICENSE).
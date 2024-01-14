from hojichar import Compose, document_filters
from hojichar.core.filter_interface import Filter
from pathlib import Path
from bunkai import Bunkai
import habachen
import emoji
import unicodedata
import argparse
from tqdm import tqdm

class RemoveEscapeSequence(Filter):
    def __init__(self, *args, **kwargs) -> None:
        super().__init__(*args, **kwargs)
        self.escapes = ''.join([chr(char) for char in list(range(0, 32)) + [127]])
        self.translator = str.maketrans('', '', self.escapes)

    def apply(self, document):
        text = document.text
        document.text = text.translate(self.translator)
        return document

class RemoveEmoji(Filter):
    def __init__(self, *args, **kwargs) -> None:
        super().__init__(*args, **kwargs)

    def apply(self, document):
        text = document.text
        text = emoji.replace_emoji(text)
        document.text = text
        return document

class NormalizeUnicode(Filter):
    def __init__(self, *args, **kwargs) -> None:
        super().__init__(*args, **kwargs)

    def apply(self, document):
        text = document.text
        text = unicodedata.normalize('NFKC', text)
        document.text = text
        return document

class NormalizeHanToZen(Filter):
    def __init__(self, *args, **kwargs) -> None:
        super().__init__(*args, **kwargs)

    def apply(self, document):
        text = document.text
        text = habachen.han_to_zen(text)
        document.text = text
        return document


if __name__=="__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('infile')
    parser.add_argument('--bunkai-model')
    args = parser.parse_args()

    if args.bunkai_model:
        bunkai = Bunkai(path_model=Path(args.bunkai_model))
    else:
        bunkai = Bunkai()
    cleaner = Compose([
        document_filters.AcceptJapanese(),
        RemoveEscapeSequence(),
        RemoveEmoji(),
        NormalizeUnicode(),
        NormalizeHanToZen()
    ])

    with open(args.infile) as f:
        total = sum([1 for i in f])
        f.seek(0)
        for line in tqdm(f, total=total, postfix=args.infile):
            line = cleaner(line)
            if line == '':
                continue
            for sentence in bunkai(line):
                print(sentence)
import os
import tensorflow_datasets as tfds
from tqdm import tqdm
import numpy as np
import argparse

if __name__=="__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--outdir', required=True)
    args = parser.parse_args()

    for s in ['train', 'validation', 'test']:
        with open(os.path.join(args.outdir, '{}.txt'.format(s)), 'w') as f:
            ds = tfds.load('wiki40b/ja', split=s)
            cardinality = np.sum([1 for i in ds.batch(1)])
            for wiki in tqdm(ds.as_numpy_iterator(), total=cardinality):
                lines = wiki['text'].decode().split('\n')
                for line in lines:
                    line = line.replace('_NEWLINE_', '\n')
                    if line == '' or line in ['_START_ARTICLE_', '_START_PARAGRAPH_', '_START_SECTION_']:
                        continue
                    f.write('{}\n'.format(line))
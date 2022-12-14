import numpy as np
import pandas as pd
from preprocess import clean
from sys import argv
import xgboost as xgb

import warnings
warnings.filterwarnings('ignore')

def label_data(df, model):
    m = xgb.Booster()
    m.load_model(model)
    df = clean(df)
    cleaned_df = df.copy()
    df = xgb.DMatrix(df)
    pred = m.predict(df)
    cleaned_df.insert(0, 'executed', pred)
    return cleaned_df


def main():
    if len(argv) != 4:
        print('Usage: python label_data.py [model] [input_csv] [output_csv]')
        exit(1)
    
    data = label_data(pd.read_csv(argv[2]), argv[1])

    data.to_csv(argv[3], index=False)
    print(f"Labelled data saved to {argv[3]}")

if __name__ == '__main__':
    main()
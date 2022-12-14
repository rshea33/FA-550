import numpy as np
import pandas as pd
from preprocess import clean
from sys import argv
import xgboost as xgb


import warnings
warnings.filterwarnings('ignore')

def main():
    if len(argv) != 4:
        print('Usage: python label_data.py [model] [input_csv] [output_csv]')
        exit(1)

    # load the model
    model = xgb.Booster()
    model.load_model(argv[1])

    # load the data
    df = pd.read_csv(argv[2])
    df = clean(df)
    pred = model.predict(df)

    df.insert(0, 'executed', pred)

    df.to_csv(argv[3], index=False)


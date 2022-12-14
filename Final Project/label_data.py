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
    print(f"Loaded model from {argv[1]}")

    # load the data
    df = pd.read_csv(argv[2])
    print(f"Loaded data from {argv[2]}")
    df = clean(df)
    cleaned_df = df.copy()
    print("Cleaned data")
    # Convert to DMatrix
    df = xgb.DMatrix(df)
    print("Converted to DMatrix")
    pred = model.predict(df)
    print("Predicted")


    cleaned_df.insert(0, 'executed', pred)
    print("Added predictions to dataframe")


    cleaned_df.to_csv(argv[3], index=False)
    print(f"Saved to {argv[3]}")

if __name__ == '__main__':
    main()
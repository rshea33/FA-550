import numpy as np
import pandas as pd
import xgboost as xgb
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
from sklearn.metrics import confusion_matrix
from sklearn.metrics import mean_squared_error
from preprocess import clean
from sys import argv

import warnings
warnings.filterwarnings('ignore')

def main(): # must import labelled data
    df = pd.read_csv(argv[1])
    target = df['delta_home_win_exp']
    df = clean(df) # executed is dropped as it is not in relevant_columns
    print(df.dtypes)
    df = df.drop(['pitch_type', 'delta_home_win_exp'], axis=1)


    X_train, X_test, y_train, y_test = train_test_split(df, target, test_size=0.2, random_state=2)

    # XGBoost
    xgb_model = xgb.XGBRegressor(random_state=1)
    xgb_model.fit(X_train, y_train)
    xgb_pred = xgb_model.predict(X_test)


    print(f"XGBoost RMSE: {np.sqrt(mean_squared_error(y_test, xgb_pred))}")

    # save model
    xgb_model.save_model(argv[2])


if __name__ == '__main__':
    main()



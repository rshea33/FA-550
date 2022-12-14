import numpy as np
import pandas as pd
import xgboost as xgb
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
from sklearn.metrics import confusion_matrix
from preprocess import clean
from sys import argv

import warnings
warnings.filterwarnings('ignore')

def main(): # must import labelled data
    df = pd.read_csv(argv[1])
    target = df['executed']
    df = clean(df) # executed is dropped as it is not in relevant_columns

    X_train, X_test, y_train, y_test = train_test_split(df, target, test_size=0.2, random_state=2)

    # XGBoost
    xgb_model = xgb.XGBClassifier(objective="binary:logistic", random_state=1)
    xgb_model.fit(X_train, y_train)
    xgb_pred = xgb_model.predict(X_test)
    xgb_accuracy = accuracy_score(y_test, xgb_pred)

    
    print(f"\n\nAccuracy: {xgb_accuracy}", end='\n\n')
    print(f"Confusion Matrix:\n{confusion_matrix(y_test, xgb_pred)}", end='\n\n')

    # save model
    xgb_model.save_model(argv[2])


if __name__ == '__main__':
    main()



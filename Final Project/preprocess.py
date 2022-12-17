import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sys import argv
from sklearn.preprocessing import StandardScaler

import warnings
warnings.filterwarnings('ignore')

def clean(df):
    relevant_columns = [ # Executed is removed as it is not a feature
        'pitch_type',
        'release_speed',
        'release_pos_x',
        'release_pos_y',
        'release_pos_z',
        'zone',
        'stand',
        'p_throws',
        'type',
        'balls',
        'strikes',
        'pfx_x',
        'pfx_z',
        'plate_x',
        'plate_z',
        'on_3b',
        'on_2b',
        'on_1b',
        'outs_when_up',
        'inning',
        'hit_distance_sc',
        'launch_speed',
        'launch_angle',
        'effective_speed',
        'release_spin_rate',
        'release_extension',
        'spin_axis'
    ]

    data = df[relevant_columns]
    data['stand'] = data['stand'].map({'R': 1, 'L': 0})
    data['p_throws'] = data['p_throws'].map({'R': 1, 'L': 0})
    data['type'] = data['type'].map({'S': 1, 'B': 0})

    data['on_3b'] = data['on_3b'].notnull().astype('int')
    data['on_2b'] = data['on_2b'].notnull().astype('int')
    data['on_1b'] = data['on_1b'].notnull().astype('int')
    data['winning_by'] = df['fld_score'] - df['bat_score']

    data = data.fillna(0)
    return data

def preprocess(df):
    pass


def main():
    if len(argv) != 3:
        print('Usage: python preprocess.py [input_csv] [output_csv]')
        exit(1)
    
    df = pd.read_csv(argv[1])

    df = clean(df)
    # df = preprocess(df)
    df.to_csv(argv[2], index=False)
    

if __name__ == '__main__':
    main()
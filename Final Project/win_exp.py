import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from preprocess import clean

def main():
    
    df = pd.read_csv('Data/sale_2017.csv')
    df = clean(df)
    df['count'] = df['balls'].astype(str) + '-' + df['strikes'].astype(str)
    df['count'] = df['count'].astype('category')
    
    dfs = {}
    for count in sorted(df['count'].unique()):
        dfs[count] = df[df['count'] == count]

    means = {}
    for count in dfs:
        means[count] = np.abs(dfs[count]['delta_home_win_exp']).mean()

    print(means)
    plt.bar(means.keys(), means.values())
    plt.title('Mean Absolute Difference in Win Expectancy by Count')
    plt.xlabel('Count')
    plt.ylabel('Mean Absolute Difference in Win Expectancy')
    plt.savefig('Visualizations/mean_abs_win_exp_by_count.png')
    print('Saved mean_abs_win_exp_by_count.png to Visualizations/mean_abs_win_exp_by_count.png')
    plt.show()

if __name__ == '__main__':
    main()
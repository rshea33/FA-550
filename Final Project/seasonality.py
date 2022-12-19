import pandas as pd
import matplotlib.pyplot as plt

def main():
    df = pd.read_csv('Data/team_city.csv')
    print(df['api_game_date_month_text'].unique())
    months = ['Mar/Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep/Oct']
    dfs = []
    for month in months:
        dfs.append(df[df['api_game_date_month_text'] == month])

    print(df.columns)

if __name__ == '__main__':
    main()
import pandas as pd
from sys import argv

def main():
    path = argv[1]
    df = pd.read_csv(path)
    for team in df['player_id'].unique():
        team_df = df[df['player_id'] == team]
        team_df.to_csv(f'Data/Team/{team}.csv', index=False)

if __name__ == '__main__':
    main()
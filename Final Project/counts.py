import pandas as pd
from sys import argv

def main():
    if len(argv) != 2:
        print('Usage: python counts.py [input_csv]')
        exit(1)

    df = pd.read_csv(argv[1])
    
    df['count'] = df['balls'].astype(str) + '-' + df['strikes'].astype(str)
    
    counts = df['count'].unique()

    for count in counts:
        temp = df[df['count'] == count]
        print(f'{count}: {len(temp)}')
        temp.to_csv(f'Data/Counts/{count}.csv')
        print(f'Wrote Data/Counts/{count}.csv')
    

if __name__ == '__main__':
    main()
from label_data import label_data
import pandas as pd

from sys import argv

import warnings
warnings.filterwarnings('ignore')

def main():
    if len(argv) != 4:
        print('Usage: python pipeline.py [model] [input_csv] [output_csv]')
        exit(1)
    
    data = label_data(pd.read_csv(argv[2]), argv[1])

    data.to_csv(argv[3], index=False)
    print(f"Labelled data saved to {argv[3]}")

if __name__ == '__main__':
    main()


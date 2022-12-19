import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from sys import argv

def main():
    """Create a displot of the data"""
    if len(argv) != 2:
        print('Usage: python seaborn_displot.py [input_csv]')
        exit(1)

    df = pd.read_csv(argv[1])
    plt.figure(figsize=(10, 10))
    sns.pairplot(df, hue='executed')
    plt.title('Pairplot of Data')
    plt.savefig('Visualizations/pairplot.png')
    print('Saved pairplot.png to Visualizations/pairplot.png')
    plt.show()

if __name__ == '__main__':
    main()
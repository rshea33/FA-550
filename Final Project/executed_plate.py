import pandas as pd
import matplotlib.pyplot as plt

def main():
    df = pd.read_csv('Data/degrom_sl_labelled.csv')
    
    plt.figure(figsize=(10, 10))
    plt.scatter(df['plate_x'], df['plate_z'], c=df['executed'], alpha=0.8, edgecolors='none', s=30, cmap='coolwarm')
    plt.title('DeGrom Sliders')
    plt.xlabel('X')
    plt.ylabel('Y')
    plt.xlim(-2, 2)
    plt.ylim(0, 5)
    # Draw the zone
    plt.plot([-(17/2) / 12, (17/2) / 12], [1.5, 1.5], color='black', linestyle='--')
    plt.plot([-(17/2) / 12, (17/2) / 12], [3.6, 3.6], color='black', linestyle='--')
    plt.plot([-(17/2) / 12, -(17/2) / 12], [1.5, 3.6], color='black', linestyle='--')
    plt.plot([(17/2) / 12, (17/2) / 12], [1.5, 3.6], color='black', linestyle='--')
    plt.colorbar()
    plt.savefig('Visualizations/degrom_sliders.png')
    print('Saved degrom_sliders.png to Visualizations/degrom_sliders.png')
    plt.show()

if __name__ == '__main__':
    main()
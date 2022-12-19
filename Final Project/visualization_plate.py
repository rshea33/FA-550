import pandas as pd
import matplotlib.pyplot as plt


def main():
    # Iterate through the counts
    counts = ['0-0', '0-1', '0-2',
                '1-0', '1-1', '1-2',
                '2-0', '2-1', '2-2',
                '3-0', '3-1', '3-2']

    fig, axs = plt.subplots(3, 4, figsize=(10, 10))

    i, j = 0, 0

    for count in counts:
        data = pd.read_csv(f'Data/Counts/{count}.csv')

        axs[i, j].scatter(data['plate_x'], data['plate_z'], alpha=0.3, c='red', edgecolors='none', s=30)

        axs[i, j].set_title(f'{count}')
        axs[i, j].set_xlabel('X')
        axs[i, j].set_ylabel('y')
        # Draw the zone
        axs[i, j].plot([-(17/2) / 12, (17/2) / 12], [1.5, 1.5], color='black', linestyle='--')
        axs[i, j].plot([-(17/2) / 12, (17/2) / 12], [3.6, 3.6], color='black', linestyle='--')
        axs[i, j].plot([-(17/2) / 12, -(17/2) / 12], [1.5, 3.6], color='black', linestyle='--')
        axs[i, j].plot([(17/2) / 12, (17/2) / 12], [1.5, 3.6], color='black', linestyle='--')
        axs[i, j].set_xlim(-2, 2)
        axs[i, j].set_ylim(0, 5)
        fig.suptitle('Density Scatter Plot of Plate Locations by Count')
        j += 1
        if j == 4:
            i += 1
            j = 0

    plt.tight_layout()
    plt.savefig('Visualizations/plate_scatter.png')
    print('Saved scatter plot to Visualizations/plate_scatter.png')
    plt.show()

    

if __name__ == '__main__':
    main()
import pandas as pd

truth = pd.read_csv('degrom_sl.csv')['executed']

pred = pd.read_csv('degrom_sl_labelled.csv')['executed']

df = pd.DataFrame({'truth': truth, 'pred': round(pred).astype(int)})

print(df)
print(f"Accuracy: {sum(df['truth'] == df['pred']) / len(df)}")
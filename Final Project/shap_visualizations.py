import pandas as pd
from sys import argv
import xgboost as xgb
import shap
import matplotlib.pyplot as plt

def main():
    """Feed a model and a dataset"""
    if len(argv) != 3:
        print('Usage: python shap_visualizations.py [model] [dataset]')
        exit(1)

    model = argv[1] # Assume XGBoost
    dataset = argv[2]

    df = pd.read_csv(dataset)
    
    
    # Get the model
    m = xgb.Booster()
    m.load_model(model)


    explainer = shap.TreeExplainer(m)
    shap_values = explainer.shap_values(df)


    # Plot the SHAP values
    shap.summary_plot(shap_values, df, show=False)
    plt.title("Summary Plot for XGBoost Classification Model")
    plt.annotate('The SHAP value represents the\n\
                 impact of a feature on the model output.\n\
                 The color represents the feature value\n\
                 (red high, blue low).', xy=(-3, 0.5), xytext=(0, 0), textcoords='offset points', ha='center', va='center', size=9)
    # Bold the top feature
    plt.annotate('Most important Feature', xy=(2, 19.5), xytext=(0, 0), textcoords='offset points', ha='center', va='center', size=10, weight='bold', color='red')
    plt.annotate('Least important Feature', xy=(2, -0.5), xytext=(0, 0), textcoords='offset points', ha='center', va='center', size=10, weight='bold', color='blue')

    plt.savefig('Visualizations/shap_class.png')
    print('Saved summary plot to Visualizations/shap_class.png')
    plt.show()

if __name__ == '__main__':
    main()
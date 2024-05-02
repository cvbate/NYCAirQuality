# Python script for visualizing results of sql analysis

import pandas as pd
import matplotlib.pyplot as plt

# Read Excel file into pandas DataFrames
excel_path = 'C:/Users/cvale/NYCAirQuality/data4visualizations.xlsx'
sheet_names = ['aerosol_pov_mean', 'co_pov_mean']  # Replace with your sheet names
data = {sheet_name: pd.read_excel(excel_path, sheet_name=sheet_name) for sheet_name in sheet_names}

# Plot the Data
plt.figure(figsize=(10, 6))  # Adjust figure size as needed

for sheet_name, df in data.items():
    # Assuming your DataFrame has columns 'x' and 'y'
    plt.plot(df['x'], df['y'], label=sheet_name)

# Add labels and title
plt.xlabel('X-axis Label')
plt.ylabel('Y-axis Label')
plt.title('Double Line Graph')
plt.legend()

# Show plot
plt.grid(True)  # Optional: add grid
plt.show()

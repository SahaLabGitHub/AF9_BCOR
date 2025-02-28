import os

import numpy as np

import matplotlib.pyplot as plt

import glob

from itertools import cycle

from matplotlib.lines import Line2D
 
# List all energy files in the current directory

energy_files = sorted(glob.glob("pot*.xvg"))
 
# Initialize a dictionary to hold energy data from each file

energy_data = {}
 
# Function to load energy data from an .xvg file

def load_energy_data(filepath):

    with open(filepath, 'r') as file:

        data = []

        for line in file:

            if not line.startswith(('#', '@')):  # Ignore comments and metadata

                parts = line.split()

                if len(parts) >= 2:

                    time, energy = float(parts[0]), float(parts[1])

                    data.append(energy)

        return np.array(data)
 
# Load data and calculate probability distributions

for file_path in energy_files:

    # Extract the file number (e.g., 1, 2, ...) from the filename

    file_number = os.path.splitext(file_path)[0][3:]  # Removes "pot" prefix and .xvg extension

    energy_data[file_number] = load_energy_data(file_path)

#colors= plt.cm.hsv(np.linspace(0,1, len(energy_data)))
 
# Plotting probability distributions

#plt.figure(figsize=(12, 8))

colors = plt.cm.hsv(np.linspace(0, 1, len(energy_data)))  # Generate unique colors

 

# Plotting probability distributions
plt.figure(figsize=(12, 8))
for (file_number, energies), color in zip(energy_data.items(), colors):
    # Calculate probability distribution
    counts, bin_edges = np.histogram(energies, bins=50, density=True)
    bin_centers = 0.5 * (bin_edges[1:] + bin_edges[:-1])

    # Plot with a unique color for each distribution
    plt.plot(bin_centers, counts, label=f'Replica {file_number}', color=color)
#for file_number, energies in energy_data.items():

    # Calculate probability distribution

 #   counts, bin_edges = np.histogram(energies, bins=50, density=True)

  #  bin_centers = 0.5 * (bin_edges[1:] + bin_edges[:-1])

    # Plot

   # plt.plot(bin_centers, counts, label=f'Replica {file_number}', color=colors)
 
plt.xlabel("Energy (kJ/mol)")

plt.ylabel("Probability Density")

plt.title("Probability Distributions of Potential Energy")

#plt.legend(bbox_to_anchor=(1.05,1), loc='upper left', borderaxespad=0, ncol=2)

legend_labels = [f'Replica {i}' for i in energy_data.keys()]
plt.legend(legend_labels, bbox_to_anchor=(1.05, 1), loc='upper left', borderaxespad=0, ncol=2, 
           title="Replica", columnspacing=1, handletextpad=0.5)

#first_half_labels = [f'Replica {i}' for i in range(1, 23)]
#second_half_labels = [f'Replica {i}' for i in range(23, 45)]

#legend_handles = [Line2D([0], [0], color=color, lw=2) for color in colors]


#first_half_handles = legend_handles[:22]
#second_half_handles = legend_handles[22:]

 

# Adding legend outside plot with two columns
#plt.legend(first_half_handles + second_half_handles,
#           first_half_labels + second_half_labels,
 #          bbox_to_anchor=(1.05, 1), loc='upper left', borderaxespad=0, ncol=2, 
  #         title="Replica", columnspacing=1, handletextpad=0.5)



plt.savefig("probability_PE_E531R_REMD.tif", bbox_inches='tight')

 

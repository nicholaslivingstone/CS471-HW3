# This python file plots the data produced by the other files
import os
from os.path import isfile, join
from os import listdir
import matplotlib.pyplot as plt
import csv
import math
import numpy as np

def main():
    np.seterr(all='ignore')

    cur_path = os.path.dirname(__file__) # get current file path
    data_path = os.path.join(cur_path, 'data') # add path to data
    files = [f for f in listdir(data_path) if isfile(join(data_path, f))] # create list of all files in data folder
    
    plt.loglog()

    
    # Plot data from each file
    for file in files:
        x = []
        y = []
        # Open file
        with open(os.path.join(cur_path, 'data', file), 'r') as csvfile:
            plots = csv.reader(csvfile, delimiter=',') # Read via delimitter
            for row in plots:
                if(float(row[1])): # This line ignores any 0 error
                    x.append(float(row[0])) # n
                    y.append(float(row[1])) # error
        plt.loglog(x, y,'-D', basex=10, markersize=2, linewidth=1) # plot as log log

    # Plot Gauss Spectral Error Line
    x = np.linspace(0, 100)
    # k = pi^2
    y = np.power(1.1, -5 * x)
    plt.loglog(x, y, ':', lw=1, c='m')
    # k = pi
    y = np.power(1.1, -12 * x)
    plt.loglog(x, y, '--', lw=1, c='brown')

    # Make graph look nice
    #---------------------
    # Adjust graph limits
    plt.xlim(1, 10**4)
    plt.ylim(10**(-16), 10)

    plt.grid(True, which='both', ls='--') # Add grid

    #Set Labels 
    plt.xlabel('n')
    plt.ylabel('error')
    # plt.legend(["Trapezoidal k=pi^2", "Trapezoidal k=pi", "Gauss k=pi^2", "Gauss k=pi"])
    # Dictionary in case the order of the files changes
    legend_dict = {'trap_data2.txt' : r'Trapezdoial $k = \pi^2$', 'trap_data1.txt' : r'Trapezdoial $k = \pi$', 'gq_data2.txt' : r'Gauss-Legendre $k = \pi^2$', 'gq_data1.txt' : 'Gauss-Legendre $k = \pi$'}
    legend = [legend_dict[files[0]], legend_dict[files[1]], legend_dict[files[2]], legend_dict[files[3]], r'Gauss Convergence $k = \pi^2$', r'Gauss Convergence $k = \pi$']
    plt.legend(legend, loc=1)
    plt.axhline(y=10**(-10), ls='-.', c='purple')
    plt.savefig("./figures/graph.png") # Save plot
    plt.show()


if __name__ == "__main__":
    main()
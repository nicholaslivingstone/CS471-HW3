import matplotlib.pyplot as plt
import numpy as np

def main():
    PI = np.pi 
    k = [PI, PI**2]
    
    for value in k:
        x = np.linspace(-1,1,200)
        y = np.exp(np.cos(value * x))
        plt.plot(x, y)
    plt.legend([r"$k = \pi$", r"$k = \pi^2$"])
    plt.xlabel("x")
    plt.ylabel(r"$f(x)$")
    plt.savefig('./figures/functions_plot.png')
    plt.show()

if __name__ == "__main__":
    main()
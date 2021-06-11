import matplotlib.pyplot as plt
import math
import numpy as np

def main():
    PI = math.pi 
    k = [PI, PI**2]
    
    for value in k:
        x = np.linspace(-1,1,200)
        y = (value**2) * np.exp(np.cos(value * x)) * (np.power(np.sin(value * x), 2) - np.cos(value*x))
        plt.plot(x, y)
    plt.legend([r"$k = \pi$", r"$k = \pi^2$"])
    plt.xlabel("x")
    plt.ylabel(r"$f''(x)$")
    plt.grid(True)
    plt.savefig('./figures/fpp_plot.png')
    plt.show()

    print((PI**2) * np.exp(np.cos(PI * 0)) * (np.power(np.sin(PI * 0), 2) - np.cos(PI*0)))
    print(((PI**2)**2) * np.exp(np.cos((PI**2) * 0)) * (np.power(np.sin((PI**2) * 0), 2) - np.cos((PI**2)*0)))
if __name__ == "__main__":
    main()
import RoseblattPerceptron as RosenblattPerceptron
import matplotlib.pyplot as plt
import numpy as np


def buildView(rp: RosenblattPerceptron, P, T, P_test = None, T_test = None, x_lim=[-5, 5]):
    if (rp.weights is None):
        print("You should train your perceptron first")
        return

    colorsMap = {}

    colorsMap = getColors(colorsMap, T)

    for i, point in enumerate(P):
        plt.scatter(point[0], point[1], marker='o', color=getClassColor(colorsMap, T[i]))

    if P_test is not None and T_test is not None:
        colorsMap = getColors(colorsMap, T_test)
        for i, test_point in enumerate(P_test):
            plt.scatter(test_point[0], test_point[1], marker='v', color=getClassColor(colorsMap, T_test[i]))

    for i in range(rp.numNeurons):
        x_axis = np.linspace(x_lim[0], x_lim[1], 100)
        y_axis = -(rp.weights[i][0] * x_axis + rp.biases[i]) / rp.weights[i][1]
        plt.plot(x_axis, y_axis, color="black")

    plt.grid()
    plt.xlim(x_lim[0], x_lim[1])
    plt.ylim(x_lim[0], x_lim[1])
    plt.show()

def getColors(colors_map, T):
    classStrings = list(map(str, T))
    uniqueClasses = set(classStrings)
    for uc in uniqueClasses:
        if (uc in colors_map):
            continue

        colors_map[uc] = (
            np.random.uniform(0, 1),
            np.random.uniform(0, 1),
            np.random.uniform(0, 1),
        )

    return colors_map

def getClassColor(colors_map, t):
    class_string = str(t)
    return colors_map[class_string]

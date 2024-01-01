import numpy as np
import matplotlib.pyplot as plt

def plotStar(x0, ratio, nv):
    offset = 0
    rx, ry = getStar(x0, nv, offset)

    # plot inner circle
    x0 = ratio * 10000
    x = np.linspace(x0, ratio *x0, 1000)
    y1 = np.sqrt(x0**2 - x**2)
    y2 = - np.sqrt(x0**2 - x**2)
    offset = np.pi / nv
    rx1, ry1 = getStar(x0, nv, offset)

    rx = np.array(rx)
    ry = np.array(ry)
    rx1 = np.array(rx1)
    ry1 = np.array(ry1)

    # Ensure the arrays are vertical by reshaping them.
    rx = rx.reshape(-1, 1)
    ry = ry.reshape(-1, 1)
    rx1 = rx1.reshape(-1, 1)
    ry1 = ry1.reshape(-1, 1)

    # Concatenate the inner and outer points.
    rxAll = np.hstack((rx, rx1))  # Stacks arrays in sequence vertically (row wise).
    ryAll = np.hstack((ry, ry1))  # Stacks arrays in sequence vertically (row wise).

    # Create vectors (rxVec, ryVec) that loop back to the first point
    rxVec = np.append(rxAll.flatten(), rxAll[0])
    ryVec = np.append(ryAll.flatten(), ryAll[0])

    return rxVec, ryVec, rx, ry, x, y1, y2, rx1, ry1

def getStar(x0, nv, offset):
    angles = np.linspace(0, 2*np.pi, nv, endpoint=False) + offset
    rx = x0 * np.cos(angles)
    ry = x0 * np.sin(angles)
    return rx, ry

def getCircle(r1, nv, xM):
    x1a = np.linspace(-r1, r1, 100)
    y1 = np.sqrt(r1**2 - x1a**2)
    y2 = -np.sqrt(r1**2 - x1a**2)

    angles = np.linspace(0, 2*np.pi, nv, endpoint=False)
    rxM = xM * np.cos(angles)
    ryM = xM * np.sin(angles)

    rxMatrix = (rxM[:, None] + x1a)
    ry1Matrix = (ryM[:, None] + y1)
    ry2Matrix = (ryM[:, None] + y2)

    return rxMatrix, ry1Matrix, ry2Matrix

def plotStars():
    plt.close('all')
    x0 = 10000
    ratio = 0.5
    nv = 12

    rxVec, ryVec, rx, ry, x, y1, y2, rx1, ry1 = plotStar(x0, ratio, nv)
    rxVec1, ryVec1, _, _, x, y1, y2, _, _ = plotStar(0.1 * x0, 0.15, nv)

    r1 = x0 / 20
    xM = x0 / 3
    rxMatrix, ry1Matrix, ry2Matrix = getCircle(r1, nv, xM)

    r1 = x0 / 25
    xM = 2 * x0 / 3
    rxMatrix1, ry1Matrix1, ry2Matrix1 = getCircle(r1, nv, xM)

    # Plotting main star
    plt.figure(figsize=(10,10))
    plt.plot(x, y1, 'k--', -x, y2, 'k--')
    plt.plot(rx1, ry1, 'r*')
    plt.plot(rx, ry, 'ro')
    plt.plot(rxVec, ryVec)
    plt.plot(rxVec1, ryVec1, 'b')

    for idx in range(nv):
         plt.plot(rxMatrix[idx], ry1Matrix[idx], 'b')
         plt.plot(rxMatrix[idx], ry2Matrix[idx], 'b')

    for idx in range(nv):
         plt.plot(rxMatrix1[idx], ry1Matrix1[idx], 'b')
         plt.plot(rxMatrix1[idx], ry2Matrix1[idx], 'b')

    plt.gca().set_aspect('equal', adjustable='box')
    plt.axis('off')

    # plt.savefig('sternchenTest.pdf')
    plt.savefig('sternchenTest.png')
    # plt.savefig('sternchenTest.eps')

    # Plotting secondary star
    fig, ax = plt.subplots(figsize=(10,10))
    ax.plot(rxVec, ryVec, 'k')
    ax.plot(rxVec1, ryVec1, 'k')

    for idx in range(nv):
        ax.plot(rxMatrix[idx], ry1Matrix[idx], 'k')
        ax.plot(rxMatrix[idx], ry2Matrix[idx], 'k')

    for idx in range(nv):
        ax.plot(rxMatrix1[idx], ry1Matrix1[idx], 'k')
        ax.plot(rxMatrix1[idx], ry2Matrix1[idx], 'k')

    ax.set_facecolor((1, 1, 1))
    ax.axes.xaxis.set_visible(False)
    ax.axes.yaxis.set_visible(False)
    plt.axis('off')

    plt.savefig('sternchen.pdf')
    plt.savefig('sternchen.png')
    plt.savefig('sternchen.eps')

# Run the function
plotStars()

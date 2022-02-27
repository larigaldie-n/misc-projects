import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
from numpy.random import rand, randint, binomial
import csv
 
# setting up the values for the grid
ON = 255
OFF = 0
CURED = 196
DEAD = 64
vals = [ON, OFF, CURED, DEAD]
 
def randomGrid(N):
 
    s = np.zeros((N,N))
    t = np.zeros((N,N))
    x = N//2
    y = N//2
    s[x, y] = ON
    return s, t
 
def update(frameNum, img, ax, grid, N, gridDays, ann_list):
 
    newGrid = grid.copy()
    illSimultaneously=0
    totalDeaths=0
    totalCured=0
    totalUntouched=0

    for i, a in enumerate(ann_list):
        a.remove()
    ann_list[:] = []

    probaCatch = 0.1/2
    probaDead = 0.00365710319
    if(np.sum(grid == ON) > 1000):
        probaDead *= 2;
    for i in range(N):
        for j in range(N):

            # compute 8-neghbor sum
            # using toroidal boundary conditions - x and y wrap around
            # so that the simulaton takes place on a toroidal surface.
            total = (int(grid[i, (j-1)%N]/ON) + int(grid[i, (j+1)%N]/ON) +
                         int(grid[(i-1)%N, j]/ON) + int(grid[(i+1)%N, j]/ON) +
                         int(grid[(i-1)%N, (j-1)%N]/ON) + int(grid[(i-1)%N, (j+1)%N]/ON) +
                         int(grid[(i+1)%N, (j-1)%N]/ON) + int(grid[(i+1)%N, (j+1)%N]/ON))
 
            if grid[i, j]  == ON:
                illSimultaneously += 1
                gridDays[i,j]+=1
                if gridDays[i,j]>14:
                    newGrid[i,j] = CURED
                else:
                    if (binomial(n=1, p=probaDead)):
                        newGrid[i,j] = DEAD
            elif grid[i,j] == OFF:
                totalUntouched += 1
                if (1 in binomial(n=1, p=probaCatch, size=total)):
                    newGrid[i,j] = ON
            elif grid[i,j] == DEAD:
                totalDeaths+=1
            elif grid[i,j] == CURED:
                totalCured+=1
 
    # update data
    img.set_data(newGrid)
    grid[:] = newGrid[:]
    ann = ax.annotate("Malades: " + str(illSimultaneously) + "; Morts: " + str(totalDeaths) + "; Guéris: " + str(totalCured) + "; Pas attrapé du tout: " + str(totalUntouched), xy=(0, 1.075), xycoords=ax.transAxes)
    ann_list.append(ann)
    f = open('ill.csv', 'a+', newline='')
    writer = csv.writer(f)
    print(str(illSimultaneously))
    writer.writerow([illSimultaneously])
    f.close()
    return img
 
# main() function
def main():
     
    # set grid size
    N = 100
         
    # set animation update interval
    updateInterval = 100
 
    # declare grid
    grid = np.array([])

    grid, gridDays = randomGrid(N)
    ann_list = []
 
    # set up animation
    fig, ax = plt.subplots()
    img = ax.imshow(grid, interpolation='nearest')
    ani = animation.FuncAnimation(fig, update, fargs=(img, ax, grid, N, gridDays, ann_list),
                                  frames = 15,
                                  interval=updateInterval)

    figManager = plt.get_current_fig_manager()
    figManager.window.showMaximized()
    plt.show()
 
# call main
if __name__ == '__main__':
    main()
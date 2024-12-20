import sys
import re

first = True 
time0 = 0 
core = 0 
filename = 'data.dat'
step = int(sys.argv[1])

print ('cores \t perf \t time \t temp \t pressure \t force \t\t neigh \t speed \t eff')
with open(filename, 'r') as file:
    #next(file)
    for line in file: 
        values = line.split()
        if first == True:
            time0 = float(values[1])
            first = False

        perf = float(values[0])
        time = float(values[1])
        temp = float(values[2])
        pres = float(values[3])
        force = float(values[4])
        neigh = float(values[5])
        speed = time0/time
        ncore = max(core,1)
        eff = 100*time0/(time*ncore) 
        print(max(1,core),'\t\t',format(perf,"3.2f"),'\t', format(time, "3.4f"),'\t', format(temp, "3.5f"),'\t', format(pres, "3.5f"),'\t', format(force, "3.4f"),'\t', format(neigh, "3.4f"),'\t', format(speed, "3.4f"),'\t', format(eff, ".0f")) 
        core+=step



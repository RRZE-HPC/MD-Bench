import sys
import re

filename = 'tmp.dat'
time = []
temp = []
pres = []
force = []
neigh = []
perf = []

with open(filename, 'r') as file:
    for line in file:
        if "Performance:" in line:
            words = re.split(r'[ ]', line)
            words = [item.strip() for item in words if item.strip()]
            perf.append(float(words[1]))
     
        if "TOTAL" in line:
            words = re.split(r'[ s]', line)
            words = [item.strip() for item in words if item.strip()]
            time.append(float(words[1]))
            #print(line)
         
        if line.startswith("200"):
            words = re.split(r'[ \t]', line)
            words = [item.strip() for item in words if item.strip()]
            temp.append(float(words[1]))
            pres.append(float(words[2]))
            #print(line)

        if  "AVG" in line:    
            words = re.split(r'[|]', line)
            words = [item.strip() for item in words if item.strip()]
            force.append(float(words[1]))
            neigh.append(float(words[2])) 
            #print(line)  
                        
perf_mean = sum(perf) / len(perf)
time_mean = sum(time) / len(time)
temp_mean = sum(temp) / len(temp)
pres_mean = sum(pres) / len(pres)
force_mean = sum(force) / len(force)
neigh_mean = sum(neigh) / len(neigh)

methods = ["FS", "HS", "ES", "ST"]
half = ["h0", "h1"]
m = int(sys.argv[1])  
h = int(sys.argv[2])

print(f"{perf_mean:<10.2f}{temp_mean:<14.6e}{pres_mean:<14.6e}{methods[m]:<4}{half[h]:<4}")
#print(perf_mean, time_mean, temp_mean, pres_mean, force_mean, neigh_mean)        
                
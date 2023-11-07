import sys

cores = 1
file = open('out_stats.txt', 'r')
while True:
    line = file.readline()
    values = line.split()
    if len(values) == 5:
      proc, perform, time, temp, pressure = values
      if cores == 1:
        cores += 1
        time0=float(time)
      print(int(proc), float(perform),time0/float(time),float(temp),float(pressure))
    if not line:
        break
file.close()


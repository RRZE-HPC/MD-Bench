import sys

file = open('out.txt', 'r')

pressure=""
temp=""
str_time=""
performance=""
time0=0.0
cores=1

while True:
    line = file.readline()
    if (line.find("TOTAL")>-1 or line.find("Performance:")>-1 or line.find("200")>-1):
      
      start = line.find("200")
      if start == 0:  
        values = line.split()
        temp = values[1].strip()
        pressure = values[2].strip()
  
      start = line.find("TOTAL") 
      if start == 0:
        start+= len("TOTAL") 
        end = line.find("s",start) 
        str_time=line[start:end].strip()
        if cores == 1: 
          time0=float(str_time)

      start = line.find("Performance:")+len("Performance:")
      end = line.find("million")
      performance = line[start:end].strip() 
                
      if(line.find("Performance:")>-1):
        print(cores,float(performance),time0/float(str_time),float(temp),float(pressure))
        cores+=1
    if not line:
        break
file.close()


 
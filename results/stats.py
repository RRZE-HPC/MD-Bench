import sys

file = open('out.txt', 'r')

pressure=""
temp=""
str_time=""
performance=""
time0=0.0
cores=1
perform_list=[]
time_list =[]
pressure_list =[]
temp_list =[]
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
        time=line[start:end].strip()
        
      start = line.find("Performance:")+len("Performance:")
      end = line.find("million")
      performance = line[start:end].strip() 
                
      if(line.find("Performance:")>-1):
         perform_list.append(float(performance))
         time_list.append(float(time))
         pressure_list.append(float(pressure))
         temp_list.append(float(temp))        
    if not line:
        break
file.close()
performance = sum(perform_list) / len(perform_list)
time = sum(time_list) / len(time_list)
pressure_list = sum(pressure_list) / len(pressure_list)
temp_list = sum(temp_list) / len(temp_list)
print(performance,time,temp,pressure)

 
import sys
import numpy as np

file = open('out.txt', 'r')
performance=""
time=""
temp=""
pressure=""

perform_list= np.array([])
time_list = np.array([])
pressure_list = np.array([])
temp_list =np.array([])

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
         perform_list = np.append(perform_list, float(performance))
         time_list = np.append(time_list, float(time))
         temp_list = np.append(temp_list, float(temp))
         pressure_list =np.append(pressure_list, float(pressure))
    if not line:
        break
file.close()

# Calculate t-critical value for a 95% confidence interval with 4 degrees of freedom
#t-student Distribution sample of 5 
t_critical = 2.2622 

perf_mean = np.mean(perform_list)
perf_max = np.max(perform_list)
perf_min = np.min(perform_list)
#perf_dev = np.std(perform_list, ddof=1)
#perf_err = t_critical * (perf_dev / np.sqrt(5))

time_mean = np.mean(time_list)
time_max = np.max(time_list)
time_min = np.min(time_list)
#time_dev = np.std(time_list, ddof=1)
#time_err = t_critical * (time_dev / np.sqrt(5))

temp_mean = np.mean(temp_list)
temp_max = np.max(temp_list)
temp_min = np.min(temp_list)

#temp_dev = np.std(temp_list, ddof=1)
#temp_err = t_critical * (temp_dev / np.sqrt(5))

press_mean = np.mean(pressure_list)
press_max = np.max(pressure_list)
press_min = np.min(pressure_list)
#press_dev = np.std(pressure_list, ddof=1)
#press_err = t_critical * (press_dev / np.sqrt(5))

print("%.4f" % perf_mean, "%.4f" % perf_max, "%.4f" % perf_min,
      "%.4f" % time_mean, "%.4f" % time_max, "%.4f" % time_min,
      "%.4f" % temp_mean, "%.4f" % temp_max, "%.4f" % temp_min,
      "%.4f" % press_mean,"%.4f" % press_max,"%.4f" % press_min,)


 
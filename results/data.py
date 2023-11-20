import sys

file = open('out_stats.txt', 'r')
singletime = 0
#single_err=0
#err_ef=0
#err_sp=0
while True:
    line = file.readline()
    values = line.split()
    if len(values) == 13:
      proc, *rest = map(float,values) 
      perf, perfMax, perfMin, time, timeMax, timeMin, temp, tempMax, tempMin, press, pressMax, pressMin = rest 
      #perf, err_pf, time, err_t, temp, err_tp, press, err_ps = rest
      if proc == 1:
        singletime = time
        timeMin = time
        timeMax = time 
        #single_err = err_t
        #  
      speed = singletime/time
      speedMin = singletime/timeMax
      speedMax = singletime/timeMin
      
      eff = speed/proc
      effMin = speedMin/proc 
      effMax = speedMax/proc 
      #err_sp = speed * ((single_err / singletime)**2 + (err_t / time)**2)**0.5
      #err_ef = err_sp= err_sp/proc
       
      print(proc, "%.4f" % perf, "%.4f" % perfMax,  "%.4f" % perfMin,     
                  "%.4f" % speed,"%.4f" % speedMax, "%.4f" % speedMin,    
                  "%.4f" % eff,  "%.4f" % effMax,   "%.4f" % effMin,        
                  "%.4f" % temp, "%.4f" % tempMax,  "%.4f" % tempMin,     
                  "%.4f" % press,"%.4f" % pressMax, "%.4f" % pressMin)
    if not line:
        break
file.close()


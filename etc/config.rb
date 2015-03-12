#Configuration file for log parsing and matching

#Define maximum window size to look at at one time
MAXCHUNK = 10**8

#define matchers and matcher location 
MATCHERLOC = '../bin/' #Must be given a relative location. 
MATCHERS = ['sudomatcher'] #Class defined in these files should have the same name as the file itself

#Persistent storage location
RECORDS = '../etc/logchecking.yaml'
#define logs and log location
#Might change this mechanic. All the logs might not be in the same spot
LOGS = ['/home/pitserver/erfe5132/Documents/sandbox/log_checking/bin/sudo.log', '/home/pitserver/erfe5132/Documents/sandbox/log_checking/bin/kern.log']


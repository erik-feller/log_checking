#Configuration file for log parsing and matching

#Define maximum window size to look at at one time
MAX_WIN_SIZE = 10**8

#define matchers and matcher location 
MATCHERLOC = '../bin/' #Must be given a relative location. 
MATCHERS = ['example1'] #Class defined in these files should have the same name as the file itself

#define logs and log location
#Might change this mechanic. All the logs might not be in the same spot
LOGLOC = '/var/logs/'
LOGS = {'sudo.log' => ['example1', 'example2'], 'kern.log' => ['example1']}


#*********************************************************************************************************
#File which relies on the log and matcher classes to parse throught the given logs and search for certain patterns.
#Returns a Nagios compatible value once it has read the logs using the matchers.
#

require 'yaml'
require 'digest'
require_relative '../lib/log.class.rb'
require_relative '../lib/matcher.class.rb'
require_relative '../etc/config.rb'

#First thing to happen needs to be adding requires for the logs and matchers that we need. Old code can help us with this.
MATCHERS.each do |location|
	require_relative MATCHERLOC+location
end

# which holds log data. Program gets cranky if it isn't there
if File.exists?(RECORDS)
	#Load the serialized data into the 
	oldlogs = File.open(RECORDS, 'r+')
	data = YAML::load(oldlogs.read())
else
	#Create the hash if there isn't one already serialized. 
	oldlogs = File.open(RECORDS, 'w+')
    data = Hash.new()
end

LOGS.each do |log|
	if data[log]
		#In here do the matchers for the logs that do exist. 
		cur_log = YAML::load(data[log])
		#machers and stuffs
		cur_log.update()
		data[log] = YAML::dump(cur_log)	#Dump the YAML data for the current log into the hash. 
	else
		#Here just initialize the new log and don't worry about back logs. Could be confusing. 
		cur_log = Log.new(log)
		data[log] = YAML::dump(cur_log)
	end
end

#Rewind the serialization file and write back into it. 
oldlogs.rewind()
oldlogs.truncate(0)
oldlogs.puts(YAML::dump(data))
		
#Housekeeping
oldlogs.close()	

#Now we need to load in the hash containing all of the serialized log objects. 
#Check to see if any new logs are in the list that aren't included in the hash. If there are any initialize them and add them to the hash. 
#Now simply walk through all of the logs given and run the matchers that are associated with them. If a matcher cannot be found return an error. Probably 3. 
#Given the matcher exists then you can parse the log from @old_offset to the EOF in chunks. This program should be in charge of handling parsing either by line or 20 lines or whatever scheme the matcher wants. 
#Matchers return values to this program. This program will return values to nagios.

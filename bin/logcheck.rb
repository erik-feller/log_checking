#*********************************************************************************************************
#File which relies on the log and matcher classes to parse throught the given logs and search for certain patterns.
#Returns a Nagios compatible value once it has read the logs using the matchers.
#

require 'yaml'
require 'Digest'
require_relative '../lib/log.class.rb'
require_relative '../lib/matcher.class.rb'
require_relative '../etc/config.rb'

#First thing to happen needs to be adding requires for the logs and matchers that we need. Old code can help us with this.
MATCHERS.each do |location|
	require_relative MATCHERLOC+location
end

#Touch the file which holds log data. Program gets cranky if it isn't there
`touch ${RECORDS}`
if File.size(RECORDS) == 0
	#Create the hash if there isn't one already serialized. 
	data = Hash.new()
else
	#Load the serialized data into the 
	oldlogs = File.open(RECORDS)
	data = YAML::load(oldlogs.read())
end

LOGFILES = Logs.keys
LOGFILES.each do |log|
	if data[log]
	else
		
	

#Now we need to load in the hash containing all of the serialized log objects. 
#Check to see if any new logs are in the list that aren't included in the hash. If there are any initialize them and add them to the hash. 
#Now simply walk through all of the logs given and run the matchers that are associated with them. If a matcher cannot be found return an error. Probably 3. 
#Given the matcher exists then you can parse the log from @old_offset to the EOF in chunks. This program should be in charge of handling parsing either by line or 20 lines or whatever scheme the matcher wants. 
#Matchers return values to this program. This program will return values to nagios.

#ruby script to load and chunk log files for use with various matcher extensions. 
#Configurable through ../etc/config
#Extensions should be in ../bin and have their config files in ../etc/
#Version 0.00
#################################################################################
#To Do
#Add ability to skip old logs
#Add ability to give first run flag so that the whole log isn't read.
#Add ability to have single and multi line running modes. 
#Standard format for input into the extension functions. 
#Done
#Nothing

#Now include the config and a loop to include the matchers that we need.
require_relative '../etc/config'
MATCHERS.each do |location|
	require_relative MATCHERLOC+location
end
puts TEST
puts ONE

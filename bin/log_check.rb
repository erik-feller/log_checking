#Script to open logs, parse and chunk them, and apply matcher programs. No matching is done in this script. This script will return 
#Configurable through ../etc/config
#Extensions should be in ../bin and have their config files in ../etc/
#Version 0.10
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

#Get a list of logs from the hash which contains the different matchers run against each log. 
LOGFILES = LOGS.keys
#Now define a class log, each log has matchers that it runs defined in config 
#This part mostly taken from the old branch
class Log
	def initialize(file, oldFile)
		@file = file
		@oldfile = oldFile
		@exitCode
		@@max = 10**8
		@@matchersize = 10**6
	end
	
	def new?
		if File.exist?(@oldFile)
			first = File.open(@file, &:gets)
			firstOld = File.open(@oldFile, &:gets)
			first != firstOld
		else
			true
		end
	end

	def run(matcher)
		if new?
			File.open(@oldFile,'w'){|handle| handle.write('')}
		end
		while size > 0
			read(matcher)
		end
	end

	def size
		File.size?(@file).to_i - File.size?(@oldFile).to_i
	end

	def read(matcher)
		handle = File.new(@file)
		handle.sysseek(File.size?(@oldFile).to_i)
		content = handle.sysread(@@max)
		handle.sysseek(@@matchersize, IO::SEEK_CUR)
		File.open(@oldFile, 'a'){|handle| handle.write(content)}
		puts matcher.match(content)
	end
end

#Now iterate through each log. Chunk it and apply the matchers to the log each time. 
LOGFILES.each do |log|
		puts log
		puts LOGLOC + log
end

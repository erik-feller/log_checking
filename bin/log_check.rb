#Extensions should be in ../bin and have their config files in ../etc/
#Version 0.20
#################################################################################
#To Do
#Need to walk back to start of new line 
#Add ability to skip old logs on the first run.
#Add ability to have single and multi line running modes. 
#Standard format for input into the extension functions. 
#Done
#Can parse through logs and chunk to size
#Basic functionality, can run matchers for each log selected. Check config in ../etc


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
		@file = file #this is the log file to be scanned	
		@oldFile = oldFile #this is the old file to compare the new one to. if theyre the same then 
		puts @file
		puts @oldFile
		@exitCode
		@@max = 10**3
		@@matchersize = 10**3
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

	#Method to determine the size of the new log
	def size
		File.size?(@file).to_i - File.size?(@oldFile).to_i
	end

	#Read the file into the matcher. 
	def read(matcher)
		handle = File.new(@file)
		i = 0
		handle.sysseek(File.size?(@oldFile).to_i)
		content = handle.sysread(@@max)
		counter = @@max - 1
		for i in 0..(content.size)
			if content[counter-i] == "\n"
				handle.sysseek(-i, IO::SEEK_CUR) 
				content = handle.sysread((content.size)-i)
				#handle.sysseek(0-i, IO::SEEK_CUR)
				puts content
				break
			end
		end
		#content = handle.sysread(@@matchersize-i)
		puts content
		puts i
		result = gets
		handle.sysseek(@@matchersize, IO::SEEK_CUR)
		File.open(@oldFile, 'a'){|handle| handle.write(content)}
		puts matcher.match(content)
	end
end

#Now iterate through each log. Chunk it and apply the matchers to the log each time. 
LOGFILES.each do |log|
		puts log
		puts LOGLOC + log
		puts LOGLOC + log + '.old'
		currentLog = Log.new(LOGLOC + log, LOGLOC + log + '.old')
		matchers = LOGS[log]
		matchers.each do |matcher|
				currentLog.run(matcher)
		end
end

#!/usr/local/bin/ruby
#This file describes the Log class which is responsible for maintaining whether or not a log has new content
#The class is responsible for updating the offset accordingly so that each log can be treated as ready for parsing
#Also defines a function that can be used to serialize and deserialize data for each log to be saved between runtimes
#Anything else it needs to do...

require 'digest'
require 'yaml'
require_relative '../etc/config.rb'

class Log
	#initialize each instance so that the checksum will be the current sum value and the offset will be current size
	#this ensures that we won't have to attack the entire thing right away. 
	def initialize(location)
		@location = location
		@old_offset = File.size(@location)
		@cksum = self.chunk_sum(@old_offset)
		@tcksum = 0
	end

	#Function to determine if log has new content or not. 
	#Should not be run outside of the update function.
	def is_new?
		#puts "entering is new"
		if (@old_offset > File.size(@location))
			#File is obviously entirely new
			puts "file is entirely new: size smaller"
			return 1
		else
			if @cksum == self.chunk_sum(@old_offset)
				if(@old_offset == File.size(@location))
					puts "logs are the same"
					return 0 
				else
					puts "new part appended to old"
					return 2
				end
			else
				puts "file is entirely new: Checksums are different"
				return 1
			end
		end
	end	

	#Now we want to come up with a function to determine if the content of the log has changed 
	def update
		puts @cksum
		retval = self.is_new?
		case retval
		when 0
			#Do nothing the logs are the same. 
			return -1
		when 1
			#pass out a 0, set old_offset to size, update checksum to current value
			@old_offset = File.size(@location)
			@cksum = self.chunk_sum(File.size(@location))
			return 0
		when 2
			#pass out a 0, set old_offset to size, update checksum to current value
			offset = @old_offset
			@old_offset = File.size(@location)
			@cksum = self.chunk_sum(File.size(@location))
			return offset
		else
			puts "Some kind of log error:\nInvalid is_new? output."
			return -2
		end
	end

	#Function to find the check sum in chunks. Mostly implementing this because I'm worried about memory usage by just streaming through .read() Returns the value of the check sum. Pass in stopping point value. 
	def chunk_sum(stopp)
		#Added protection against reaching past EOF
		if stopp > File.size(@location)
			puts "That's not healthy"
			return -1;
		end 
		newfile = File.open(@location)
		newfile.rewind
		#print "stopping point is " 
		#puts stopp
		newfile.rewind
		sum = Digest::MD5.new	
		offset = 0
		while offset < stopp
			if stopp-offset < MAXCHUNK
				chunk = newfile.read(stopp-offset)
			else
				chunk = newfile.read(MAXCHUNK)
			end
			sum.update chunk
			offset += MAXCHUNK
		end
		return sum.hexdigest
	end

	#Function to move the offset to the EOF when the matchers are done reading this particular log. 
	def done_reading
		logfile = File.open(@location)
		@old_offset = File.size(logfile)
	end
	#Probably going to take this function out because it will end up being fairly redundant with the YAML built in functions
	def serialize
	end
	def loadfs
	end
	
end	



#!/usr/local/bin/ruby
#This file describes the Log class which is responsible for maintaining whether or not a log has new content
#The class is responsible for updating the offset accordingly so that each log can be treated as ready for parsing
#Also defines a function that can be used to serialize and deserialize data for each log to be saved between runtimes
#Anything else it needs to do...

require 'digest'
require 'yaml'
maxchunk = 1000000

class Log
	#Gotta init each instance, cksum and old_offset start at 0 because thats how we know not to attack the whole file
	def initialize(name, location, matchers)
		@name = name
		@location = location
		sum = Digest::SHA256.new
		@cksum = sum.update @location
		@old_offset = File.size(@location)
		@matchers = ""
	end

	#Function to determine if log has new content or not. This can help to avoid running update unnecessarily
	det is_new?
		sum = Digest::SHA256.new
		newfile = File.read(@location)
		sum.update newfile
		if sum == @cksum
			return true
		else
			return false
		end
	end
	
	#Now we want to come up with a function to determine if the content of the log has changed 
	def update
		#first checks to see if the cksum is even different for any of the programs 
		sum = Digest::SHA256.new
	   	newfile = File.read(@location)
		sum.update newfile	
		if sum == @cksum
			return
		else
			#Now see if the file is smaller than the old offset, then we know it is new
			if @old_offset > File.size(@location)
				@old_offset = 0
				return true
			else
				#Now compare a checksum of the file against the old one.
				#This will be done by building a checksum from the part of the old file behind the new one. 
				offset = 0
				newfile = File.open(@location)
				sum = Digest::SHA256.new
				while offset < @oldoffset
					chunk = newfile.sysread(maxchunk)
					sum.update chunk
					offset += maxchunk
				end
				if sum == @cksum
					return
				else
					@oldoffset = 0
					return
				end
			end			
		end
	end
	def serialize
	end
	def loadfs
	end
	
end	



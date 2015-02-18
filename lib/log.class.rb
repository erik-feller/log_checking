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
	def initialize(name, location, matchers)
		@name = name
		@location = location
		sum = Digest::SHA256.new
		@cksum = sum.update @location
		@old_offset = File.size(@location)
		@matchers = ""
	end

	#Function to determine if log has new content or not. This can help to avoid running update unnecessarily
	def is_new?
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

	#Function to find the check sum in chunks. Mostly implementing this because I'm worried about memory usage by just streaming through .read() Returns the value of the check sum. Pass in stopping point value. 
	def chunk_sum(stopp)
		newfile = File.open(@location)
		sum = Digest::SHA256.new	
		offset = 0
		while offset < stopp
			chunk = newfile.sysread(MAXCHUNK)
			sum.update chunk
			offset += MAXCHUNK
		end
		return sum
	end
	def serialize
	end
	def loadfs
	end
	
end	



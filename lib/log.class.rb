#!/usr/local/bin/ruby
#This defines a class to describe logs that need to be checked.
#Will include functions to determine whether or not a log is new. 
#Going to add some YAML support.
#I have used a SHA-2 256 bit hash if too slow reduce to an md5sum however this hash best avoids collisions.
#Calling to system has injection vulnerabilities... not sure how else to do it though.

require 'digest'
require 'yaml'

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
					
		end


	end
end	



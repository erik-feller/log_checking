#!/usr/local/bin/ruby
#This defines a class to describe logs that need to be checked.
#Will include functions to determine whether or not a log is new. 
#Going to add some YAML support.
#I have used a SHA-2 256 bit hash if too slow reduce to an md5sum however this hash best avoids collisions.
#Calling to system has injection vulnerabilities... not sure how else to do it though.

require "yaml"

class Log
	#Gotta init each instance, cksum and old_offset start at 0 because thats how we know not to attack the whole file
	def initialize(name, location, matchers)
		@name = name
		@location = location
		@cksum = `sha256sum #{@location} | cut -d' ' -f1'`
		@old_offset = File.size(@location)
		@matchers = ""
	end

	#Now we want to come up with a function to determine if the content of the log has changed 
	def is_new?
		#first checks to see if the cksum is even different for any of the programs 
		sum = `sha256sum #{@location} | cut -d' ' -f1'`
		if sum == @cksum
			return false
		else
			
		end


	end
end	



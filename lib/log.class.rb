#!/usr/local/bin/ruby
#This defines a class to describe logs that need to be checked.
#Will include functions to determine whether or not a log is new. 
#Going to add some YAML support.

require "yaml"

class Log
	#Gotta init each instance, cksum and old_offset start at 0 because thats how we know not to attack the whole file
	def initialize(name, location, matchers)
		@name = name
		@location = location
		@cksum = 0
		@old_offset = 0
		@matchers = ""
	end

	#Now we want to come up with a function to determine if its a newlog
	def is_new?
		#first if checks to see if this is the first go around with 
		if @cksum = 0
			@cksum = `cksum #{@location} | cut -d' ' -f1`
			@old_offset = File.size(@location)
			break
		else
		



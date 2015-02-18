#Class defines a matcher. Matchers being used with the program should be children of this function and should not overload these functions as that could cause problems with functions. 

class Matcher 

		#initialize the matcher. Most of the matching is done with the config file for each matcher.
		def initialize(config)
			@config = config
		end

		#Function to actually match to the definitions given. 
		#This could be filled in much later. And It might even change per matcher.
end


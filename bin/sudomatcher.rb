require_relative '../etc/sudoconfig'

class Sudomatcher 
	def self.match(string)
        results = Array.new
        string.split("\n").each do |line|
		#read the line and break out users and machines for each entry	
            	user = line.split(/\s+/)[5].strip #The fifth entry in the sudo log is the username
		host = line.split(/\s+/)[3].strip #The third entry in the sudo log is the hostname
		#Now check to see if this user is trusted on all hosts
        	results << line unless TRUSTED_USERS.include? user

		#Now check to see if this user is trusted on this machine specifically
		#First make sure the user is in partially trusted users. If not push to results
		if PTU.include? user
			#if user is in PTU then check to see if the user is trusted on the machine in question
			if PTU[user].include? host
				break
			else
				results << line
				break
			end
		else
			results << line
		end
		

        end
        return results
    end
end

=begin
Let's weed out everything from the following:

../etc/trusted_users

Also, we don't need to see people on their own boxes, although that's
more difficult.
=end
#B58900
#2AA198
#
#Using partially trusted users list to do this?
#Need to read the lines off of the partially trusted users list to check if the machine lines up with the partially trusted user... how to do this quick and eff?
#

log_checking
==================
Experimental branch
lib/ will contain the classes that the log checker relies on. Log.class.rb and Matcher.class.rb for now.
etc/ will contain the configuration files as well as the persistent file that stores all of the data that will be used by the log class to tell between old and new content.
bin/ will contain the file which will be called and manage the calls of the other classes. Ideally this file will also handle return values to nagios.



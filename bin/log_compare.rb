#!/usr/local/bin/ruby

#***************************************************************************************
#Program to compare a log to the previous state of that log and determine whether or not the log is the same. 
#For now going to attempt this using cksum function built into linux.
#It looks like it will be the fastest way to compare large files without storing an entire copy. 
#***************************************************************************************
#Ver 0.0

#Include file which contains
check = "log_check.rb"
#t = system("cksum " + "#{check}" + " | cut -d' ' -f1")
t = `cksum #{check} | cut -d' ' -f1`
puts t

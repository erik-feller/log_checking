TRUSTED_USERS = {
  'carter'   => 'crunch',
  'dwc'      => 'nx01',
  'goldhamm' => 'hank',
  'hendrenj' => 'birdsnest',
  'jake'     => 'fate',
  'jason'    => 'moebius',
  'jesse'    => 'crackmonkey',
  'kowalews' => 'flatline',
  'orrie'    => 'pinkfloyd',
  'rosemane' => 'tma-0',
  'schaper'  => 'fui',
  'wahlg'    => 'mario',
  'wiha1292' => 'thepiper',
}

#For a partially trusted users list, usernames should index to an array of trusted machines in the hash below. 
PTU= {
   'dotoXXXX' => ['nicot'],
   'zado5040' => ['enf'],
}

#This will work for checking certain users on certain machines but im not sure how to do attempt sensitive failures
#	things such as how many failed attempts a person can have before the plugin will return a 1 or 2
#
#Kernel log
#look for
#disk failure.. I/o reset on some disk
#match this and 2 lines below
#Tomcat log
#match anything that starts with java error and continue until lines are no longer indented.
#sudo log
#find anyone who sudo su
#

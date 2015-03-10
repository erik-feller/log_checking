#A program to make text files to test the log checker with. Files will only contain numbers. Nonsense.

require 'securerandom'
`touch testfile`

file = File.open("testfile", 'w')
puts("How big should the generated file be?")
size = gets.chomp
size = size.to_i
file.puts(SecureRandom.random_bytes(size))


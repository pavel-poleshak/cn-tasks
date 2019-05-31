require 'socket'

s = TCPSocket.new 'localhost', 2000

puts 'Insert some string: '
str = gets.chomp
puts "Your string is: #{str}"
puts "Size: #{str.size}"

s.puts(str)

while line = s.gets # Read lines from socket
  puts "Response from server: #{line}"         # and print them
end

s.close 

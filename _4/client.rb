require 'socket'

u2 = UDPSocket.new

puts 'Insert X:'
x = gets.chomp.to_i

puts 'Insert Y:'
y = gets.chomp.to_i

puts 'Insert Z:'
z = gets.chomp.to_i

input = "#{Marshal.dump([x, y, z])}"
u2.send input, 0, '127.0.0.1', 4913

while s = u2.recv(128)
  p s
end

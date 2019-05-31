require 'socket'

u2 = UDPSocket.new
puts 'Insert your string:'
m = gets
u2.send m.chomp, 0, '127.0.0.1', 4913

p "The shortest word from your string: #{u2.recv(128)}"

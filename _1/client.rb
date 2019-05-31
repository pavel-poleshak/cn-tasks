require 'socket'

socket = TCPSocket.open('localhost', 3000)

puts 'Starting the Client...................'
puts 'Insert some string'
message = gets.chomp

socket.puts(message)

while message = socket&.gets&.chomp # Read lines from the socket
  unless message.empty?
    puts 'Response from sever: '
    puts message
  end
end

puts 'Closing the Client.........'
socket.close # Close the socket

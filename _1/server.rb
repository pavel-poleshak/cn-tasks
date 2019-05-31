require 'socket'

puts 'Starting the Server...................'
server = TCPServer.open(3000) # Server would listen on port 3000

begin
  loop do # Servers run forever
    client_connection = server.accept # Establish client connect connection

    message = client_connection.gets.chomp
    message = message.gsub(/\(.*?\)/, '')

    client_connection.puts(message)
    client_connection.close # Disconnect from the client
  end
rescue StandardError => exc
  puts exc
end

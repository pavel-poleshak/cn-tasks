require 'socket'

server = TCPServer.new 2000
loop do
  Thread.start(server.accept) do |client|
    msg = client.gets.chomp
    if msg.size % 5 == 0
      divider = msg.size / 2
      m = msg.scan(/.{#{divider}}/).reverse.join
    else
      m = 'No!'
    end

    client.puts(m)
    client.close
  end
end

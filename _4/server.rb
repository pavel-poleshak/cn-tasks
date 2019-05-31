require 'socket'

u1 = UDPSocket.new
u1.bind('127.0.0.1', 4913)

while true
  data, client = u1.recvfrom(128)
  Thread.new(client) do |clientAddress|
    puts "New client has joined"
    # u1.send data, 0, clientAddress[3], clientAddress[1]
    data = Marshal.load(data)
    if data.size == 3 && !(data.any?(0))
      data = "Sum of all triangle sides: #{data.sum}"
    else
      data = 'incorrect input'
    end

    u1.send data.to_s, 0, clientAddress[3], clientAddress[1]
  end
end
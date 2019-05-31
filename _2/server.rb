require 'socket'

u1 = UDPSocket.new
u1.bind('127.0.0.1', 4913)

msg, addr = u1.recvfrom(128)
min = msg.split(' ').min_by(&:length)
u1.send min, 0, addr[3], addr[1]

require './db_manager'
require './sms_center'
require 'socket'

def save_message(number, text, client)
  SmsCenter.send_message(number, text, client)
end

def delete_message(number, client)
  SmsCenter.delete_message(number, client)
end

puts 'Starting the Server...................'
server = TCPServer.open(3000) # Server would listen on port 3000

begin
  loop do # Servers run forever
    Thread.fork(server.accept) do |client|
      begin
        data = Marshal.load(client.gets)
        puts "Received from the client:\nnumber => #{data[:number]}\nmessage => #{data[:text]}"

        case data[:method]
        when :send_sms then save_message(data[:number], data[:messages], client)
        when :delete_sms then delete_message(data[:number], client)
        end
      rescue StandardError => e
        client.puts(e)
      ensure
        client.close
      end
    end
  end
rescue StandardError => exc
  puts exc
end

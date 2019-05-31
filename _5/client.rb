require 'socket'

def initialize_connection
	@connection = TCPSocket.open("localhost", 3000)
end

def print_menu
	puts 'press 1 to send sms'
	puts 'press 2 to delete sms'
	puts 'press 0 to exit'
end

def menu_selector(selector)
	case selector
	when '1' then send_sms
	when '2' then delete_sms
	when '0' then exit
	else 'try again'
	end
end

def run_appropriate_action
	selector = gets.chomp

	menu_selector(selector)
end

def send_sms
	initialize_connection
	method = __method__

	puts 'Insert number:'
	number = gets.chomp

	puts 'Insert text for message:'
	text = gets.chomp

	data = "#{Marshal.dump({ number: number, text: text, method: method })}"

	@connection.puts(data)
end

def delete_sms
	initialize_connection
	method = __method__

	puts 'Insert number for deleting:'
	number = gets.chomp

	data = "#{Marshal.dump({ number: number, method: method})}"

	@connection.puts(data)
end

def exit
	@connection.close
	abort('Connection closed. Exit from program')
end

def receive_data_from_server
	while line = @connection.gets
		puts "received : #{line.chop}"
	end
end

while true
	print_menu
	run_appropriate_action
	receive_data_from_server
end





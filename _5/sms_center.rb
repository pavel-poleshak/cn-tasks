class SmsCenter
  @@db = DbManager.new('db')

  class << self
    def send_message(number, text, client)
      puts 'Message is sending ...'
      if @@db.save_message(number, text)
        puts 'Sended.'
        client.puts 'Message sended to the server.'
      end
      rescue StandardError => e
        puts e
    end

    def delete_message(number, client)
      puts 'Message is deleting ...'
      if @@db.can_delete_message?(number)
        @@db.delete_message(number)
        client.puts('Message is deleted from the server.')
      else
        client.puts('something went wrong')
      end
      rescue StandardError => e
        puts e
    end
  end
end
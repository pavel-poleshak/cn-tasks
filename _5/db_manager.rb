# require 'rubygems'
require 'active_record'
require 'table_print'
require './message'

class DbManager
  def initialize(db_name)
    connect(db_name)
    set_up_db
  end

  def save_message(number, text)
    if message = Message.create(number: number, text: text)
      puts message.created_at
      true
    end
  end

  def can_delete_message?(number)
    message = Message.find_by(number: number)

    true if message && (Time.now - message.created_at).to_i < 60
  end

  def delete_message(number)
    message = Message.find_by(number: number)
    message.delete if message
  end

  private

  def connect(db_name)
    puts 'Connect to DB...'

    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: db_name
    )
  end

  def set_up_db
    puts 'DB initializing...'
    ActiveRecord::Schema.define do
      create_table :messages, force: true do |t|
        t.string :number
        t.string :text
        t.timestamps
      end
    end
  end

  def connection
    ActiveRecord::Base.connection
  end

  def database_exists?
    connection
  rescue ActiveRecord::NoDatabaseError
    false
  else
    true
  end

  def schema_exists?
    ActiveRecord::Base.connection.tables.present?
  end
end
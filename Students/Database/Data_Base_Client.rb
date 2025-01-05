require 'sequel'

class Data_Base_CLient

  private_class_method :new

 
  def self.instance(db_config = nil)
    @instance ||= new(db_config)
  end

  def initialize(db_config)
    raise "Требуется настройка базы данных" unless db_config
    self.client = Sequel.connect(db_config)
  end

  def setup_schema
    create_students_table
  end

  def query(query, params = [])
    self.client[query, *params].all
  end

  def close
    self.client.disconnect
  end

  private

  attr_accessor :client

  @instance = nil

  def create_students_table
    self.client.create_table?(:students) do
      primary_key :id
      String :last_name, null: false
      String :first_name, null: false
      String :middle_name, null: false
      String :birth_date, null: true
      String :phone, null: true
      String :telegram, null: true
      String :email, null: true
      String :git, null: false
    end

  end

end
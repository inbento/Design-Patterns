class Student
  attr_accessor :id, :surname, :name, :patronymic, :phone, :telegram, :email, :github

  def initialize(surname, name, patronymic, id: nil, phone: nil, telegram: nil, email: nil, github: nil)
    @id = id
    @surname = surname
    @name = name
    @patronymic = patronymic
    self.phone = phone 
    @telegram = telegram
    @email = email
    @github = github
  end


  def phone=(phone)
    if phone && !Student.valid_phone_number?(phone)
      raise ArgumentError, "Неправильный формат телефонного номера"
    end
    @phone = phone
  end


  def self.valid_phone_number?(phone)

    phone.match?(/\A\+?\d{10,}\z/)
  end

  def to_s
    info = "Студент: #{@last_name} #{@first_name} #{@middle_name}\n"
    info += "ID: #{@id}\n" if @id
    info += "Телефон: #{@phone}\n" if @phone
    info += "Telegram: #{@telegram}\n" if @telegram
    info += "Email: #{@email}\n" if @email
    info += "GitHub: #{@git}\n" if @git
    info  
  end
end
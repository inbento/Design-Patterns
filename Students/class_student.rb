class Student
  attr_accessor :id, :surname, :name, :patronymic, :phone, :telegram, :email, :github

  def initialize(surname, name, patronymic, id: nil, phone: nil, telegram: nil, email: nil, github: nil)
    @id = id
    @surname = surname
    @name = name
    @patronymic = patronymic
    @phone = phone
    @telegram = telegram
    @email = email
    @github = github
  end

  def to_s
    "ID: #{@id}, Фамилия: #{@surname}, Имя: #{@name}, Отчество: #{@patronymic}, Телефон: #{@phone}, Телеграм: #{@telegram}, Почта: #{@email}, Гит: #{@github}"
  end
require_relative 'Student_Base'

class Student < Student_Base
  attr_reader :last_name, :first_name, :middle_name, :phone, :telegram, :email

  def initialize(last_name, first_name, middle_name, id: nil, phone: nil, telegram: nil, email: nil, git: nil)
    self.last_name = last_name
    self.first_name = first_name
    self.middle_name = middle_name
    set_contacts(phone: phone, telegram: telegram, email: email) 
    super(id: id, git: git)
  end

  def set_contacts(phone: nil, telegram: nil, email: nil, git: nil)
    self.phone = phone if phone
    self.telegram = telegram if telegram
    self.email = email if email
  end

  def to_s
    info = "Студент: #{@last_name} #{@first_name} #{@middle_name}\n"
    info += "ID: #{@id || ''}\n"
    info += "Телефон: #{@phone || ''}\n"
    info += "Telegram: #{@telegram || ''}\n"
    info += "Email: #{@email || ''}\n"
    info += "GitHub: #{@git || ''}\n"
    info
  end

  def get_Info
    "#{surname_with_initials} | GitHub: #{git} | Контакт: #{contact}"
  end

 
  def last_name=(last_name)
    if Student.valid_name_format?(last_name)
      @last_name = last_name
    else
      raise ArgumentError, "Фамилия должна содержать только буквы"
    end
  end

  def first_name=(first_name)
    if Student.valid_name_format?(first_name)
      @first_name = first_name
    else
      raise ArgumentError, "Имя должно содержать только буквы"
    end
  end

  def middle_name=(middle_name)
    if Student.valid_name_format?(middle_name)
      @middle_name = middle_name
    else
      raise ArgumentError, "Отчество должно содержать только буквы"
    end
  end


  private


  def phone=(phone)
    if phone.nil? || Student.valid_phone_format?(phone)
      @phone = phone.nil? ? nil : normalize_phone(phone)
    else
      raise ArgumentError, "Некорректный номер телефона: #{phone}"
    end
  end

  def telegram=(telegram)
    if telegram.nil? || Student.valid_telegram_format?(telegram)
      @telegram = telegram
    else
      raise ArgumentError, "Некорректный Telegram: #{telegram}"
    end
  end

  def email=(email)
    if email.nil? || Student.valid_email_format?(email)
      @email = email
    else
      raise ArgumentError, "Некорректный email: #{email}"
    end
  end

  def self.valid_phone_format?(phone)
    !!(phone =~ /\A(\+7|8)\d{10}\z/)
  end

  def self.valid_name_format?(name)
    !!(name =~ /\A[А-Яа-яЁё]{2,50}\z/)
  end

  def self.valid_telegram_format?(telegram)
    !!(telegram =~ /\A@[a-zA-Z0-9_]{5,}\z/)
  end

  def self.valid_email_format?(email)
    !!(email =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
  end

  def self.valid_git_format?(git)
    !!(git =~ /\Ahttps?:\/\/github\.com\/[\w\-]+\z/)
  end

  def normalize_phone(phone)
    phone.sub(/\A8/, '+7')
  end
end
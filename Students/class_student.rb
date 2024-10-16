require_relative 'StudentBase'

class Student < StudentBase
  attr_reader :last_name, :first_name, :middle_name, :phone, :telegram, :email

  def initialize(last_name, first_name, middle_name, options = {})
    self.last_name = last_name
    self.first_name = first_name
    self.middle_name = middle_name
    self.id = options[:id]
    self.phone = options[:phone]
    self.telegram = options[:telegram]
    self.email = options[:email]
    super(id: options[:id], git: options[:git], contact: contact)
  end

  def set_contacts(phone: nil, telegram: nil, email: nil, git: nil)
    self.phone = phone if phone
    self.telegram = telegram if telegram
    self.email = email if email
    self.git = git if git
  end

  def to_s
    info = "Студент: #{@last_name} #{@first_name} #{@middle_name}\n"
    info += "ID: #{@id || 'id не задан'}\n"
    info += "Телефон: #{@phone || 'телефон не указан'}\n"
    info += "Telegram: #{@telegram || 'tg не указан'}\n"
    info += "Email: #{@email || 'email не указан'}\n"
    info += "GitHub: #{@git || 'git не указан'}\n"
    info
  end

  def getInfo
    "#{surname_with_initials}; GitHub: #{git}; Связь: #{contact_info}"
  end

  def surname_with_initials
    "#{@last_name} #{first_name[0]}. #{middle_name[0]}."
  end

  def contact_info
    if @phone
      "Телефон: #{@phone}"
    elsif @telegram
      "Telegram: #{@telegram}"
    elsif @email
      "Email: #{@email}"
    else
      "Никакой контакт не указан"
    end
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

  def id=(id)
    if id.nil? || id.is_a?(Integer)
      @id = id
    else
      raise ArgumentError, "ID должен быть числом"
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

  def git=(git)
    if git.nil? || Student.valid_git_format?(git)
      @git = git
    else 
      raise ArgumentError, "Некорректный формат Git: #{git}"
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

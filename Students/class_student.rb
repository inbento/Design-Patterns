class Student
  attr_accessor :id, :last_name, :first_name, :middle_name, :phone, :telegram, :email, :git

  def self.valid_phone?(phone)
    !!(phone =~ /\A(\+7|8)\d{10}\z/)
  end

  def self.normalize_phone(phone)
    phone.sub(/\A8/, '+7')
  end

  def self.valid_name?(name)
    !!(name =~ /\A[А-Яа-яЁё]{2,50}\z/)
  end

  def self.valid_telegram?(telegram)
    !!(telegram =~ /\A@[a-zA-Z0-9_]{5,}\z/)
  end

  def self.valid_email?(email)
    !!(email =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
  end

  def self.valid_git?(git)
    !!(git =~ /\Ahttps?:\/\/github\.com\/[\w\-]+\z/)
  end

  def initialize(last_name, first_name, middle_name, options = {})
    raise ArgumentError, "Некорректная фамилия: #{last_name}" unless Student.valid_name?(last_name)
    raise ArgumentError, "Некорректное имя: #{first_name}" unless Student.valid_name?(first_name)
    raise ArgumentError, "Некорректное отчество: #{middle_name}" unless Student.valid_name?(middle_name)

    @last_name = last_name
    @first_name = first_name
    @middle_name = middle_name
    @id = options[:id]

    if options[:phone]
      if Student.valid_phone?(options[:phone])
        @phone = Student.normalize_phone(options[:phone])
      else
        raise ArgumentError, "Некорректный номер телефона: #{options[:phone]}"
      end
    end

    if options[:telegram]
      raise ArgumentError, "Некорректный Telegram: #{options[:telegram]}" unless Student.valid_telegram?(options[:telegram])
      @telegram = options[:telegram]
    end

    if options[:email]
      raise ArgumentError, "Некорректный email: #{options[:email]}" unless Student.valid_email?(options[:email])
      @email = options[:email]
    end

    if options[:git]
      raise ArgumentError, "Некорректный GitHub: #{options[:git]}" unless Student.valid_git?(options[:git])
      @git = options[:git]
    end

    validate
  end

  def validate_contact
    if !@phone && !@telegram && !@email
      raise ArgumentError, "Должен быть хотя бы один контакт для связи: телефон, Telegram или email."
    end
  end

  def validate_git
    raise ArgumentError, "Не указан GitHub аккаунт." unless @git
  end
  
  def validate
    validate_contact
    validate_git
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
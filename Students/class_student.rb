class Student
  attr_accessor :id, :last_name, :first_name, :middle_name, :phone, :telegram, :email, :git

  # Валидация телефона
  def self.valid_phone?(phone)
    !!(phone =~ /\A(\+7|8)\d{10}\z/)
  end

  # Преобразуем номер, начинающийся с 8, в формат +7
  def self.normalize_phone(phone)
    phone.sub(/\A8/, '+7')
  end

  # Валидация фамилии, имени и отчества
  def self.valid_name?(name)
    !!(name =~ /\A[А-Яа-яЁё]{2,50}\z/)
  end

  # Валидация Telegram (начинается с @, содержит буквы, цифры и подчеркивание)
  def self.valid_telegram?(telegram)
    !!(telegram =~ /\A@[a-zA-Z0-9_]{5,}\z/)
  end

  # Валидация email
  def self.valid_email?(email)
    !!(email =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
  end

  # Валидация GitHub (простейшая проверка на URL)
  def self.valid_git?(git)
    !!(git =~ /\Ahttps?:\/\/github\.com\/[\w\-]+\z/)
  end

  def initialize(last_name, first_name, middle_name, options = {})
    # Валидация ФИО
    raise ArgumentError, "Некорректная фамилия: #{last_name}" unless Student.valid_name?(last_name)
    raise ArgumentError, "Некорректное имя: #{first_name}" unless Student.valid_name?(first_name)
    raise ArgumentError, "Некорректное отчество: #{middle_name}" unless Student.valid_name?(middle_name)

    @last_name = last_name
    @first_name = first_name
    @middle_name = middle_name
    @id = options[:id]

    # Валидация и нормализация номера телефона
    if options[:phone]
      if Student.valid_phone?(options[:phone])
        @phone = Student.normalize_phone(options[:phone])
      else
        raise ArgumentError, "Некорректный номер телефона: #{options[:phone]}"
      end
    end

    # Валидация Telegram
    if options[:telegram]
      raise ArgumentError, "Некорректный Telegram: #{options[:telegram]}" unless Student.valid_telegram?(options[:telegram])
      @telegram = options[:telegram]
    end

    # Валидация email
    if options[:email]
      raise ArgumentError, "Некорректный email: #{options[:email]}" unless Student.valid_email?(options[:email])
      @email = options[:email]
    end

    # Валидация GitHub
    if options[:git]
      raise ArgumentError, "Некорректный GitHub: #{options[:git]}" unless Student.valid_git?(options[:git])
      @git = options[:git]
    end
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
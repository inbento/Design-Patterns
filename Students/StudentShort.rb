class StudentShort < Student
  attr_reader :id, :surname_with_initials, :git, :contact

  def initialize(arg1, arg2 = nil)
    if arg1.is_a?(Student)
      student = arg1
      @id = student.id || 'ID не задан'
      @surname_with_initials = student.surname_with_initials
      @git = student.git
      @contact = student.contact_info
    elsif arg1.is_a?(Integer) && arg2.is_a?(String)
      @id = arg1
      parse_info(arg2)
    else
      raise ArgumentError, "Неверные аргументы для инициализации"
    end
  end

  def parse_info(info_string)
    parts = info_string.split(';')
    @surname_with_initials = parts[0].strip
    @git = parts[1].split(':').last.strip
    @contact = parts[2].split(':').last.strip
  end

  def to_s
    "ID: #{@id}, Фамилия и инициалы: #{@surname_with_initials}, GitHub: #{@git}, Контакт: #{@contact}"
  end
end

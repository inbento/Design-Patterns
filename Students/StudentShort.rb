require_relative 'StudentBase'

class StudentShort < StudentBase
  attr_reader :surname_with_initials

  def initialize(arg1, arg2 = nil)
    if arg1.is_a?(Student)
      super(id: arg1.id, git: arg1.git, contact: arg1.contact)
      @surname_with_initials = arg1.surname_with_initials
    elsif arg1.is_a?(Integer) && arg2.is_a?(String)
      super(id: arg1)
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
    "ID: #{@id || " "}, Фамилия и инициалы: #{@surname_with_initials}, GitHub: #{@git}, Контакт: #{@contact}"
  end
end
require_relative 'Student_Base'

class Student_Short < Student_Base

    private_class_method :new

  def initialize(surname_with_initials, git, contact, id: nil)
    @surname_with_initials = surname_with_initials
    @contact = contact  
    super(id: id, git: git)
  end


  def self.by_string(student_info, id)
    parse = Student_Short.parse_info(student_info)
    new(parse[:surname_with_initials], parse[:git], parse[:contact], id: id)
  end
  
  def self.by_student(student)
    if student.is_a?(Student)
    Student_Short.by_string(student.get_Info, student.id) 
    end
  end

  def self.bydb(attributes = {})
    surname_with_initials = "#{attributes[:last_name]} #{attributes[:first_name][0]}.#{attributes[:middle_name][0]}." 
    contact = nil
    if attributes[:email]
      contact = attributes[:email]
    elsif attributes[:phone]
      contact = attributes[:phone]
    elsif attributes[:telegram]
      contact = attributes[:telegram]
    end
    new(surname_with_initials, attributes[:git], contact, id: nil)
  end

  def to_s
    "ID: #{@id || " "}, Фамилия и инициалы: #{@surname_with_initials}, GitHub: #{@git}, Контакт: #{@contact}"
  end


  private

  def self.parse_info(info_string)
    user_parts = info_string.split('|').map(&:strip)
    if user_parts.size == 3
      surname_with_initials = user_parts[0] 
      git = user_parts[1].split(': ').last.strip 
      if git == "GitHub"
        git = nil
      end
      contact = user_parts[2].split(':').last.strip 
      if contact == "Контакт"
        contact = nil
      end
      { surname_with_initials: surname_with_initials, git: git, contact: contact }
    else
      raise ArgumentError, "Неверный формат строки"
    end
  end

end
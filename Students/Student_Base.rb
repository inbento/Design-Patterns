class Student_Base
  attr_reader :id, :git
  
  def initialize(id: nil, git: nil)
      self.id = id
      self.git = git
  end

 def surname_with_initials
    if !@last_name.nil? && !@first_name.nil? && !@middle_name.nil?
      "#{@last_name} #{@first_name[0]}.#{@middle_name[0]}."
    elsif !@surname_with_initials.nil?
      @surname_with_initials
    else
      false
    end
 end

  def contact
    if @contact
        return @contact
    elsif @phone
      "Телефон: #{@phone}"
    elsif @telegram
      "Telegram: #{@telegram}"
    elsif @email
      "Email: #{@email}"
    else
      nil
    end
  end
  
  def git=(git)
    if git.nil? || Student.valid_git_format?(git)
      @git = git
    else 
      raise ArgumentError, "Некорректный формат Git: #{git}"
    end
  end

  def id=(id)
    if id.nil? || id.is_a?(Integer)
      @id = id
    else
      raise ArgumentError, "ID должен быть числом"
    end
  end

def validate
  if !StudentBase.has_git?(@git)
    false
  end
  if !StudentBase.has_contact?(@contact)
    false
  end
  true
end
  
  def self.has_git?(git)
    !git.nil? 
  end
  
  def self.has_contact?(contact)
    !contact.nil? 
  end
         
end
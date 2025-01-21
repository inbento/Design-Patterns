require_relative 'Data_List.rb'
require_relative '../Student.rb'

class Data_List_Student < Data_List

  def get_names
    ['N', 'ФИО', 'Git', 'Email', 'Telegram', 'Phone']
  end

  def get_info
    data = @elements.map.with_index(1) do |student, index|
      [
        index,                          
        student.surname_with_initials,     
        student.git,  
        student.email,    
        student.telegram, 
        student.phone,                  
      ]
    end

    data
  end

end
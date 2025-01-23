require_relative 'Data_List.rb'
require_relative '../Student_Short.rb'

class Data_List_Student_Short < Data_List

  def get_names
    ['№', 'ФИО', 'Гит', 'Контакт']
  end

  def get_info
    data = @elements.map.with_index(@start) do |student, index|
      [
        index,                          
        student.surname_with_initials,     
        student.git,                    
        student.contact               
      ]
    end

    data
  end
end
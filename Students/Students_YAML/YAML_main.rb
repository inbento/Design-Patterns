require_relative '../Data_List/Data_List.rb'
require_relative '../Student_Short.rb'
require_relative '../Student.rb'
require_relative '../Data_List/Data_List_Student_Short.rb'
require_relative '../Data_List/Data_table.rb'
require_relative 'Students_List_YAML.rb'


st1 = Student.new( 
  "id": 2,
  "first_name": "Абоб",
  "last_name": "Абоба",
  "middle_name": "Абобович",
  "birth_date": "2016-10-12",
  "telegram": "@aboba",
  "email": "aboba@mail.ru",
  "phone": nil,
  "git": "https://github.com/aboba"
)


yaml = Students_List_YAML.new('./students.yaml')
yaml.add_student(st1)
yaml.write_to_file

data_list = yaml.get_k_n_student_short_list(1, 15)
data_table = data_list.get_data

for i in (0..data_table.row_count-1)
  for j in (0..data_table.column_count-1)
    print (data_table.get_element(i, j))
    print " | "
  end
  puts
end

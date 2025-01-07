require_relative '../Data_List/Data_List.rb'
require_relative '../Student_Short.rb'
require_relative '../Student.rb'
require_relative '../Data_List/Data_List_Student_Short.rb'
require_relative '../Data_List/Data_Table.rb'
require_relative 'Students_List_Base.rb'
require_relative 'Realization_JSON.rb'
require_relative 'Realization_YAML.rb'


st1 = Student.new( 
  "id": 2,
  "first_name": "Сергей",
  "last_name": "Гурьянов",
  "middle_name": "Романович",
  "birth_date": "1999-10-11",
  "telegram": "@guryanov",
  "email": "guryanov@gmail.com",
  "phone": nil,
  "git": "https://github.com/guryanov"
)



yaml = Students_List_Base.new('./students.yaml', Strategy_YAML.new)
#yaml.add_student(st1)
#yaml.write

json = Students_List_Base.new('./students.json', Strategy_JSON.new)
#json.add_student(st1)
#json.write

data_list_yaml = yaml.get_k_n_student_short_list(1, 10)
data_table_yaml = data_list_yaml.get_data

for i in (0..data_table_yaml.row_count-1)
  for j in (0..data_table_yaml.column_count-1)
    print (data_table_yaml.get_element(i, j))
    print (" | ")
  end
  puts
end

puts "--------------------------------------------------------"

data_list_json = json.get_k_n_student_short_list(1, 10)
data_table_json = data_list_json.get_data

for i in (0..data_table_json.row_count-1)
  for j in (0..data_table_json.column_count-1)
    print (data_table_json.get_element(i, j))
    print (" | ")
  end
  puts
end
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
  "first_name": "auiogbuig",
  "last_name": "qognneg",
  "middle_name": "gqpojgo",
  "birth_date": "2009-01-01",
  "telegram": "@asopgop",
  "email": "gwengon@gmail.com",
  "phone": nil,
  "git": "https://github.com/giowengn"
)



yaml = Students_List_Base.new('./students.yaml', Realization_YAML)
yaml.add_student(st1)
yaml.write

json = Students_List_Base.new('./students.json', Realization_JSON)
json.add_student(st1)
json.write

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

data_list_json = yaml.get_k_n_student_short_list(1, 10)
data_table_json = data_list_json.get_data

for i in (0..data_table_json.row_count-1)
  for j in (0..data_table_json.column_count-1)
    print (data_table_json.get_element(i, j))
    print (" | ")
  end
  puts
end
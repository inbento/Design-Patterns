require_relative '../Data_List/Data_List.rb'
require_relative '../Student_Short.rb'
require_relative '../Student.rb'
require_relative '../Data_List/Data_List_Student_Short.rb'
require_relative '../Data_List/Data_Table.rb'
require_relative 'Students_List_JSON.rb'

st1 = Student.new( 
  "id": 1,
  "first_name": "Гурьянов",
  "last_name": "Сергей",
  "middle_name": "Романович",
  "birth_date": "1998-04-04",
  "telegram": "@Guryanov",
  "email": "gur@gmail.com",
  "phone": nil,
  "git": "https://github.com/gur"
)

st2 = Student.new( 
  "id": 2,
  "first_name": "Миков",
  "last_name": "Никита",
  "middle_name": "Сергеевич",
  "birth_date": "2004-06-06",
  "telegram": "@NoneBrain",
  "email": "nekita@gmail.com",
  "phone": nil,
  "git": "https://github.com/inbento"
)

json_test = Students_list_JSON.new('./students.json')
json_test.add_student(st1)
json_test.add_student(st2)
json_test.update_student(1, st2)
json_test.sort_by_full_name!
puts json_test.get_student_short_count
    
data_list = json_test.get_k_n_student_short_list(1, 5)
data_table = data_list.get_data

for i in (0..data_table.row_count-1)
  puts('-----------')
  for j in (0..data_table.column_count-1)
    print (data_table.get_element(i, j))
  end
  puts
end

puts(json_test.get_student_by_id(4))
json_test.write_to_file
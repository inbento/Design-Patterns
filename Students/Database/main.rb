require_relative '../Student'
require_relative 'Students_List_DB'
require_relative '../Data_List/Data_List'
require_relative '../Data_List/Data_Table'
require_relative 'Data_Base_CLient.rb'
require 'date'

db_config = 'postgres://postgres:123@localhost:5432/students_db'
db_client = Data_Base_CLient.instance(db_config)
db_client.setup_schema
students_list = Students_List_DB.new()

st1 = Student.new( 
  "id": 5,
  "first_name": "Капибара",
  "last_name": "Капибарав",
  "middle_name": "Капибаравич",
  "birth_date": "2020-11-08",
  "telegram": "@kapibara",
  "email": "kapibara@gmail.com",
  "phone": nil,
  "git": "https://github.com/kapibara"
)

st2 = Student.new( 
  "id": 4,
  "first_name": "ГОЙДА",
  "last_name": "ГОЙДА",
  "middle_name": "ГОЙДА",
  "birth_date": "2000-10-23",
  "telegram": "@goiiida",
  "email": "goiiida@gmail.com",
  "phone": nil,
  "git": "https://github.com/goiiida"
)


#students_list.add_student(st1)
#students_list.add_student(st2)

data_list = students_list.get_k_n_student_short_list(1, 10)
data_table = data_list.get_data
for i in (0..data_table.row_count-1)
  for j in (0..data_table.column_count-1)
    print (data_table.get_element(i, j))
    print (" | ")
  end
  puts
end

students_list.update_student_by_id(1, st1)
puts students_list.get_student_count
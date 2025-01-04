require_relative 'Data_List.rb'
require_relative '../Student_Short.rb'
require_relative '../Student.rb'
require_relative 'Data_List_Student_Short.rb'
require_relative 'Data_Table.rb'


student1 = Student.new('Миков', 'Никита', 'Сергеевич', git: 'https://github.com/inbento', email: 'nekita@gmail.com', id: 1)
student2 = Student.new('Амогус', 'Игра', 'Копатович', git: 'https://github.com/amogus', email: 'amogus@yandex.ru', id: 2)
student3 = Student.new('Гойда', 'Гойда', 'Гойда', git: 'https://github.com/goida', email: 'goida@mail.ru', id: 3)
student4 = Student.new("Гурьянов", "Сергей", "Романович",git: "https://github.com/gur", email: 'gur@mail.ru', id: 4)

st1 = Student_Short.by_student(student1)
st2 = Student_Short.by_student(student2)
st3 = Student_Short.by_student(student3)
st4 = Student_Short.by_student(student4)

students = [st1, st2, st3, st4]
data_list = Data_List_Student_Short.new(students)


data_table = data_list.get_data
puts

puts "Количество столбцов: #{data_table.column_count}"
puts
puts "Количество строк: #{data_table.row_count}"
puts

for i in (0..data_table.row_count-1)
  puts "---------------"
  for j in (0..data_table.column_count-1)
    puts (data_table.get_element(i, j))
  end
end

puts "---------------"
data_list.select(0)
data_list.select(3)
puts "Выделенные ID: #{data_list.get_selected}" 

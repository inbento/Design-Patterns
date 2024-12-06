require_relative 'Student'
require_relative 'Student_Short'
require_relative 'Student_Base'
require_relative 'Student_binary_tree'
require 'date'

begin

  student1 = Student.new("Миков", "Никита", "Сергеевич", birth_date: Date.new(2004, 1, 10), id: 1, phone: "+79898924547", git: "https://github.com/inbento")
  student2 = Student.new("Гурьянов", "Сергей", "Романович", birth_date: Date.new(1999, 9, 25), id: 2, phone: "+79183345888", git: "https://github.com/gur")
  student3 = Student.new("Абобов", "Абоб", "Абобович", birth_date: Date.new(2018, 8, 22), id: 3, phone: "+79183156080", git: "https://github.com/abob")

  tree = Binary_Search_Tree.new
  tree.insert(student1)
  tree.insert(student2)
  tree.insert(student3)

  tree.each do |student|
    puts student.to_s
    puts
  end

  puts "--------------------------------------"
  students = tree.select { |student| student.birth_date < Date.new(2005, 1, 1) }

  students.each do |student|
    puts student
    puts
  end

rescue ArgumentError => e
  puts "Ошибка: #{e.message}"
end
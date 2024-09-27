require_relative 'class_student'

student1 = Student.new('Иванов', 'Иван', 'Иванович', id: 1, phone: '1234567890', telegram: '@ivanov', email: 'ivanov@example.com')
student2 = Student.new('Петров', 'Петр', 'Петрович', id: 2, email: 'petrov@example.com')
student3 = Student.new('Сидоров', 'Сидор', 'Сидорович', id: 3, github: 'github.com/sidorov')

puts student1
puts
puts student2
puts
puts student3
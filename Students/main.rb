require_relative 'class_student'

begin
  student1 = Student.new('Иванов', 'Иван', 'Иванович', id: 1, phone: '+1234567890', telegram: '@ivanov', email: 'ivanov@example.com')
  puts student1

  student2 = Student.new('Петров', 'Петр', 'Петрович', id: 2, phone: '9876543210', email: 'petrov@example.com')
  puts student2


  student3 = Student.new('Сидоров', 'Сидор', 'Сидорович', id: 3, phone: '123abc456')
  puts student3

rescue ArgumentError => e
  puts "Ошибка: #{e.message}"
end
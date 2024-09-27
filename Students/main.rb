require_relative 'student'

# Создаем несколько объектов Student с разными комбинациями данных
student1 = Student.new('Иванов', 'Иван', 'Иванович', id: 1, phone: '1234567890', telegram: '@ivanov', email: 'ivanov@example.com')
student2 = Student.new('Петров', 'Петр', 'Петрович', id: 2, email: 'petrov@example.com')
student3 = Student.new('Сидоров', 'Сидор', 'Сидорович', id: 3, github: 'github.com/sidorov')

# Выводим информацию о каждом студенте
puts student1
puts student2
puts student3
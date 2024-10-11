require_relative 'class_student'
require_relative 'StudentShort'
begin
  student1 = Student.new("Иванов", "Иван", "Иванович", {
    phone: "+79991234567",
    telegram: "@ivanov", 
    email: "ivanov@example.com",
    git: "https://github.com/ivanov"
  })

  puts student1.getInfo
  puts
  student2 = Student.new("Петров", "Петр", "Петрович", {
    id: 2,
    phone: "89991234568",
  })

  puts student2
  puts

  student2.set_contacts(phone: "+79912235997", email: "petrov@example.com")
  puts "\nОбновлённая информация о студенте:"
  puts student2
  puts
  #student2.email = "petrovfail@example.com" #АШИБКА


  puts "Примеры для класса StudentShort:"
  puts

  student = Student.new('Иванов', 'Иван', 'Иванович', git: 'https://github.com/ivanov', phone: '89012345678')
  student_short1 = StudentShort.new(student)
  puts student_short1

  info_string = "Иванов И. И.; GitHub: https://github.com/ivanov; Связь: Телефон: +789012345678"
  student_short2 = StudentShort.new(1, info_string)
  puts student_short2


rescue ArgumentError => e
  puts "Ошибка: #{e.message}"
end
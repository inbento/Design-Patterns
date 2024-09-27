require_relative 'class_student'

begin
  student1 = Student.new("Иванов", "Иван", "Иванович", {
    id: 1,
    phone: "+79991234567",
    telegram: "@ivanov", 
    email: "ivanov@example.com",
    git: "https://github.com/ivanov"
  })

  puts student1
  puts
  student2 = Student.new("Петров", "Петр", "Петрович", {
    id: 2,
    phone: "89991234568",
  })

  puts student2

rescue ArgumentError => e
  puts "Ошибка: #{e.message}"
end
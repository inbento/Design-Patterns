require_relative 'class_student'

begin
  student1 = Student.new("Иванов", "Иван", "Иванович", {
    id: 1,
    phone: "+79991234567", # корректный телефон
    telegram: "@ivanov",   # корректный telegram
    email: "ivanov@example.com", # корректный email
    git: "https://github.com/ivanov" # корректный github
  })
  
  puts student1
  student2 = Student.new("Петров", "Петр", "Петрович", {
    id: 2,
    phone: "89991234568",  # корректный телефон с 8
    telegram: "petrov",    # некорректный telegram, должен быть с @
    email: "petrov@com",   # некорректный email
    git: "github.com/petrov" # некорректный URL для GitHub
  })
  
  puts
  puts student2

rescue ArgumentError => e
  puts "Ошибка: #{e.message}"
end
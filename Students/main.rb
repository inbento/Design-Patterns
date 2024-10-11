require_relative 'class_student'

begin
  student1 = Student.new("Иванов", "Иван", "Иванович", {
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
  puts

  student2.set_contacts(phone: "+79912235997", email: "petrov@example.com")
  puts "\nОбновлённая информация о студенте:"
  puts student2
  puts
  #student2.email = "petrovfail@example.com" #АШИБКА

rescue ArgumentError => e
  puts "Ошибка: #{e.message}"
end
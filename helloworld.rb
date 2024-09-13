puts "Привет, " + ARGV[0]
puts "Введите ваш любимый язык программирования: "
user_language = $stdin.gets.chomp

if user_language == "ruby"
    puts "Не подлизывайся!"
else
    case user_language
        when "PHP" then puts "Смерть..."
        when "javascript" then puts "1+1=11?" 
        when "html" then puts "Это не язык программирования"
        when "GO" then puts "Фу,зумер что ли?"    
    end
    puts "Ладно, ты все равно будешь любить только ruby"
end

puts "Введите команду языка ruby:"
ruby_command = $stdin.gets.chomp
eval(ruby_command)

puts "Введите команду OC:"
os_command= $stdin.gets.chomp
Kernel.`(os_command)
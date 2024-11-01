def reverse_between_min_and_max(arr)

  min_index, max_index = arr.index(arr.min), arr.index(arr.max)

  min_index, max_index = [min_index, max_index].sort

  yield(min_index, max_index)

end

def find_two_largest(arr)

  two_largest = arr.max(2)

  yield(two_largest)
end

def find_max_odd(arr)

  max_odd = arr.select(&:odd?).max

  yield(max_odd)

end


puts "Выберите способ ввода данных:
      \n1. Ввести с клавиатуры
      \n2. Прочитать из файла строку"

input_choice = gets.chomp

case input_choice

  when "1"
    puts "Введите целые числа через пробел:"
    input_data = gets.chomp.split.map(&:to_i)

  when "2"
    begin
      puts "Введите путь к файлу:"

      file_path = gets.chomp
      file = File.open(file_path, "r")
      input_data = file.read.split.map(&:to_i)

      puts "Файл подключен успешно!"
      rescue Errno::ENONET => error
      puts "Обнаружена ошибка при работе с файлами: #{error}"
      exit

      ensure
      file.close if file
      end

  else
    puts "Неверный выбор."
    exit
end

puts 
puts "Выберите задачу:
        \n1. Переставить в обратном порядке элементы массива, расположенные 
        между его минимальным и максимальным элементами.
        \n2. Найти два наибольших элемента.
        \n3. Найти максимальный нечетный элемент."


method_choice = gets.chomp

puts

case method_choice

  when "1"
    puts reverse_between_min_and_max(input_data) {|min_index, max_index| (input_data[0...min_index + 1] + input_data[min_index + 1...max_index].reverse + input_data[max_index..-1])}.inspect
  when "2"
    find_two_largest(input_data){|two_largest| puts "Два наибольших элемента в массиве: #{two_largest}"}
  when "3"
    find_max_odd(input_data){|max_odd| puts "Максимальный нечетный элемент: #{max_odd}"}
  else
    puts "Некорректный выбор задачи."

end



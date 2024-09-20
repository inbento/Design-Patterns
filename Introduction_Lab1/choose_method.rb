def minimun_in_array(array)

    min_value = array[0]
    
    for i in array do
        if i < min_value
            min_value = i
        end 
    end

    return min_value

end

def first_positive_index(array)

    index = 0

    while index < array.length do 
        if array[index] > 0
            return index
        end
        index += 1
    end

    return "В массиве нет положительного числа"

end
  
method_number = ARGV[0].to_i
file_path = ARGV[1]

begin
    array_numbers = File.read(file_path).split.map(&:to_i)
rescue Errno::ENOENT
    puts "Файл не найден по указанному пути!"
    exit
end

case method_number
    when 1
        puts "Минимальный элемент в массиве: #{minimun_in_array(array_numbers)}"
    when 2
        puts "Номер первого положительного числа в массиве: #{first_positive_index(array_numbers)}"
else
  puts "Неверный номер метода. (1 - для поиска минимального элемента; 2 - для поиска номера первого положительного числа)"
end


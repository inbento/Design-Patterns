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


array_numbers = []
puts "Введите числа (введите 0 для завершения ввода):"
user_number = $stdin.gets.chomp.to_i
while user_number != 0
	array_numbers << user_number
	user_number = $stdin.gets.chomp.to_i
end

min_element = minimun_in_array(array_numbers)
first_pos_index = first_positive_index(array_numbers)

puts "Минимальное число в массиве: #{min_element}"
puts "Номер первого положительного числа в массиве: #{first_pos_index}"

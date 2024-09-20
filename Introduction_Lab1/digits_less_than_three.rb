def count_digits_less_than_three(number)
  count = 0
  number.to_s.each_char do |char|
    digit = char.to_i
    count += 1 if digit < 3
  end
  count
end

puts "Введите число:"
user_input = gets.chomp
result = count_digits_less_than_three(user_input)
puts "Количество цифр в числе, меньших 3: #{result}."
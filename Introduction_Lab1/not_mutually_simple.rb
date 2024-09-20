def largest_common_divisor(a, b)
  b == 0 ? a : largest_common_divisor(b, a % b)
end

def is_prime?(n)
  return false if n < 2
  (2...n).each do |i|
    return false if n % i == 0
  end
  true
end

def sum_of_prime_digits(number)
  digits = number.to_s.chars.map(&:to_i)
  prime_digits = digits.select { |digit| is_prime?(digit) }
  prime_digits.sum
end

def count_numbers(number)
  count = 0
  sum_prime_digits = sum_of_prime_digits(number)

  #puts "Сумма простых цифр числа #{number}: #{sum_prime_digits}"

  (1...number).each do |i|
    if number % i != 0
      if largest_common_divisor(number, i) > 1
        if largest_common_divisor(sum_prime_digits, i) == 1
          count += 1
#          puts "Число #{i} удовлетворяет всем условиям"
#        else
#         puts "Число #{i} НЕ взаимно просто с суммой простых цифр"
        end
 #     else
 #       puts "Число #{i} взаимно просто с #{number}"
      end
  #  else
  #    puts "Число #{i} делится на #{number}"
    end
  end

  count
end

puts "Введите число:"
user_input = gets.chomp.to_i
result = count_numbers(user_input)
puts "Количество чисел для #{user_input}: #{result}"
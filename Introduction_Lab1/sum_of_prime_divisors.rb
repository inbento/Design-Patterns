def prime?(n)
  if n <= 1
    return false
  end 
  (2..Math.sqrt(n)).none? { |i| n % i == 0 }
end

def non_prime_divisors_sum(number)
  sum = 0
  (2..number).each do |i|
    if number % i == 0 && !prime?(i)
      sum += i
    end
  end
  return sum
end

puts "Введите число:"
user_input = gets.chomp.to_i
result = non_prime_divisors_sum(user_input)
puts "Сумма всех непростых делителей числа #{user_input} равна #{result}."
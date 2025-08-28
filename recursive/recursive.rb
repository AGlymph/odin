require 'pry-byebug'

def yell_greeting(string)
  name = string

  name = name.upcase
  greeting = "WASSAP, #{name}!"
  puts greeting
end

def factorial(number)
  return 1 if number <= 1

  number * factorial(number - 1)
end

def plaindrome(string)
  return true if string.length <= 1
  return plaindrome(string[1..-2]) if string.end_with?(string[0])

  false
end

def beers_on_the_wall(bottles)
  if bottles == 0
    puts 'no more bottles of beer on the wall'
    return 0
  end

  puts "#{bottles} bottles of beer on the wall"
  beers_on_the_wall(bottles - 1)
end

def fib_value(n)
  if n <= 1
    0
  elsif n == 2
    1
  else
    fib_value(n - 1) + fib_value(n - 2)
  end
end

def fibs_rec(n)
  if n <= 1
    [0]
  elsif n == 2
    [0, 1]
  else
    sequence = fibs_rec(n - 1)
    sequence << (sequence[-2] + sequence[-1])
  end
end

def merge_sort(numbers)
  return numbers if numbers.length == 1

  half = numbers.length / 2
  left = merge_sort(numbers.slice(0..(half - 1)))
  right = merge_sort(numbers.slice(half..-1))
  merge_array = []

  merge_array << (left.first <= right.first ? left.shift : right.shift) until left.empty? || right.empty?

  merge_array + left + right
end
p merge_sort([1, 3, 2, 4])

input = File.readlines('input.txt')

def is_string_nice?(str)
  vowels = %w{a e i o u}
  vowel_count = 0
  bad_strings = %w{ab cd pq xy}
  has_double = false
  bad_strings.each { |bad_string| return false if str.include? bad_string }
  str.each_char.with_index do |char, i|
    if i != str.length - 1
      has_double = true if char == str[i+1]
      return false if bad_strings.include? char + str[i+1]
    end
    vowel_count += 1 if vowels.include? char
    return true if vowel_count >= 3 && has_double
  end
  false
end

def count_nice_strings(input)
  nice_counter = 0
  input.each do |str|
    nice_counter += 1 if is_string_nice? str.strip
  end
  nice_counter
end

puts count_nice_strings input

####### PART 2 #######

def is_string_nice?(str)
  (has_pair? str) && (has_double_letter? str)
end

def has_double_letter? str
  str.each_char.with_index do |char, i|
    if i != str.length - 2
      return true if char == str[i+2]
    end
  end
  false
end

def has_pair? str
  str.each_char.with_index do |char, i|
    if i < str.length - 1
      pair = char + str[i+1]
      return true if str[0..i-1].include? pair if i > 1
      return true if str[i+2..str.length-1].include? pair
    end
  end
  false
end

puts count_nice_strings input

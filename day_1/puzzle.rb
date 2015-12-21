input = File.readlines('input.txt')

def which_floor(input)
  input[0].each_char.inject(0) { |floor, c| c == "(" ? floor += 1 : floor -= 1 }
end

puts which_floor input

####### PART 2 #######

def which_position(input)
  input[0].each_char.with_index.inject(0) do |floor, char_index|
    char_index[0] == "(" ? floor += 1 : floor -= 1
    floor == -1 ? (return (char_index[1] + 1) ) : floor
  end
  nil
end

puts which_position input

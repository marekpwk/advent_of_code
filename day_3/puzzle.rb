map = File.readlines('input.txt')

def how_many_presents map
  hor, ver = 0, 0
  all_houses = {}
  all_houses[hor.to_s + "," + ver.to_s] = true
  map[0].each_char do |direction|
    hor, ver = set_location direction, hor, ver
    current_pos = hor.to_s + "," + ver.to_s
    all_houses[current_pos] = true
  end
  all_houses.keys.size
end


def set_location direction, hor, ver
  case direction
  when '^' then hor += 1
  when 'v' then hor -= 1
  when '>' then ver += 1
  when '<' then ver -= 1
  end
  [hor, ver]
end

puts how_many_presents map

####### PART 2 #######

def how_many_presents_improved map
  s_hor = s_ver = r_hor = r_ver = 0
  all_houses = {}
  all_houses[s_hor.to_s + "," + s_ver.to_s] = true
  santa_turn = true
  map[0].each_char do |direction|
    if santa_turn
      s_hor, s_ver = set_location direction, s_hor, s_ver
      current_pos = s_hor.to_s + "," + s_ver.to_s
    else
      r_hor, r_ver = set_location direction, r_hor, r_ver
      current_pos = r_hor.to_s + "," + r_ver.to_s
    end
    santa_turn = santa_turn ? false : true
    all_houses[current_pos] = true
  end
  all_houses.keys.size
end

puts how_many_presents_improved map

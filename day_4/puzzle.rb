def lowest_number(str, pattern)
  num = 0
  while true
    return num if make_hash("#{str}#{num}")[0..pattern.length].match(/^#{pattern}/)
    num += 1
  end
end

def make_hash(key)
  Digest::MD5.hexdigest(key)
end

puts lowest_number("iwrupvqb","00000")

####### PART 2 #######

puts lowest_number("iwrupvqb","000000")

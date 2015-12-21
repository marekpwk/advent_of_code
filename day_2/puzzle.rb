boxes = File.readlines('input.txt')

def how_much_paper(boxes)
  boxes.inject(0) do |total_paper, box|
    all_walls_sq_feet = []
    box_walls = box.chomp.split("x").map{ |s| s.to_i }.permutation(2).to_a.map{ |a| a.sort }
    box_walls.each { |wall| all_walls_sq_feet << (wall[0]*wall[1]) }
    smallest_wall = all_walls_sq_feet.sort.first
    total_paper += all_walls_sq_feet.inject{ |sum, w| sum += w } + smallest_wall
  end
end

puts how_much_paper boxes

####### PART 2 #######

def how_much_ribbon boxes
  boxes.inject(0) do |total_ribbon, box|
    box_walls = box.chomp.split("x").map{ |s| s.to_i }.sort
    total_ribbon += box_walls[0..1].inject(0){|sum, d| sum += 2*d } +
                    box_walls.inject(1){|sum, d| sum *= d}
  end
end

puts how_much_ribbon boxes

input = File.readlines('input.txt')

class LightGird
  attr_accessor :grid

  def initialize grid_size
    @grid = build_grid grid_size
  end

  def build_grid grid_size
    Array.new(grid_size){Array.new(grid_size, false)}
  end

  def update_grid instructions
    instructions_hash = get_instructions instructions
    coords = {:a => instructions_hash[:a], :z => instructions_hash[:z]}
    (coords[:a][0]..coords[:z][0]).to_a.each do |row|
      (coords[:a][1]..coords[:z][1]).to_a.each do |column|
        update_light_status instructions_hash[:action], [row, column]
      end
    end
    grid
  end

  def get_instructions instructions_string
    instructions = instructions_string.match(/(\D+\s)(\d+,\d+)(\D+\s)(\d+,\d+)/)
    coords_hash = {}
    coords_hash[:action] = instructions[1].strip
    coords_hash[:a] = instructions[2].split(",").map(&:to_i)
    coords_hash[:z] = instructions[4].split(",").map(&:to_i)
    coords_hash
  end

  def update_light_status action, coord
    hor = coord[0]
    ver = coord[1]
    case action
    when "turn off" then grid[hor][ver] = false
    when "turn on" then grid[hor][ver] = true
    when "toggle" then grid[hor][ver] = grid[hor][ver] == true ? false : true
    end
  end

  def count_lights_on
    grid.flatten.select {|num| num == true }.count
  end

end

lg = LightGird.new 1000
input.each do |instruction|
  lg.update_grid instruction
end
  puts lg.count_lights_on

####### PART 2 #######

class Light
  attr_reader :brightness
   def initialize
     @brightness = 0
   end

   def update_brightness(num)
     @brightness += num
     @brightness = 0 if @brightness < 0
   end
end

class LightGirdImproved < LightGird

  def build_grid grid_size
    Array.new(grid_size){Array.new(grid_size){Light.new}}
  end

  def update_light_status action, coord
    hor = coord[0]
    ver = coord[1]
    case action
    when "turn off"
      grid[hor][ver].update_brightness(-1)
    when "turn on"
      grid[hor][ver].update_brightness(1)
    when "toggle"
      grid[hor][ver].update_brightness(2)
    end
  end

  def count_lights_on
    grid.flatten.inject(0){|sum, light| sum +=  light.brightness}
  end

end

lg = LightGirdImproved.new 1000
input.each do |instruction|
  lg.update_grid instruction
end
puts lg.count_lights_on

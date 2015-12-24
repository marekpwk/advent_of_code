require 'pry'

example = ["123 -> x", "456 -> y", "x AND y -> d", " x OR y -> e", "x LSHIFT 2 -> f",  "y RSHIFT 2 -> g",  "NOT x -> h", "NOT y -> i"]
input = File.readlines('input.txt')

class ElectricBoard

  def initialize instructions
    @instructions = instructions
    @wires = {}
  end

  def build_board
  while @instructions.size > 0
    @instructions.each do |instruction|
      get_instructions(instruction)
    end
  end
    @wires
  end

  def get_instructions(instruction)
    op_instr, dest_wire = instruction.split("->").map(&:strip)
    op_instr = op_instr.split(" ")
    if op_instr.size == 3
      wire_a = is_number?(op_instr[0]) ? op_instr[0].to_i : @wires[op_instr[0]]
      wire_b_or_shift = is_number?(op_instr[2]) ? op_instr[2].to_i : @wires[op_instr[2]]
      if wire_a && wire_b_or_shift
        @wires[dest_wire] = self.send("#{op_instr[1].downcase}_bitwise", wire_a, wire_b_or_shift)
        @instructions.delete(instruction)
      end
    elsif op_instr.size == 2
      wire_a = is_number?(op_instr[1]) ? op_instr[1].to_i : @wires[op_instr[1]]
      if wire_a
      @wires[dest_wire] = self.send("#{op_instr[0].downcase}_bitwise", wire_a)
      @instructions.delete(instruction)
      end
    else
      wire_a = is_number?(op_instr[0]) ? op_instr[0].to_i : @wires[op_instr[0]]
      if wire_a
        @wires[dest_wire] = wire_a
        @instructions.delete(instruction)
      end
    end
  end

  def is_number?(str)
    str.match(/\d+/) ? true : false
  end

  def init_wire(value, wire)
    @instructions.delete(instruction)
  end

  def and_bitwise(number_a, number_b)
    number_a & number_b
  end

  def or_bitwise(number_a, number_b)
    number_a | number_b
  end

  def lshift_bitwise(number, shift)
    number << shift
  end

  def rshift_bitwise(number, shift)
    number >> shift
  end

  def not_bitwise(number)
    65535 - number
  end

end


new_board = ElectricBoard.new input
puts new_board.build_board

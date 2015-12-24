require 'pry'
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
    operation_instr, dest_wire = instruction.split("->").map(&:strip)
    operation_instr = operation_instr.split(" ")
    if operation_instr.size == 3
      wire_a = set_wire(operation_instr[0])
      wire_b_or_shift = set_wire(operation_instr[2])
      if wire_a && wire_b_or_shift
        @wires[dest_wire] = bitwise_operation operation_instr[1], wire_a, wire_b_or_shift
      end
    elsif operation_instr.size == 2
      wire_a = set_wire(operation_instr[1])
      if wire_a
        @wires[dest_wire] = bitwise_operation operation_instr[0], wire_a
      end
    else
      wire_a = set_wire(operation_instr[0])
      if wire_a
        @wires[dest_wire] = wire_a
      end
    end
    @instructions.delete(instruction) if @wires[dest_wire]
  end

  def is_number?(str)
    str.match(/\d+/) ? true : false
  end

  def set_wire(str)
    is_number?(str) ? str : @wires[str]
  end

  def bitwise_operation(operator, number_a, number_b_or_shift=nil)
    operations = {:or => "|", :and => "&", :lshift => "<<", :rshift => ">>", :not => "65535 -"}
    if operator.downcase.to_sym == :not
      eval(operations[:not] << number_a.to_s )
    else
      eval("#{number_a} #{operations[operator.downcase.to_sym]}  #{number_b_or_shift}")
    end
  end
end

new_board = ElectricBoard.new input
puts new_board.build_board

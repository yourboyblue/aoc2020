require_relative 'file_helper'

class Day08
  include FileHelper

  def initialize(data = '08_01.txt')
    @data = read_data(data)
    @pos = 0
    @acc = 0
    @executed = {}

    @switch_positions = {}
    @switched = false
    @try_switches = false
  end

  def run_1
    loop do 
      break if repeat?
      execute
    end

    return @acc
  end

  def run_2
    @try_switches = true

    loop do 
      break if @pos == @data.length
      reset if repeat?
      execute
    end

    return @acc
  end

  def reset
    @acc = 0
    @pos = 0
    @executed = {}
    @switched = false
  end

  def switch?
    return false unless @try_switches
    return false if @switched
    return false if @switch_positions.key?(@pos)

    @switch_positions[@pos] = true
    @switched = true
  end

  def instruction
    mark_executed
    @data[@pos]
  end

  def repeat?
    @executed.key?(@pos)
  end

  def execute
    op, arg = instruction.split(' ')
    arg = Integer(arg)

    case op
    when 'nop' then switch? ? exec_jmp(arg) : exec_nop
    when 'acc' then exec_acc(arg)
    when 'jmp' then switch? ? exec_nop : exec_jmp(arg)
    end
  end

  def mark_executed
    @executed[@pos] = true
  end
  
  def increment(arg = 1)
    @pos += arg
  end

  def accumulate(arg)
    @acc += arg
  end
  
  def exec_nop
    increment
  end

  def exec_acc(arg)
    increment
    accumulate(arg)
  end

  def exec_jmp(arg)
    increment(arg)
  end
end

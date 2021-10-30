require_relative 'file_helper'

class Day09
  include FileHelper

  def self.run
    new.run
  end

  def self.run2
    new.run2
  end

  def initialize(data = '09_01.txt')
    @data = read_data(data).map(&:to_i)
    @sums = {}
  end

  def run2
    target = run # find the target sum by solving day 1

    # range of numbers to sum
    first = 0
    last = 1 
    current = @data[first]

    loop do
      current += @data[last]
      break if current == target && first < last

      # reset if the sum of the current range is too large
      if current >= target
        first += 1
        current = @data[first]
        last = first 
      end

      last += 1
    end
    
    slice = @data.slice(first..last)
    slice.min + slice.max
  end

  def run
    init!

    i = 25
    n = nil
    loop do 
      n = @data[i]
      break if !sum?(n)
      find_sums(i)
      i += 1
    end

    n
  end

  def sum?(n)
    @sums.key?(n)
  end

  def init!
    25.times { |i| find_sums(i) }
  end

  def find_sums(idx)
    i = 0
    while i != idx
      sum = @data[i] + @data[idx]
      found(sum)
      i += 1
    end
  end

  def found(n)
    @sums[n] = true
  end
end


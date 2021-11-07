require_relative 'file_helper'
require 'pry'

class Day14
  include FileHelper

  def initialize
    # test
    # @lines = [
    #   'mask = 000000000000000000000000000000X1001X',
    #   'mem[42] = 100',
    #   'mask = 00000000000000000000000000000000X0XX',
    #   'mem[26] = 1'
    # ].map { |l| parse_line(l, 2) }
      
    @lines = read_data('14_01.txt').map { |l| parse_line(l) }
  end

  def init!
    @mem = {}
    @mask = nil
  end

  def run
    init!
    
    @lines.each do |l| 
      case l
      when Mask
        @mask = l
      when Op
        @mem[l.location] = l.masked_int(@mask)
      end
    end
    
    puts @mem.values.sum
  end

  def run2  
    init!

    @lines.each do |l| 
      case l
      when Mask
        @mask = l
      when Op
        l.decode(@mask).each do |location|
          @mem[location] = l.int
        end
      end
    end

    puts @mem.values.sum
  end

  def parse_line(line, mode = 1)
    if line.match?(/mask/)
      _, mask = line.split(" = ")
      Mask.new(mask)
    else
      location, val = line.scan(/\d+/).map(&:to_i)
      mode == 1 ? Op.new(location, val, bits: val) : Op.new(location, val, bits: location)
    end
  end

  class Mask
    attr_reader :mask_chars

    def initialize(mask)
      @mask_chars = mask.chars
    end

    def masked_bits(bits)
      bits.map.with_index { |bit, i| masked_bit(bit, i) }
    end

    def masked_bit(bit, i)
      mask_chars[i] == 'X' ? bit : mask_chars[i]
    end

    def [](i)
      @mask_chars[i]
    end
  end

  class Op
    attr_reader :location, :int

    def initialize(location, int, bits:)
      @location = location
      @int = int
      @bits = bits
    end

    def bits
      Bits.new(@bits)
    end

    def decode(mask)
      Bits.new(@location).decode(mask)
    end

    def masked_int(mask)
      bits.mask(mask).to_i
    end 
  end

  class Bits
    def initialize(int)
      @int = int
      @arr = to_chars
    end

    def to_chars
      @int.to_s(2).rjust(36, '0').chars
    end

    def mask(mask)
      @arr = mask.masked_bits(to_a)
      @int = cast_i(to_a)
      self
    end

    def decode(mask)
      floating_idxs = []
      static_idxs   = []
      mask.mask_chars.each.with_index { |b, i| b == 'X' ? floating_idxs << i : static_idxs << i }

      addresses = permutations(floating_idxs.length)
      addresses.each do |permutation|
        static_idxs.each do |i|
          # splice the non-floating values back into each permutation
          permutation.insert(i, (v = mask[i]) == '0' ? @arr[i] : 1)
        end
      end
      addresses.map { |a| cast_i(a) }
    end

    # went through a couple of tries here until I realized if you count through all the numbers until you
    # have to carry, you have all the permutations
    def permutations(length)
      permutations = []
      i = 0
      loop do
        perm = i.to_s(2)
        break if perm.length > length
        permutations << perm.rjust(length, '0').chars
        i += 1
      end
      permutations
    end

    def to_a
      @arr
    end

    def to_i
      @int
    end

    def cast_i(arr)
      arr.reverse.map(&:to_i).each_with_index.reduce(0) { |acc, (c, i)| c == 0 ? acc : acc + 2**i  }
    end
  end
end




require_relative 'file_helper'

class Day10
  include FileHelper

  def self.run
    new.run
  end

  def self.run2
    new.run2
  end

  def initialize(data = '10_01.txt')
    j_list = read_data(data).map(&:to_i)
    # Test data
    # j_list = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
    # j_list = [28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3]

    @data = j_list.sort
  end

  def run
    ones = chain.count_diff(1)
    threes = chain.count_diff(3)

    puts ones
    puts threes
    ones * threes
  end

  def chain
    adapters.each_with_object(Chain.new) do |adapter, chain|
      chain.connect(adapter) unless chain.last
      chain.connect(adapter) if adapter.connects?(chain.last)
    end
  end

  def run2
    # make all valid connections between adapters
    make_connections!

    # count chains from the device to the wall
    adapters.reverse.each do |adapter|
      puts "Possible chains from #{adapter.jolts} is #{adapter.possible_chains}"
    end

    adapters.first.possible_chains
  end

  def make_connections!
    adapters.each_with_index do |adapter, a_index|
      i = a_index + 1
      while i < adapters.length && adapters[i].connects?(adapter) do
        adapter.connect!(adapters[i])
        i += 1
      end
    end
  end

  def adapters
    @adapters ||= begin
      wall = 0
      bag = @data
      device = bag.last + 3

      [wall, *bag, device].map { |j| Adapter.new(j) }
    end
  end

  class Chain
    def initialize
      @chain = []
    end

    def connect(adapter)
      @chain << adapter
    end

    def last
      @chain.last
    end

    def count_diff(n)
      @chain.each_cons(2).count { |a, b| b.jolts - a.jolts == n }
    end
  end

  class Adapter
    attr_reader :jolts, :connections

    def initialize(jolts)
      @jolts = jolts
      @connections = []
    end

    def range
      (jolts - 3)..jolts
    end

    def possible_chains
      @possible_chains ||= connections.any? ? connections.sum { |adapter| adapter.possible_chains } : 1
    end

    def connect!(adapter)
      @connections << adapter
    end

    def connects?(adapter)
      return false if self == adapter

      range.cover?(adapter.jolts)
    end
  end
end


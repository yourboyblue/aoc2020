require 'pry'
require_relative 'file_helper'

class Day12
  include FileHelper

  def self.run
    new.run
  end

  attr_accessor :x, :y, :wx, :wy

  def initialize(data = '12_01.txt')
    @data = read_data(data)

    # Test data
    # @data = [
    #   'F10',
    #   'N3',
    #   'F7',
    #   'R90',
    #   'F11',
    # ]
    
    @bearing = 'E'
    @x = 0
    @y = 0
    @wx = 10
    @wy = 1
  end

  DIRS = %w(N E S W)
  def turn_right(deg)
    i = DIRS.find_index(@bearing)
    i += (deg / 90)
    @bearing = DIRS[i % 4]
  end

  def turn_left(deg)
    i = DIRS.find_index(@bearing)
    i -= (deg / 90)
    @bearing = DIRS[i % 4]
  end

  def rotate(dir, deg)
    (deg / 90).times { rotate_90(dir) }
  end

  # rotates waypoint around ship
  def rotate_90(dir)
    dx = @wx - @x
    dy = @wy - @y

    case dir
    when 'R'
      @wx = @x + dy 
      @wy = @y + -dx
    when 'L' 
      @wx = @x + -dy 
      @wy = @y + dx
    else
      raise
    end
  end

  def move(dir, units)
    case dir
    when 'N'
      @wy += units
    when 'E'
      @wx += units
    when 'S'
      @wy -= units
    when 'W'
      @wx -= units
    when 'F'
      # DAY 1 move(@bearing, units)
      units.times { waypoint_move }
    when 'L'
      rotate('L', units)
    when 'R'
      rotate('R', units)
    end
  end

  def waypoint_move
    dx = @wx - @x
    dy = @wy - @y
    @x += dx 
    @y += dy
    @wx += dx
    @wy += dy
  end

  def instructions
    @data.map do |str|
      matches = str.match(/([A-Z]+)(\d+)/)
      [matches[1], matches[2].to_i]
    end
  end

  def run
    instructions.each { |dir, units| move(dir, units) }
    puts "X: #{@x}"
    puts "Y: #{@y}"
    puts @x.abs + @y.abs
  end
end

Day12.new.run


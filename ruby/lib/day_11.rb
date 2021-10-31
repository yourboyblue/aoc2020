require 'pry'
# frozen_string_literal: true

require_relative 'file_helper'

class Day11
  include FileHelper

  def self.run
    new.run
  end

  def self.run2
    new.run2
  end

  def initialize(data = '11_01.txt')
    @data = read_data(data)

    # Test Data
    # @data = [
    #   "#.##.##.##",
    #   "#######.##",
    #   "#.#.#..#..",
    #   "####.##.##",
    #   "#.##.##.##",
    #   "#.#####.##",
    #   "..#.#.....",
    #   "##########",
    #   "#.######.#",
    #   "#.#####.##",
    # ]

    @row_length = @data.first.length
    @seating = []
    populate_seats
  end

  def run
    loop do
      did_change = false 
      seating.each do |seat|
        # DAY 1 change = seat.set_next_state(adjacent_seats(seat))
        change = seat.set_next_state(visible_seats(seat))
        did_change = true if change
      end

      seating.each(&:commit_change!)
      break if !did_change
    end

    puts seating.count(&:occupied?)
  end

  def seating
    @seating
  end

  def print
    seating.each_slice(@row_length) do |seats|
      puts seats.map(&:state).join
    end
    puts "\n\n"
  end

  def indexed_seating
    @indexed ||= seating.map { |s| ["x#{s.x}y#{s.y}", s] }.to_h
  end

  def find_seat(c)
    x, y = c
    indexed_seating["x#{x}y#{y}"]
  end

  DIRECTIONS = %i(tl t tr r br b bl l)
  
  def adjacent_seats(seat)
    seats = DIRECTIONS.map { |dir| seat.send(dir) }
    seats = seats.map { |s| find_seat(s) }
    seats.compact!
    seats
  end

  def visible_seats(seat)
    DIRECTIONS.map { |d| find_seat_in_direction(seat, d) }.compact
  end

  def find_seat_in_direction(s, dir)
    next_visible = find_seat(s.send(dir))
    loop do
      break if next_visible.nil? || next_visible.state != '.'
      next_visible = find_seat(next_visible.send(dir))
    end
    next_visible
  end

  def populate_seats
    @data.each_with_index do |row, y|
      row.each_char.with_index do |seat_state, x| 
        @seating << Seat.new(state: seat_state, x: x, y: y)
      end
    end
  end

  class Seat
    attr_reader :state, :next_state, :x, :y

    def initialize(state:, x:, y:)
      @state = state
      @next_state = state
      @x = x
      @y = y
    end

    def tl
      safe_find_seat([x - 1, y - 1])
    end

    def t
      safe_find_seat([x, y - 1])
    end

    def tr
      safe_find_seat([x + 1, y - 1])
    end

    def r
      safe_find_seat([x + 1, y])
    end

    def br
      safe_find_seat([x + 1, y + 1])
    end

    def b
      safe_find_seat([x, y + 1])
    end

    def bl
      safe_find_seat([x - 1, y + 1])
    end

    def l
      safe_find_seat([x - 1, y])
    end

    def safe_find_seat(coords)
      return nil if coords.any?(:negative?)

      coords
    end
    
    def floor?
      @inital == '.'
    end

    def occupied?
      @state == '#'
    end

    def empty?
      @state == 'L'
    end

    def commit_change!
      @state = @next_state
    end

    def set_next_state(adjacent_seats)
      if floor?
        @next_state = @state
      elsif empty?
        @next_state = '#' if adjacent_seats.none?(&:occupied?)
      elsif occupied?
        # DAY 1 @next_state = 'L' if adjacent_seats.count(&:occupied?) > 3
        @next_state = 'L' if adjacent_seats.count(&:occupied?) > 4
      end
      
      @state != @next_state
    end
  end
end

Day11.run
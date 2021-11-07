require 'pry'
require_relative 'file_helper'

class Day16
  include FileHelper

  def self.run
    new.scan
  end

  def initialize
    data = read_data('16_01.txt')
    b1, b2 = data.each_index.select {|i| data[i] == '' }
    @fields = data.slice(0...b1)
    @ticket = data.slice((b1+2)...b2)
    @tickets = data.slice((b2+2)..-1).map do |ticket|
      ticket.scan(/\d+/).map(&:to_i)
    end
  end

  def ranges
    @fields.each_with_object({}) do |field, parsed|
      label, ranges = field.split(':')
      ranges = ranges.scan(/\d+/).map(&:to_i)
      parsed[label] = ranges.each_slice(2).map { |a, z| a..z }
    end
  end

  def scan
    puts TicketScanner.new(ranges, @tickets).invalid_tickets.sum
  end

  class TicketScanner
    def initialize(ranges, tickets)
      @ranges = ranges
      @tickets = tickets
    end

    def invalid_tickets
      @tickets.flat_map do |ticket|
        ticket.select do |number|
          @ranges.values.all? do |range|
            range.none? do |segment|
              segment.cover?(number)
            end
          end
        end
      end
    end
  end
end
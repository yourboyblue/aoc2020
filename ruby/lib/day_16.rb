require 'pry'
require_relative 'file_helper'

class Day16
  include FileHelper

  def initialize
    data = read_data('16_01.txt')

    # indexes of blanks in the notes
    b1, b2 = data.each_index.select {|i| data[i] == '' }
    
    @ranges = data.slice(0...b1).each_with_object({}) do |field, parsed|
      label, ranges = field.split(':')
      ranges = to_arr_i(ranges)
      parsed[label] = ranges.each_slice(2).map { |a, z| a..z }
    end
    
    @my_ticket = to_arr_i(data.slice((b1+2)...b2)[0])

    @tickets = data.slice((b2+2)..-1).map do |ticket|
      to_arr_i(ticket)
    end
  end

  def run1
    puts invalid_numbers.sum
  end

  def run2
    puts mark_tickets
  end

  def to_arr_i(arr)
    arr.scan(/\d+/).map(&:to_i)
  end

  def mark_tickets
    marks = Hash.new { |h,k| h[k] = [] }
    tickets_to_check = [@my_ticket, *valid_tickets]

    # across each ticket, record if the ticket number location is a match for the label
    all = tickets_to_check.each_with_index do |ticket, ti|
      @ranges.each do |label, matchers|
        marks[label] << []
        ticket.each_with_index do |number, ni|
          marks[label][ti][ni] = matchers.any? { |m| m.cover?(number) }
        end
      end
    end

    # reduce to just the number locations that are a match for the label on every ticket
    marks.transform_values! do |checks|
      tickets_to_check.length.times.select do |i|
        checks.all? { |c| c[i] }
      end
    end

    # working backward from a label that only matches one location, to the next that only matches two, etc...
    # assign the only valid location on a ticket for the label
    reduced = {}
    assigned = []
    @my_ticket.length.times do |i|
      k, v = marks.find { |k, v| v.length == i + 1}
      reduced[k] = (v - assigned)[0]
      assigned << reduced[k]
    end
    
    # extract the value for the problem
    ticket_locations = reduced.select { |k, v| k.match?(/departure/) }.values
    @my_ticket.values_at(*ticket_locations).reduce(:*)
  end

  def valid_tickets
    @tickets.reject do |ticket|
      ticket.any? do |number|
        @ranges.values.all? do |range|
          range.none? do |segment|
            segment.cover?(number)
          end
        end
      end
    end
  end

  def invalid_numbers
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
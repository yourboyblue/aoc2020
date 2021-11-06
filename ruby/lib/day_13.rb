class Day13
  def self.run(data, start = nil)
    buses = data.split(',').each_with_object([]).with_index do |(bus, acc), i|
      acc << [bus.to_i, i] unless bus == 'x'
    end

    puts "PART 1: #{part1(start, buses)}"
    puts "PART 2: #{sieve(buses)}"
  end

  def self.part1(start, buses)
    buses.map(&:first).map { |bus| [bus, -(start % bus - bus)] }.min_by { |b, w| w }.reduce(:*)
  end

  # I couldn't actually get to this solution on my own. I couldn't quite figure out how to use products while
  # dealing with the remainder.
  # 
  # https://en.wikipedia.org/wiki/Chinese_remainder_theorem#Search_by_sieving
  def self.sieve(buses)
    first_bus, *remaining_buses = buses
    remaining_buses = remaining_buses.sort_by(&:last)

    time = period = first_bus[0]
    remaining_buses.each do |bus, offset|
      while (time + offset) % bus != 0 do
        time += period
      end
      period *= bus 
    end

    time
  end
end




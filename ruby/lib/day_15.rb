class Day15
  def initialize(starts)
    @game = Game.new(starts.split(',').map(&:to_i))
  end

  def run
    2020.times do
      @game.take_turn
    end
    puts @game.last
  end

  def run2
    30000000.times do
      @game.take_turn
    end
    puts @game.last
  end

  class Game
    attr_reader :last

    def initialize(starts)
      @starts  = starts
      @records = Hash.new { |h, k| h[k] = [] }
      @last = nil
      @turn = 0
    end

    def take_turn
      n = @starts[@turn]

      if n
        speak(n)
      elsif @records[@last].one?
        speak(0)
      else
        speak(diff(@last))
      end

      @turn += 1
    end

    def speak(n)
      @last = n
      @records[n] << @turn
    end

    def diff(n)
      a, b = @records[n].last(2)
      b - a
    end
  end
end
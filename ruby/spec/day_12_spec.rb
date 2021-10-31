require_relative 'spec_helper'
require_relative '../lib/day_12'

RSpec.describe Day12 do
   describe 'waypoint rotation' do
      it 'rotates right' do
        ship = Day12.new
        ship.x = 1
        ship.y = 1
        ship.wx = 2
        ship.wy = 2
        
        ship.rotate('R', 90)

        expect(ship.wx).to eq(2)
        expect(ship.wy).to eq(0)
      end

      it 'rotates right at origin' do
        ship = Day12.new
        ship.x = 1
        ship.y = 1
        ship.wx = 0
        ship.wy = 0
        
        ship.rotate('R', 270)

        expect(ship.wx).to eq(2)
        expect(ship.wy).to eq(0)
      end

      it 'rotates right at boundary' do
        ship = Day12.new
        ship.x = 1
        ship.y = 0
        ship.wx = 2
        ship.wy = 0
        
        ship.rotate('R', 180)

        expect(ship.wx).to eq(0)
        expect(ship.wy).to eq(0)
      end
   end
end
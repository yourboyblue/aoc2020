require_relative 'spec_helper'
require_relative '../lib/day_08'

RSpec.describe Day08 do
  path = '08_test.txt'

  it 'returns the correct result for test data' do
    result = described_class.run_1(path)
    expect(result).to eq(5)
  end
end



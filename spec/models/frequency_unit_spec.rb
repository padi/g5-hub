require 'rails_helper'

describe FrequencyUnit do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :minutes_multiplier }

  describe :singular_name do
    [%w(Minutes Minute), [nil, nil], %w(Hour Hour)].each do |test|
      it "converts #{test.first} to #{test.last}" do
        expect(FrequencyUnit.new(name: test.first).singular_name).to eq(test.last)
      end
    end
  end
end
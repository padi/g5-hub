require 'rails_helper'

describe JobSetting do
  it { is_expected.to belong_to :integration_setting }
  it { is_expected.to belong_to :frequency_unit }
  it { is_expected.to validate_presence_of :frequency_unit_id }
  it { is_expected.to validate_numericality_of(:frequency).only_integer.is_greater_than_or_equal_to(1) }

  describe :frequency_in_minutes do
    specify { expect(Fabricate.build(:job_setting, frequency: 3, frequency_unit: Fabricate.build(:frequency_unit, minutes_multiplier: 1)).frequency_in_minutes).to eq(3) }
    specify { expect(Fabricate.build(:job_setting, frequency: 3, frequency_unit: Fabricate.build(:frequency_unit, minutes_multiplier: 60)).frequency_in_minutes).to eq(180) }
  end
end
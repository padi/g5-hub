class JobSetting < ActiveRecord::Base
  belongs_to :frequency_unit
  belongs_to :integration_setting

  validates :frequency_unit_id, presence: true
  validates :frequency, numericality: {only_integer: true, greater_than_or_equal_to: 1}

  def frequency_in_minutes
    self.frequency * self.frequency_unit.minutes_multiplier
  end
end
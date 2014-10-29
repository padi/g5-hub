class FrequencyUnit < ActiveRecord::Base
  validates :name, presence: true
  validates :minutes_multiplier, presence: true

  def singular_name
    self.name.try(:gsub, /s$/, '')
  end
end
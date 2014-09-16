class CustomIntegrationSetting < ActiveRecord::Base
  belongs_to :integration_setting
  validates :name, presence: true
  validates :value, presence: true
end
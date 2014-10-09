class LocationsIntegrationSetting < ActiveRecord::Base
  belongs_to :location
  belongs_to :clients_integration_setting
  belongs_to :integration_setting

  accepts_nested_attributes_for :integration_setting, allow_destroy: true

  validates :location_id, uniqueness: {scope: :clients_integration_setting_id}
end
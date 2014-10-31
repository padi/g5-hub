class LocationsIntegrationSetting < ActiveRecord::Base
  belongs_to :location
  belongs_to :clients_integration_setting
  belongs_to :integration_setting

  RECORD_TYPE = ENV['APP_NAMESPACE'] + "-lis"
  after_save :set_urn

  accepts_nested_attributes_for :integration_setting, allow_destroy: true

  validates :location_id, uniqueness: {scope: :clients_integration_setting_id}

  def set_urn
    return unless self.urn.blank?
    update_attributes(urn: "#{RECORD_TYPE}-#{hashed_id}")
  end

  def hashed_id
    "#{self.created_at.to_i}#{self.id}".to_i.to_s(36)
  end

  def to_param
    self.urn
  end
end
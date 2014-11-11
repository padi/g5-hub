class LocationsIntegrationSetting < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  belongs_to :location
  belongs_to :clients_integration_setting
  belongs_to :integration_setting

  RECORD_TYPE = ENV['APP_NAMESPACE'] + "-lis"
  after_create :set_urn

  accepts_nested_attributes_for :integration_setting, allow_destroy: true

  validates :location_id, uniqueness: {scope: :clients_integration_setting_id}

  attr_accessor :current_job

  delegate :uid, :urn, :state, :created_at, :updated_at, :message, :logs_url, to: :current_job, prefix: :current_job, allow_nil: true

  def uid
    client_location_locations_integration_setting_url(self.clients_integration_setting.client, self.location, self)
  end

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
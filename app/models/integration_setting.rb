class IntegrationSetting < ActiveRecord::Base
  attr_accessor :override
  has_one :job_setting, dependent: :destroy
  has_many :custom_integration_settings, dependent: :destroy
  accepts_nested_attributes_for :custom_integration_settings, allow_destroy: true, reject_if: lambda { |attrs| attrs[:frequency].blank? }
  accepts_nested_attributes_for :job_setting, allow_destroy: true, reject_if: lambda { |attrs| attrs[:frequency].blank? }

  # either has one client_integration_setting or one location_integration_setting, but not both
  has_one :clients_integration_setting
  has_one :locations_integration_setting

  with_options unless: :override do |integration_setting|
    integration_setting.validates :strategy_name, presence: true
    integration_setting.validates :vendor_endpoint, presence: true
  end

  def custom_integration_settings_as_hash
    self.custom_integration_settings.inject({}) do |result, element|
      result[element.name.to_sym] = element.value
      result
    end
  end

  delegate :frequency_in_minutes, to: :job_setting, allow_nil: true

  def to_settings_hash
    settings_hash                            = self.attributes.clone.merge(custom_integration_settings_as_hash)
    settings_hash[:job_frequency_in_minutes] = frequency_in_minutes if frequency_in_minutes
    settings_hash
  end
end
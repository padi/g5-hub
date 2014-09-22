class IntegrationSetting < ActiveRecord::Base
  has_many :custom_integration_settings, dependent: :destroy
  belongs_to :location

  accepts_nested_attributes_for :custom_integration_settings, allow_destroy: true

  validates :inventory_service_url, presence: true
  validates :inventory_service_auth_token, presence: true
  validates :etl_strategy_name, presence: true
  validates :lead_strategy_name, presence: true
  validates :inventory_vendor_endpoint, presence: true
  validates :lead_vendor_endpoint, presence: true

  def custom_integration_settings_as_hash
    self.custom_integration_settings.inject({}) do |result, element|
      result[element.name.to_sym] = element.value
      result
    end
  end
end
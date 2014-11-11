class ClientsIntegrationSetting < ActiveRecord::Base
  include ClientIntegrationSettingJobLoader

  INVENTORY_VENDOR_ACTION = 'inventory'
  LEAD_VENDOR_ACTION      = 'lead'
  VENDOR_ACTIONS          = [INVENTORY_VENDOR_ACTION, LEAD_VENDOR_ACTION]
  belongs_to :client
  belongs_to :vendor
  belongs_to :integration_setting, dependent: :destroy
  has_many :locations_integration_settings
  has_many :locations, through: :locations_integration_settings
  validates :vendor_action, inclusion: {in: VENDOR_ACTIONS}, allow_nil: false

  accepts_nested_attributes_for :integration_setting, allow_destroy: true

  def inventory?
    INVENTORY_VENDOR_ACTION == self.vendor_action
  end
end
Fabricator(:clients_integration_setting) do
  vendor { Vendor.where(name: 'SiteLink').first_or_create }
  vendor_action { ClientsIntegrationSetting::INVENTORY_VENDOR_ACTION }
  client
  integration_setting
end

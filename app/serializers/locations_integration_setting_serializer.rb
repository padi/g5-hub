class LocationsIntegrationSettingSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :location_id, :urn, :uid

  def attributes
    data                 = super
    data[:vendor]        = object.clients_integration_setting.vendor.name
    data[:vendor_action] = object.clients_integration_setting.vendor_action
    data.merge(integration_setting_merged_hash)
  end

  def integration_setting_merged_hash
    merged_hash   = object.clients_integration_setting.integration_setting.to_settings_hash
    override_hash = object.integration_setting.try(:to_settings_hash) || {}
    override_hash.each do |key, value|
      merged_hash[key] = value unless value.blank?
    end
    merged_hash
  end

  def uid
    client_location_locations_integration_setting_url(object.clients_integration_setting.client, object.location, object, format: :json)
  end
end
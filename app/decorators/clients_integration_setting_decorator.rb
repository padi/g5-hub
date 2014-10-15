class ClientsIntegrationSettingDecorator < Draper::Decorator
  include HentryableDates

  def summary
    "#{object.client.name} - #{object.vendor.name} - #{object.vendor_action}"
  end

  delegate_all
end


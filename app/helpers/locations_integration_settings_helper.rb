module LocationsIntegrationSettingsHelper
  def next_scheduled_run(locations_integration_settings)
    return DateTime.now unless  locations_integration_settings.current_job
    locations_integration_settings.current_job.created_at + locations_integration_settings.effective_job_setting.frequency_in_minutes.minutes
  end

  def current_inventory_url(locations_integration_settings)
    base_url = locations_integration_settings.custom_value('inventory_service_url')
    "#{base_url}/#{locations_integration_settings.location.urn}/storage_units"
  end
end
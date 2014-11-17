class LocationsIntegrationSettingDecorator < Draper::Decorator
  include HentryableDates

  def frequency
    return unless job_setting = object.effective_job_setting
    h.pluralize(job_setting.frequency, job_setting.frequency_unit.singular_name)
  end

  def next_scheduled_run
    return DateTime.now unless  object.current_job
    (object.current_job.created_at + object.effective_job_setting.frequency_in_minutes.minutes).to_s(:human)
  end

  def current_inventory_url
    base_url = object.custom_value('inventory_service_url')
    "#{base_url}/#{object.location.urn}/storage_units"
  end

  def current_job_state_span
     h.content_tag(:span, class: current_job_state_class) do
       object.current_job_state
     end
  end

  def current_job_state_class
    return 'job-error' if object.current_job_error_state
    return 'job-success' if object.current_job_success_state
  end

  delegate_all
end


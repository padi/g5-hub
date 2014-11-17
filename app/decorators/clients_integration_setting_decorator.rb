class ClientsIntegrationSettingDecorator < Draper::Decorator
  include HentryableDates

  def summary
    "#{object.client.name} - #{object.vendor.name} - #{object.vendor_action}"
  end

  def job_errors
    return unless object.inventory?
    error_count = object.job_stat_error_count || 0
    h.content_tag(:span, class: "#{error_count > 0 ? 'job-error' : ''}") do
      "#{error_count} of #{object.locations.count}"
    end
  end

  delegate_all
end


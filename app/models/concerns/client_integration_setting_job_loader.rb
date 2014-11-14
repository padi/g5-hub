module ClientIntegrationSettingJobLoader
  extend ActiveSupport::Concern

  def load_current_jobs_by_location
    jobs = G5::Jobbing::JobRetriever.new(location_setting_urns: self.locations_integration_settings.collect(&:urn)).perform
    self.locations_integration_settings.each do |location_settings|
      location_settings.current_job = jobs.detect { |job| location_settings.uid == job.integration_setting_uid }
    end
  end
end
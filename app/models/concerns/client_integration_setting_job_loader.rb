module ClientIntegrationSettingJobLoader
  extend ActiveSupport::Concern

  def load_current_jobs_by_location
    jobs = Jobs::JobRetriever.new(locations_integration_settings: self.locations_integration_settings).perform
    self.locations_integration_settings.each do |location_settings|
      location_settings.current_job = jobs.detect { |job| location_settings.uid == job.integration_setting_uid }
    end
  end
end
module ClientIntegrationSettingJobLoader
  extend ActiveSupport::Concern

  def load_current_jobs_by_location
    resp = JobRetriever.new(locations_integration_settings: self.locations_integration_settings).perform
    binding.pry
  end
end
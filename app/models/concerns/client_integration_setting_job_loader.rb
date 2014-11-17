module ClientIntegrationSettingJobLoader
  extend ActiveSupport::Concern

  def load_current_jobs_by_location
    jobs = G5::Jobbing::JobRetriever.new(location_setting_urns: self.locations_integration_settings.collect(&:urn)).perform
    self.locations_integration_settings.each do |location_settings|
      location_settings.current_job = jobs.detect { |job| location_settings.urn == job.integration_setting_urn }
    end
  end

  module ClassMethods
    def add_job_stats(client_settings)
      job_stats = G5::Jobbing::JobStatRetriever.new(rollup_by: job_rollup_by(client_settings)).perform
      client_settings.each do |client_setting|
        client_setting.job_stat = job_stats[client_setting.id]
      end
    end

    def job_rollup_by(client_settings)
      client_settings.each_with_object({}) { |client_setting, result| result[client_setting.id] = client_setting.locations_integration_settings.collect(&:urn) }
    end
  end
end
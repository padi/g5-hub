class Jobs::JobRetriever
  include Jobs::AccessToken
  attr_accessor :locations_integration_settings

  def initialize(params={})
    self.locations_integration_settings = params[:locations_integration_settings]
  end

  def perform
    response = HTTParty.get(jobs_url_for_locations,
                            {query:   {access_token: get_access_token},
                             headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}}
    )
    JSON.parse(response.body)['jobs'].collect { |job_hash| Jobs::Job.new(job_hash) }
  end

  def jobs_url_for_locations
    "#{ENV['JOBS_URL']}/api/v1/jobs?current=true&integration_setting_uid=#{CGI.escape(locations_as_parameter)}"
  end

  def locations_as_parameter
    "[#{self.locations_integration_settings.collect(&:uid).join(',')}]"
  end
end
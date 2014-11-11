module LogHelper
  def logs_url_by_job(job)
    return 'ENV[LOGS_BY_JOB_URL] not set!' if logs_by_job_url.blank?
    logs_by_job_url.gsub('{{JOB_ID}}', "#{job.urn}")
  end

  def logs_by_job_url
    ENV['LOGS_BY_JOB_URL']
  end
end
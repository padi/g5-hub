class WebhookPoster
  HEROKU_APP_NAME_MAX_LENGTH = 30
  CMS_RECORD_TYPE            = ENV["APP_NAMESPACE"] + "-cms"
  CPAS_RECORD_TYPE           = ENV["APP_NAMESPACE"] + "-cpas"
  CPNS_RECORD_TYPE           = ENV["APP_NAMESPACE"] + "-cpns"
  JOBS_RECORD_TYPE           = ENV["APP_NAMESPACE"] + "-jobs"

  def initialize(client)
    @client = client
  end

  def post_configurator_webhook
    if url = ENV["CONFIGURATOR_WEBHOOK_URL"]
      post(url)
    end
  end

  def post_client_update_webhooks
    Rails.logger.info("posting to #{domain_for(CMS_RECORD_TYPE)}#{ENV['CMS_UPDATE_PATH']}")
    post("#{domain_for(CMS_RECORD_TYPE)}#{ENV["CMS_UPDATE_PATH"]}")

    Rails.logger.info("posting to #{domain_for(CPAS_RECORD_TYPE)}#{ENV['G5_UPDATABLE_PATH']}")
    post("#{domain_for(CPAS_RECORD_TYPE)}#{ENV["G5_UPDATABLE_PATH"]}", client_uid: client_uid)

    Rails.logger.info("posting to #{domain_for(CPNS_RECORD_TYPE)}#{ENV['G5_UPDATABLE_PATH']}")
    post("#{domain_for(CPNS_RECORD_TYPE)}#{ENV["G5_UPDATABLE_PATH"]}", client_uid: client_uid)

    post_client_updates_to_centralized
  end

  private

  def client_uid
    "https://" +
        (ENV["HEROKU_APP_NAME"] || "g5-hub") +
        ".herokuapp.com" +
        Rails.application.routes.url_helpers.client_path(@client)
  end

  def domain_for(type)
    "https://#{converted_urn(type)}.herokuapp.com"
  end

  def post_client_updates_to_centralized
    [:jobs_url, :inventory_etl_url, :vendor_leads_url].each do |url_method|
      url = send(url_method)
      unless url.blank?
        Rails.logger.info("posting to #{url}/#{ENV['G5_UPDATABLE_PATH']}")
        post("#{url}#{ENV['G5_UPDATABLE_PATH']}", client_uid: client_uid)
      end
    end
  end

  def jobs_url
    ENV['JOBS_URL']
  end

  def inventory_etl_url
    ENV['INVENTORY_ETL_URL']
  end

  def vendor_leads_url
    ENV['VENDOR_LEADS_URL']
  end

  def post(url, params={})
    begin
      Webhook.post(url, params)
    rescue RuntimeError, ArgumentError => e
      @client.logger.error e
    end
  end

  def converted_urn(type)
    @client.urn.gsub(Client::RECORD_TYPE, type)[0...HEROKU_APP_NAME_MAX_LENGTH]
  end
end

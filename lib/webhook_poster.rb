class WebhookPoster
  HEROKU_APP_NAME_MAX_LENGTH = 30
  CMS_RECORD_TYPE  = "g5-cms"
  CPAS_RECORD_TYPE = "g5-cpas"
  CPNS_RECORD_TYPE = "g5-cpns"

  def initialize(client)
    @client = client
  end

  def post_configurator_webhook
    if url = ENV["G5_CONFIGURATOR_WEBHOOK_URL"]
      post(url)
    end
  end

  def post_client_update_webhooks
    post("#{domain_for(CMS_RECORD_TYPE)}#{ENV["CMS_UPDATE_PATH"]}")
    post("#{domain_for(CPAS_RECORD_TYPE)}#{ENV["G5_UPDATABLE_PATH"]}", client_uid: client_uid)
    post("#{domain_for(CPNS_RECORD_TYPE)}#{ENV["G5_UPDATABLE_PATH"]}", client_uid: client_uid)
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

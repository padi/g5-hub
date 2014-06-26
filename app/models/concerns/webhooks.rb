module Webhooks
  extend ActiveSupport::Concern

  CMS_RECORD_TYPE  = "g5-cms"
  CPAS_RECORD_TYPE = "g5-cpas"
  CPNS_RECORD_TYPE = "g5-cpns"

  included do
    after_save :post_configurator_webhook
    after_save :post_client_update_webhooks
  end

private

  def post_configurator_webhook
    if url = ENV["G5_CONFIGURATOR_WEBHOOK_URL"]
      post(url)
    end
  end

  def post_client_update_webhooks
    unless id_changed?
      post("#{client_domain_for(CMS_RECORD_TYPE)}#{ENV["CMS_UPDATE_PATH"]}")
      post("#{client_domain_for(CPAS_RECORD_TYPE)}#{ENV["CPAS_UPDATE_PATH"]}", urn: urn)
      post("#{client_domain_for(CPNS_RECORD_TYPE)}#{ENV["CPNS_UPDATE_PATH"]}", urn: urn)
    end
  end

  def client_domain_for(type)
    "https://#{urn.gsub(Client::RECORD_TYPE, type)}.herokuapp.com"
  end

  def post(url, params={})
    begin
      Webhook.post(url, params)
    rescue RuntimeError, ArgumentError => e
      logger.error e
    end
  end
end

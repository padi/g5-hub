module Webhooks
  extend ActiveSupport::Concern

  included do
    after_save :post_configurator_webhook
    after_save :post_client_update_webhooks
  end

private

  def post_configurator_webhook
    post(url) if url = ENV["G5_CONFIGURATOR_WEBHOOK_URL"]
  end

  def post_client_update_webhooks
    if id_changed?
      post(cms_path)
      post(cpns_path)
      post(cpas_path)
    end
  end

  def cms_path
    "#{client_domain_for(Client::CMS_RECORD_TYPE)}#{ENV["CMS_UPDATE_PATH"]}"
  end

  def cpas_path
    "#{client_domain_for(Client::CPAS_RECORD_TYPE)}#{ENV["CPAS_UPDATE_PATH"]}"
  end

  def cpns_path
    "#{client_domain_for(Client::CPNS_RECORD_TYPE)}#{ENV["CPNS_UPDATE_PATH"]}"
  end

  def client_domain_for(type)
    "https://#{urn.gsub(Client::RECORD_TYPE, type)}.herokuapp.com"
  end

  def post(url)
    begin
      Webhook.post(url)
    rescue RuntimeError, ArgumentError => e
      logger.error e
    end
  end
end

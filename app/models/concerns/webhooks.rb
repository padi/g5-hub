module Webhooks
  extend ActiveSupport::Concern

  included do
    after_save :post_configurator_webhook, :post_cms_webhook
  end

  def post_configurator_webhook
    url = ENV["G5_CONFIGURATOR_WEBHOOK_URL"]
    post(url) if url
  end

  def post_cms_webhook
    return if id_changed? #do nothing if this is a new record
    post("#{client_cms_domain}#{ENV["CMS_UPDATE_PATH"]}")
  end

  def client_cms_domain
    "https://#{urn.gsub(Client::RECORD_TYPE, Client::CMS_RECORD_TYPE)}.herokuapp.com"
  end

  def post(url)
    begin
      Webhook.post(url)
    rescue RuntimeError, ArgumentError => e
      logger.error e
    end
  end
end

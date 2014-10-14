class WebhookPosterJob
  extend HerokuResqueAutoscaler if Rails.env.production?

  @queue = :webhooker

  def self.perform(client_id, action)
    client = Client.find(client_id)
    Rails.logger.info("firing off the webhookposter")
    WebhookPoster.new(client).send(action)
  end
end

class WebhookPosterJob
  extend HerokuResqueAutoscaler if Rails.env.production?

  @queue = :webhooker

  def self.perform(client_id, action)
    client = Client.find(client_id)
    WebhookPoster.new(client).send(action)
  end
end

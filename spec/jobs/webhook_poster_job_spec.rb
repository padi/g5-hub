require "rails_helper"

describe WebhookPosterJob do
  let!(:client) { Fabricate(:client) }
  let(:webhook_poster) { double(post_configurator_webhook: nil) }

  before { WebhookPoster.stub(new: webhook_poster) }

  describe '#perform' do
    after { WebhookPosterJob.perform(client.id, :post_configurator_webhook) }

    it "instantiates WebhookPoster with the client" do
      expect(WebhookPoster).to receive(:new).with(client)
    end

    it "calls post_configurator_webhook on the instantiated object" do
      expect(webhook_poster).to receive(:send).with(:post_configurator_webhook)
    end
  end
end

require "rails_helper"

describe WebhookPoster do
  let(:webhook_poster) { described_class.new(client) }

  before { Webhook.stub(:post) }

  describe "#post_configurator_webhook" do
    let(:client) { double(logger: double(error: true)) }

    subject { webhook_poster.post_configurator_webhook }

    context "a configurator webhook url" do
      before { stub_const("ENV", { "G5_CONFIGURATOR_WEBHOOK_URL" => "Foo" }) }

      context "a valid url" do
        it "posts via Webhook" do
          Webhook.should_receive(:post)
          subject
        end
      end

      context "an argument error" do
        before { Webhook.stub(:post).and_raise(ArgumentError.new) }

        it { should be_true }
      end

      context "a runtime error" do
        before { Webhook.stub(:post).and_raise(RuntimeError.new) }

        it { should be_true }
      end
    end

    context "no configurator webhook url" do
      before { stub_const("ENV", { "G5_CONFIGURATOR_WEBHOOK_URL" => nil }) }

      it "does not post via Webhook" do
        Webhook.should_not_receive(:post)
        subject
      end
    end
  end

  describe "#post_client_update_webhooks" do
    let(:client) { Fabricate(:client)}
    let(:app_length) { WebhookPoster::HEROKU_APP_NAME_MAX_LENGTH }
    let(:record_type) { Client::RECORD_TYPE }

    let(:cms_domain) do
      client.urn.gsub(record_type, WebhookPoster::CMS_RECORD_TYPE)[0...app_length]
    end
    let(:cpas_domain) do
      client.urn.gsub(record_type, WebhookPoster::CPNS_RECORD_TYPE)[0...app_length]
    end
    let(:cpns_domain) do
      client.urn.gsub(record_type, WebhookPoster::CPAS_RECORD_TYPE)[0...app_length]
    end

    subject { webhook_poster.post_client_update_webhooks }

    context "a valid request" do
      after { subject }

      it "posts via Webhook" do
        Webhook.should_receive(:post).with(
          "https://#{cms_domain}.herokuapp.com/foo", {})
      end

      it "posts to the cpas" do
        Webhook.should_receive(:post).with(
          "https://#{cpas_domain}.herokuapp.com/foo", client_uid: "https://g5-hub.herokuapp.com/clients/#{client.urn}")
      end

      it "posts to the cpns" do
        Webhook.should_receive(:post).with(
          "https://#{cpns_domain}.herokuapp.com/foo", client_uid: "https://g5-hub.herokuapp.com/clients/#{client.urn}")
      end
    end

    context "an argument error" do
      before { Webhook.stub(:post).and_raise(ArgumentError.new) }

      it { should be_true }
    end

    context "a runtime error" do
      before { Webhook.stub(:post).and_raise(RuntimeError.new) }

      it { should be_true }
    end
  end
end

require "rails_helper"

describe WebhookPoster do
  let(:webhook_poster) { described_class.new(client) }

  before { Webhook.stub(:post) }

  describe "#post_configurator_webhook" do
    let(:client) { double(logger: double(error: true)) }

    subject { webhook_poster.post_configurator_webhook }

    context "a configurator webhook url" do
      before { stub_const("ENV", { "CONFIGURATOR_WEBHOOK_URL" => "Foo" }) }

      context "a valid url" do
        it "posts via Webhook" do
          Webhook.should_receive(:post)
          subject
        end
      end

      context "an argument error" do
        before { Webhook.stub(:post).and_raise(ArgumentError.new) }

        it { should be_truthy }
      end

      context "a runtime error" do
        before { Webhook.stub(:post).and_raise(RuntimeError.new) }

        it { should be_truthy }
      end
    end

    context "no configurator webhook url" do
      before { stub_const("ENV", { "CONFIGURATOR_WEBHOOK_URL" => nil }) }

      it "does not post via Webhook" do
        Webhook.should_not_receive(:post)
        subject
      end
    end
  end

  describe 'JOBS_URL not set' do
    let(:client) { Fabricate(:client)}

    before do
      allow(webhook_poster).to receive(:jobs_url).and_return(nil)
    end

    it 'does not post to jobs' do
      Webhook.should_not_receive(:post).with(
          "/foo", client_uid: "https://g5-hub.herokuapp.com/clients/#{client.urn}")
      webhook_poster.post_client_update_webhooks
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
    let(:jobs_url) {'https://get-a-job.com'}
    let(:inventory_etl_url) {'https://get-an-inventory-etl.com'}
    let(:vendor_leads_url) {'https://get-a-vendor-lead.com'}

    before do
      allow(webhook_poster).to receive(:jobs_url).and_return(jobs_url)
      allow(webhook_poster).to receive(:inventory_etl_url).and_return(inventory_etl_url)
      allow(webhook_poster).to receive(:vendor_leads_url).and_return(vendor_leads_url)
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

      it "posts to jobs" do
        Webhook.should_receive(:post).with(
            "#{jobs_url}/foo", client_uid: "https://g5-hub.herokuapp.com/clients/#{client.urn}")
      end

      it "posts to inventory-etl" do
        Webhook.should_receive(:post).with(
            "#{inventory_etl_url}/foo", client_uid: "https://g5-hub.herokuapp.com/clients/#{client.urn}")
      end

      it "posts to inventory-etl" do
        Webhook.should_receive(:post).with(
            "#{vendor_leads_url}/foo", client_uid: "https://g5-hub.herokuapp.com/clients/#{client.urn}")
      end
    end

    context "an argument error" do
      before { Webhook.stub(:post).and_raise(ArgumentError.new) }

      it { should be_truthy }
    end

    context "a runtime error" do
      before { Webhook.stub(:post).and_raise(RuntimeError.new) }

      it { should be_truthy }
    end
  end
end

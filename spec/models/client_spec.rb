require 'spec_helper'

describe Client do
  let(:client) { Fabricate(:client, id: 123) }

  it { client.should be_valid }

  describe "Identifiers" do
    before do
      Time.any_instance.stub(:to_i) { 1325404800 }
    end

    it { client.hashed_id.should eq "gwvrsozf" }
    it { client.record_type.should eq "g5-c"}
    it { client.urn.should eq "g5-c-gwvrsozf-#{client.name.parameterize}"}
    it { client.to_param.should eq client.urn }
  end

  describe "Validates Required Fields" do
    it "is not valid without name" do
      client.name = ""
      client.should_not be_valid
    end

    it "needs a vertical" do
      client.vertical = ""
      client.should_not be_valid
    end

    it "needs a vertical from the preset list" do
      client.vertical = "lol not a real vertical"
      client.should_not be_valid
    end

    it "must have a city" do
      client.city = ""
      client.should_not be_valid

    end

    it "must have a state" do
      client.state = ""
      client.should_not be_valid
    end
  end

  describe ".accepts_nested_attributes_for :locations" do
    it "creates location if location has a name" do
      attributes = { locations_attributes: [ Fabricate.attributes_for(:location) ] }
      expect { client.update_attributes(attributes) }.to change(Location, :count).by(1)
    end
    it "does not create location if location does not have a name" do
      attributes = { locations_attributes: [ { } ] }
      expect { client.update_attributes(attributes) }.to change(Location, :count).by(0)
    end
  end
  describe "#post_webhook" do
    it "returns nil if no url" do
      ENV["G5_CONFIGURATOR_WEBHOOK_URL"] = nil
      client.send(:post_webhook).should eq nil
    end
    it "posts webhook if url" do
      ENV["G5_CONFIGURATOR_WEBHOOK_URL"] = "http://foo.bar"
      Webhook.stub(:post).and_return("OK")
      client.send(:post_webhook).should eq "OK"
    end
    it "swallows argument errors" do
      ENV["G5_CONFIGURATOR_WEBHOOK_URL"] = "http://foo.bar"
      Webhook.stub(:post).and_raise(ArgumentError.new)
      client.send(:post_webhook).should eq true
    end
  end
end

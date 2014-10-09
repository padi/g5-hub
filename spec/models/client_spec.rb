require 'rails_helper'

describe Client do
  let(:client) { Fabricate(:client, id: 123) }

  it { expect(client).to be_valid }

  it { is_expected.to have_one :clients_integration_setting }

  describe "Identifiers" do
    before do
      Time.any_instance.stub(:to_i) { 1325404800 }
    end

    it { expect(client.hashed_id).to eq "gwvrsozf" }
    it { expect(client.urn).to eq "g5-c-gwvrsozf-#{client.name.parameterize}" }
    it { expect(client.to_param).to eq client.urn }
  end

  describe "Validates Required Fields" do
    it "is not valid without name" do
      client.name = ""
      expect(client).to_not be_valid
    end

    it "needs a vertical" do
      client.vertical = ""
      expect(client).to_not be_valid
    end

    it "needs a vertical from the preset list" do
      client.vertical = "lol not a real vertical"
      expect(client).to_not be_valid
    end

    it "must have a city" do
      client.city = ""
      expect(client).to_not be_valid
    end

    it "must have a state" do
      client.state = ""
      expect(client).to_not be_valid
    end

    it "validates presence of domain type" do
      client.domain_type = ""
      expect(client).to_not be_valid
    end

    it "validates domain type is included in DOMAIN_TYPES" do
      client.domain_type = "SomeOtherClient"
      expect(client).to_not be_valid
    end
  end

  describe ".accepts_nested_attributes_for :locations" do
    it "creates location if location has a name" do
      attributes = {locations_attributes: [Fabricate.attributes_for(:location)]}
      expect { client.update_attributes(attributes) }.to change(Location, :count).by(1)
    end
    it "does not create location if location does not have a name" do
      attributes = {locations_attributes: [{}]}
      expect { client.update_attributes(attributes) }.to change(Location, :count).by(0)
    end
  end

  describe "#cms_url" do
    let(:client) { Fabricate.build(:client, urn: urn) }
    let(:urn) { "g5-c-foo" }

    subject { client.cms_url }

    it { is_expected.to eq("https://g5-cms-foo.herokuapp.com") }
  end
end

require 'spec_helper'

describe Client do
  let(:client) { Fabricate(:client, id: 123) }

  it { client.should be_valid }

  describe "Identifiers" do
    before do
      Time.any_instance.stub(:to_i) { 1325404800 }
    end

    it { client.hashed_id.should eq "gwvrsozf" }
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

    it "validates presence of domain type" do
      client.domain_type = ""
      client.should_not be_valid
    end

    it "validates domain type is included in DOMAIN_TYPES" do
      client.domain_type = "SomeOtherClient"
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

  describe "#cms_url" do
    let(:client) { Fabricate.build(:client, urn: urn) }
    let(:urn) { "g5-c-foo" }

    subject { client.cms_url }

    it { should eq("https://g5-cms-foo.herokuapp.com") }

    context "a super long urn" do
      let(:urn) { "g5-c-1slhp2tc-compass-rock-real-estate" }

      it { should eq("https://g5-cms-1slhp2tc-compass-rock-r.herokuapp.com") }
    end
  end
end

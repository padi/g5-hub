require "rails_helper"

describe HerokuAppNameFormatter do
  let(:client) { Fabricate.build(:client, urn: urn) }
  let(:urn) { "g5-c-foo" }
  let(:heroku_app_name_formatter) { HerokuAppNameFormatter.new(client) }

  describe "#formatted_cms_app_name" do
    subject { heroku_app_name_formatter.formatted_cms_app_name }

    context "a short urn" do
      it { should eq("g5-cms-foo") }
    end

    context "a super long urn" do
      let(:urn) { "g5-c-1slhp2tc-compass-rock-real-estate" }

      it { should eq("g5-cms-1slhp2tc-compass-rock-r") }
    end

    context "a turncated urn that would result in a trailing dash" do
      let(:urn) { "g5-c-1slhp2tc-compass-rocks-real-estate" }

      it { should eq("g5-cms-1slhp2tc-compass-rocks") }
    end
  end

  describe "#formatted_cms_url" do
    subject { heroku_app_name_formatter.formatted_cms_url }

    context "a short urn" do
      it { should eq("https://g5-cms-foo.herokuapp.com") }
    end

    context "a super long urn" do
      let(:urn) { "g5-c-1slhp2tc-compass-rock-real-estate" }

      it { should eq("https://g5-cms-1slhp2tc-compass-rock-r.herokuapp.com") }
    end

    context "a turncated urn that would result in a trailing dash" do
      let(:urn) { "g5-c-1slhp2tc-compass-rocks-real-estate" }

      it { should eq("https://g5-cms-1slhp2tc-compass-rocks.herokuapp.com") }
    end
  end
end

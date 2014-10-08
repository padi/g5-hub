require 'spec_helper'

describe Location do
  it { should have_many :locations_integration_settings }

  let(:location) { Fabricate(:location, id: 123) }

  it { location.should be_valid }

  describe "Identifiers" do
    before do
      Time.any_instance.stub(:to_i) { 1325404800 }
    end

    it { location.hashed_id.should eq "gwvrsozf" }
    it { location.urn.should eq "g5-cl-gwvrsozf-#{location.name.parameterize}"}
    it { location.to_param.should eq location.urn }
  end
end

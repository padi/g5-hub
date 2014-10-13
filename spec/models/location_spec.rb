require 'rails_helper'

describe Location do
  let(:location) { Fabricate(:location, id: 123) }

  it { should have_many :locations_integration_settings }
  it { expect(location).to be_valid }
  it { should validate_inclusion_of(:status).in_array(Location::STATUS_TYPES) }

  describe "Identifiers" do
    before do
      Time.any_instance.stub(:to_i) { 1325404800 }
    end

    it { expect(location.hashed_id).to eq "gwvrsozf" }
    it { expect(location.urn).to eq "g5-cl-gwvrsozf-#{location.name.parameterize}" }
    it { expect(location.to_param).to eq location.urn }
  end
end

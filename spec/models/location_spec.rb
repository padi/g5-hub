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

  describe "Geocoding" do
    context "lat long lookup" do
      let(:location) { Fabricate(:location, street_address_1: "49 Baldwin Ave", city: "Paia", state: "HI", latitude: nil, longitude: nil) }
      it { expect(location.latitude).should_not be_nil}
      it { expect(location.longitude).should_not be_nil}
    end

    context "manual lat long override" do
      let(:location) { Fabricate(:location, street_address_1: "49 Baldwin Ave", city: "Paia", state: "HI", latitude: 22, longitude: -157) }
      it { expect(location.latitude).to eq(22)}
      it { expect(location.longitude).to eq(-157)}
    end
  end
end

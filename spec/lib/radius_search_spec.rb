require "rails_helper"

describe RadiusSearch do
  let(:client) { Fabricate.build(:client) }

  let!(:location1) { Fabricate(:location, client: client, latitude: 20.917825, longitude: -156.370170) } # Paia
  let!(:location2) { Fabricate(:location, client: client, latitude: 20.900060, longitude: -156.373474) } # Paia
  let!(:location3) { Fabricate(:location, client: client, latitude: 20.982266, longitude: -156.672552) } # Napili
  let!(:location4) { Fabricate(:location, client: client, latitude: 45.707492, longitude: -121.521939) } # Hood River
  let!(:location5) { Fabricate(:location, client: client, latitude: 44.057465, longitude: -121.313513) } # Bend

  let(:radius_search) { RadiusSearch.new(client, []) }

  describe "#locations" do
    subject { radius_search.locations }

    context "googus" do
      it { should include(location1) }
    end

    context "gigity" do
      it { should include(location5) }
    end
  end
end
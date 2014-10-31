require "rails_helper"

describe RadiusSearch do
  let(:client) { Fabricate.build(:client) }

  let!(:location1) { Fabricate(:location, client: client, latitude: 20.917825, longitude: -156.370170) } # Paia
  let!(:location2) { Fabricate(:location, client: client, latitude: 20.900060, longitude: -156.373474) } # Paia
  let!(:location3) { Fabricate(:location, client: client, latitude: 20.982266, longitude: -156.672552) } # Napili
  let!(:location4) { Fabricate(:location, client: client, latitude: 45.707492, longitude: -121.521939) } # Hood River
  let!(:location5) { Fabricate(:location, client: client, latitude: 44.057465, longitude: -121.313513) } # Bend

  describe "#locations" do
    context "reasonable searches" do
      context "by city, state" do
        let(:params) { {search: "Kahului, HI"} }
        let(:radius_search) { RadiusSearch.new(client, params) }

        subject { radius_search.locations }
        it { should include(location1, location2, location3) }
        it { should_not include(location4, location5) }
      end

      context "by zip" do
        let(:params) { {search: "97701"} }
        let(:radius_search) { RadiusSearch.new(client, params) }

        subject { radius_search.locations }
        it { should include(location5) }
        it { should_not include(location1, location2, location3, location4) }
      end

      context "with custom radius" do
        let(:params) { {search: "Paia, HI", radius: 10} }
        let(:radius_search) { RadiusSearch.new(client, params) }

        subject { radius_search.locations }
        it { should include(location1, location2) }
        it { should_not include(location3, location4, location5) }
      end

      context "empty results" do
        let(:params) { {search: "Talkeetna, AK", radius: 10} }
        let(:radius_search) { RadiusSearch.new(client, params) }

        subject { radius_search.locations }
        it { should be_empty }
      end
    end

    context "unreasonable searches" do
      let(:params) { {search: "something strange #/.e3@%$", radius: "dfkslj"} }
      let(:radius_search) { RadiusSearch.new(client, params) }

      subject { radius_search.locations }
      it { should be_empty }
    end
  end

  describe "#results" do
    context "successful search" do
      let(:params) { {search: "Bend, OR"} }
      let(:radius_search) { RadiusSearch.new(client, params) }

      subject { radius_search.results }
      it { should include(success: true) }
      it { should include(:locations) }
      it { expect(subject[:locations].size).to eq(1) }
    end

    context "unsuccessful search" do
      let(:params) { {search: "Talkeetna, AK"} }
      let(:radius_search) { RadiusSearch.new(client, params) }

      subject { radius_search.results }
      it { should include(success: false) }
      it { should include(:locations) }
      it { expect(subject[:locations].size).to eq(5) }
    end
  end
end

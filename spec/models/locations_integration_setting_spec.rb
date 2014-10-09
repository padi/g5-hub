require 'rails_helper'

describe LocationsIntegrationSetting do
  it { is_expected.to belong_to :location }
  it { is_expected.to belong_to :clients_integration_setting }
  it { is_expected.to belong_to :integration_setting }
  it { is_expected.to accept_nested_attributes_for(:integration_setting) }

  describe 'location / clients_integration_setting uniqueness' do
    let(:location) { Fabricate(:location) }
    let!(:first) { Fabricate(:locations_integration_setting, location: location) }
    let(:second) { Fabricate.build(:locations_integration_setting, location: location, clients_integration_setting: first.clients_integration_setting) }

    it 'does not allow duplicates' do
      expect(second).to_not be_valid
      expect(second.errors[:location_id]).to eq(['has already been taken'])
    end
  end
end
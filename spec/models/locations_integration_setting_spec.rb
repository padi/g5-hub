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

  describe 'Identifiers' do
    let(:location) { Fabricate(:location) }
    let(:locations_integration_setting) { Fabricate(:locations_integration_setting, location: location) }

    before do
      Time.any_instance.stub(:to_i) { 1325404800 }
    end

    it { expect(locations_integration_setting.hashed_id).to eq "#{locations_integration_setting.created_at.to_i}#{locations_integration_setting.id}".to_i.to_s(36) }
    it { expect(locations_integration_setting.urn).to eq "g5-lis-#{locations_integration_setting.hashed_id}" }
    it { expect(locations_integration_setting.to_param).to eq locations_integration_setting.urn }
  end
end
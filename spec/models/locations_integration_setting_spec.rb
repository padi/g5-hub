require 'spec_helper'

describe LocationsIntegrationSetting do
  it { should belong_to :location }
  it { should belong_to :clients_integration_setting }
  it { should belong_to :integration_setting }
  it { should accept_nested_attributes_for(:integration_setting) }

  describe 'location / clients_integration_setting uniqueness' do
    let(:location) { Fabricate(:location) }
    let!(:first) { Fabricate(:locations_integration_setting, location: location) }
    let(:second) { Fabricate.build(:locations_integration_setting, location: location, clients_integration_setting: first.clients_integration_setting) }

    it 'does not allow duplicates' do
      second.should_not be_valid
      second.errors[:location_id].should eq(['has already been taken'])
    end
  end
end
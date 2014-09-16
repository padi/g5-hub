require 'spec_helper'

describe IntegrationSetting do
  it { should belong_to :location }
  it { should have_many :custom_integration_settings }
  it { should validate_presence_of :inventory_service_url }
  it { should validate_presence_of :etl_strategy_name }
  it { should accept_nested_attributes_for(:custom_integration_settings).allow_destroy(true) }

  describe 'custom_settings_as_hash' do
    context 'with custom_settings' do
      let(:integration_setting) do
        setting = Fabricate(:integration_setting)
        setting.custom_integration_settings.build(name: 'foo', value: 'bar')
        setting.custom_integration_settings.build(name: 'be', value: 'baz')
        setting
      end

      subject { integration_setting.custom_integration_settings_as_hash }
      its([:foo]) { should eq('bar') }
      its([:be]) { should eq('baz') }
    end

    context 'withOUT custom settings' do
      let(:integration_setting) { Fabricate(:integration_setting) }
      it 'returns empty hash' do
        expect(integration_setting.custom_integration_settings_as_hash).to eq({})
      end
    end
  end
end
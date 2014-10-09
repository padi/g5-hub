require 'rails_helper'

describe IntegrationSetting do
  it { is_expected.to have_one :clients_integration_setting }
  it { is_expected.to have_one :locations_integration_setting }
  it { is_expected.to have_many :custom_integration_settings }
  it { is_expected.to validate_presence_of :strategy_name }
  it { is_expected.to validate_presence_of :vendor_endpoint }
  it { is_expected.to accept_nested_attributes_for(:custom_integration_settings).allow_destroy(true) }

  describe 'override' do
    subject { IntegrationSetting.new(override: true) }

    it 'skips validations when override set' do
      expect(subject).to be_valid
    end
  end

  describe 'hashes' do
    context 'with custom_settings' do
      let(:integration_setting) do
        setting = Fabricate(:integration_setting)
        setting.custom_integration_settings.build(name: 'foo', value: 'bar')
        setting.custom_integration_settings.build(name: 'be', value: 'baz')
        setting
      end

      describe 'custom_integration_settings_as_hash' do
        subject { integration_setting.custom_integration_settings_as_hash }
        its([:foo]) { is_expected.to eq('bar') }
        its([:be]) { is_expected.to eq('baz') }
      end

      describe 'to_settings_hash' do
        subject { integration_setting.to_settings_hash }
        its([:foo]) { is_expected.to eq('bar') }
        its([:be]) { is_expected.to eq('baz') }
        its(['vendor_endpoint']) { is_expected.to eq(integration_setting.vendor_endpoint) }
        its(['strategy_name']) { is_expected.to eq(integration_setting.strategy_name) }
        its(['vendor_user_name']) { is_expected.to eq(integration_setting.vendor_user_name) }
        its(['vendor_password']) { is_expected.to eq(integration_setting.vendor_password) }
      end
    end

    context 'withOUT custom settings' do
      let(:integration_setting) { Fabricate(:integration_setting) }
      it 'returns empty hash' do
        expect(integration_setting.custom_integration_settings_as_hash).to eq({})
      end

      describe 'to_settings_hash' do
        subject { integration_setting.to_settings_hash }
        its(['vendor_endpoint']) { is_expected.to eq(integration_setting.vendor_endpoint) }
        its(['strategy_name']) { is_expected.to eq(integration_setting.strategy_name) }
        its(['vendor_user_name']) { is_expected.to eq(integration_setting.vendor_user_name) }
        its(['vendor_password']) { is_expected.to eq(integration_setting.vendor_password) }
      end
    end
  end
end
require 'spec_helper'

describe IntegrationSetting do
  it { should have_one :clients_integration_setting }
  it { should have_one :locations_integration_setting }
  it { should have_many :custom_integration_settings }
  it { should validate_presence_of :strategy_name }
  it { should validate_presence_of :vendor_endpoint }
  it { should accept_nested_attributes_for(:custom_integration_settings).allow_destroy(true) }

  describe 'override' do
    subject { IntegrationSetting.new(override: true) }

    it 'skips validations when override set' do
      subject.should be_valid
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
        its([:foo]) { should eq('bar') }
        its([:be]) { should eq('baz') }
      end

      describe 'to_settings_hash' do
        subject { integration_setting.to_settings_hash }
        its([:foo]) { should eq('bar') }
        its([:be]) { should eq('baz') }
        its(['vendor_endpoint']) { should eq(integration_setting.vendor_endpoint) }
        its(['strategy_name']) { should eq(integration_setting.strategy_name) }
        its(['vendor_user_name']) { should eq(integration_setting.vendor_user_name) }
        its(['vendor_password']) { should eq(integration_setting.vendor_password) }
      end
    end

    context 'withOUT custom settings' do
      let(:integration_setting) { Fabricate(:integration_setting) }
      it 'returns empty hash' do
        expect(integration_setting.custom_integration_settings_as_hash).to eq({})
      end

      describe 'to_settings_hash' do
        subject { integration_setting.to_settings_hash }
        its(['vendor_endpoint']) { should eq(integration_setting.vendor_endpoint) }
        its(['strategy_name']) { should eq(integration_setting.strategy_name) }
        its(['vendor_user_name']) { should eq(integration_setting.vendor_user_name) }
        its(['vendor_password']) { should eq(integration_setting.vendor_password) }
      end
    end
  end
end
require 'rails_helper'

describe IntegrationSetting do
  it { is_expected.to have_one :job_setting }
  it { is_expected.to have_one :clients_integration_setting }
  it { is_expected.to have_one :locations_integration_setting }
  it { is_expected.to have_many :custom_integration_settings }
  it { is_expected.to validate_presence_of :strategy_name }
  it { is_expected.to validate_presence_of :vendor_endpoint }
  it { is_expected.to accept_nested_attributes_for(:custom_integration_settings).allow_destroy(true) }
  it { is_expected.to accept_nested_attributes_for(:job_setting).allow_destroy(true) }

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
        setting.job_setting = Fabricate.build(:job_setting)
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
        its([:job_frequency_in_minutes]) { is_expected.to eq(3) }
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

  describe 'accepts_nested_attributes_for :custom_integration_settings' do
    let(:integration_setting) do
      setting = Fabricate(:integration_setting)
      setting.custom_integration_settings.create(name: 'foo', value: 'bar')
      setting
    end

    let(:custom_integration_setting) { integration_setting.custom_integration_settings.first }

    before do
      integration_setting.update_attributes(attributes)
    end

    context 'destroy flag' do
      let(:attributes) { {"custom_integration_settings_attributes" => {"0" => {name: "", _destroy: true, value: "L011", id: custom_integration_setting.id}}} }

      it 'ignores the custom integration setting' do
        expect(IntegrationSetting.find(integration_setting.id).custom_integration_settings).to be_empty
      end
    end

    context 'blank custom name' do
      let(:attributes) { {"custom_integration_settings_attributes" => {"0" => {name: "", value: "L011", id: custom_integration_setting.id}}} }

      it 'ignores the custom integration setting' do
        expect(IntegrationSetting.find(integration_setting.id).custom_integration_settings.first.name).to eq('foo')
      end
    end
  end

  describe 'accepts_nested_attributes_for :job_setting' do
    let(:integration_setting) do
      setting = Fabricate(:integration_setting)
      setting.create_job_setting(Fabricate.to_params(:job_setting, frequency: frequency))
      setting
    end

    let(:job_setting) { integration_setting.job_setting }
    let(:frequency) { 3 }

    before do
      integration_setting.update_attributes(attributes)
    end

    context 'destroy flag' do
      let(:attributes) { {"job_setting_attributes" => {_destroy: true, id: job_setting.id}} }

      it 'ignores the custom integration setting' do
        expect(IntegrationSetting.find(integration_setting.id).job_setting).to be_nil
      end
    end

    context 'blank frequency' do
      let(:attributes) { {"job_setting_attributes" => {"0" => {frequency: "", id: job_setting.id}}} }

      it 'ignores the custom integration setting' do
        expect(IntegrationSetting.find(integration_setting.id).job_setting.frequency).to eq(frequency)
      end
    end
  end
end
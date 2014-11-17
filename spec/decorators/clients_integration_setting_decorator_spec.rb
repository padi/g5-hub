require 'rails_helper'

describe ClientsIntegrationSettingDecorator do
  let(:clients_integration_setting) { Fabricate(:clients_integration_setting, client: Fabricate(:client), locations: [Fabricate(:location)]) }
  subject { clients_integration_setting.decorate }

  its(:summary) { is_expected.to eq("#{clients_integration_setting.client.name} - #{clients_integration_setting.vendor.name} - #{clients_integration_setting.vendor_action}") }

  describe 'job errors' do
    context 'when not inventory' do
      let(:clients_integration_setting) { Fabricate(:clients_integration_setting, vendor_action: ClientsIntegrationSetting::LEAD_VENDOR_ACTION) }

      its(:job_errors) { is_expected.to be_nil }
    end

    context 'when inventory' do
      context 'no errors' do
        before { expect(clients_integration_setting).to receive(:job_stat_error_count).and_return(0) }
        its(:job_errors) { is_expected.to eq("<span class=\"\">0 of 1</span>") }
      end

      context 'errors' do
        before { expect(clients_integration_setting).to receive(:job_stat_error_count).and_return(1) }
        its(:job_errors) { is_expected.to eq("<span class=\"job-error\">1 of 1</span>") }
      end
    end
  end
end
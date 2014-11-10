require 'rails_helper'

describe JobRetriever do
  let(:clients_integration_setting) { Fabricate(:clients_integration_setting).tap { |cis| cis.integration_setting.create_job_setting(Fabricate.to_params(:job_setting)) } }
  let!(:locations_integration_setting) { Fabricate(:locations_integration_setting, location: Fabricate(:location), clients_integration_setting: clients_integration_setting) }
  let!(:locations_integration_setting_2) { Fabricate(:locations_integration_setting, location: Fabricate(:location), clients_integration_setting: clients_integration_setting) }

  subject { JobRetriever.new(locations_integration_settings: clients_integration_setting.reload.locations_integration_settings) }

  describe :perform do
    let(:body) { fixture('jobs.json') }
    let(:expected) { ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(body)) }
    before do
      expect(HTTParty).to receive(:get).and_return(double(:response, body: body))
    end

    its(:perform) { is_expected.to eq(expected) }
  end

  its (:locations_as_parameter) { is_expected.to eq("[#{locations_integration_setting.uid},#{locations_integration_setting_2.uid}]") }

  describe :jobs_url_for_locations do
    it 'filters by current and locations_integration_setting UIDs' do
      expect(subject).to receive(:locations_as_parameter).and_return('loc_param')
      expect(subject.jobs_url_for_locations).to match(/\/api\/v1\/jobs\?current=true&integration_setting_uid=loc_param/)
    end
  end
end
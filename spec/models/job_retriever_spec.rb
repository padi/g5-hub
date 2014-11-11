require 'rails_helper'

describe JobRetriever do
  let(:clients_integration_setting) { Fabricate(:clients_integration_setting).tap { |cis| cis.integration_setting.create_job_setting(Fabricate.to_params(:job_setting)) } }
  let!(:locations_integration_setting) { Fabricate(:locations_integration_setting, location: Fabricate(:location), clients_integration_setting: clients_integration_setting) }
  let!(:locations_integration_setting_2) { Fabricate(:locations_integration_setting, location: Fabricate(:location), clients_integration_setting: clients_integration_setting) }

  subject { JobRetriever.new(locations_integration_settings: clients_integration_setting.reload.locations_integration_settings) }

  describe :perform do
    let(:body) { fixture('jobs.json') }
    let(:body_hash) { ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(body))[:jobs] }
    let(:token) { 'the toke' }
    before do
      expect(G5AuthenticationClient::Client).to receive(:new).and_return(double(:token, get_access_token: token))
      expect(HTTParty).to receive(:get).with(subject.jobs_url_for_locations,
                                             {query:   {access_token: token},
                                              headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'}}).
                              and_return(double(:response, body: body))
    end
    it 'returns array of jobs' do
      result = subject.perform
      expect(result.length).to eq(2)
      expect(result.all? { |job| Job == job.class }).to be_truthy
      expect(result.collect(&:integration_setting_uid)).to eq(%w(http://localhost/clients/g5-c-6i4h3un-ethan-bode/locations/g5-cl-6i4h3uo-zoe-krajcik/locations_integration_settings/g5-lis-6i4h3uo http://localhost/clients/g5-c-6i4h3un-ethan-bode/locations/g5-cl-6i4h3un-retha-hane/locations_integration_settings/g5-lis-6i4h3un))
    end
  end

  its (:locations_as_parameter) { is_expected.to eq("[#{locations_integration_setting.uid},#{locations_integration_setting_2.uid}]") }

  describe :jobs_url_for_locations do
    it 'filters by current and locations_integration_setting UIDs' do
      expect(subject).to receive(:locations_as_parameter).and_return('loc_param')
      expect(subject.jobs_url_for_locations).to match(/\/api\/v1\/jobs\?current=true&integration_setting_uid=loc_param/)
    end
  end
end
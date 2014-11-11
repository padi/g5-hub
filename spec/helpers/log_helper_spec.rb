require 'rails_helper'

describe LogHelper do
  describe 'log_url_by_job' do
    context 'LOGS_BY_JOB_URL set' do
      it 'generates proper url' do
        expect(helper).to receive(:logs_by_job_url).at_least(:once).and_return('http://splunk.com?external_id={{JOB_ID}}')
        expect(helper.logs_url_by_job(OpenStruct.new(urn: 3))).to eq('http://splunk.com?external_id=3')
      end
    end

    context 'LOGS_BY_JOB_URL NOT set' do
      it 'generates proper url' do
        expect(helper).to receive(:logs_by_job_url).and_return(nil)
        expect(helper.logs_url_by_job(OpenStruct.new(urn: 3))).to eq('ENV[LOGS_BY_JOB_URL] not set!')
      end
    end
  end
end

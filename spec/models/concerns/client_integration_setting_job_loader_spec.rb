require 'rails_helper'

describe ClientIntegrationSettingJobLoader do
  let(:clients_integration_setting) { Fabricate(:clients_integration_setting).tap { |cis| cis.integration_setting.create_job_setting(Fabricate.to_params(:job_setting)) } }
  let(:locations_integration_setting) { Fabricate(:locations_integration_setting, location: Fabricate(:location), clients_integration_setting: clients_integration_setting) }

  describe :load_current_jobs_by_location do
    subject { clients_integration_setting }

    its(:load_current_jobs_by_location) { is_expected.to be_nil }
  end
end